sub init()
    m.top.observeField("visible", "onVisibilityChanged")

    ' m.isUpKeyPressed = false
    ' m.isDownKeyPressed = false
    'If first time firstVideoMUG gets focus
    m.isFirstTimeFirstVideoMUGGetsFocus = true

    m.startingCountDown = m.top.findNode("startingCountDown")
    m.startingCountDown.observeField("fire", "onTimerFired")
    m.countDownValue = 10

    m.firstVideoMUG = m.top.findNode("firstVideoMUG")
    
    m.firstVideoMUG.observeField("itemFocused", "onFirstVideoMUGFocused")
    m.firstVideoMUG.observeField("itemUnfocused", "onFirstVideoMUGUnfocused")
    m.firstVideoMUG.observeField("itemSelected", "onFirstVideoMUGSelected")
    'm.isPreviouslyFirstVideoMUGFocused = false

    m.secondVideoMUG = m.top.findNode("secondVideoMUG")
    m.secondVideoMUG.observeField("itemFocused", "onSecondVideoMUGFocused")
    m.secondVideoMUG.observeField("itemUnfocused", "onSecondVideoMUGUnfocused")
    m.secondVideoMUG.observeField("itemSelected", "onSecondVideoMUGSelected")
    m.isSecondVideoSelected = false
    'm.isPreviouslySecondVideoMUGFocused = false

    m.outerLayoutGroup = m.top.findNode("outerLayoutGroup")

    m.isFirstTimeFirstVideoMUGGotFocused = true
    m.isFirstTimeInsideOnSecondVideoMUGFocused = true

    'For handling onSecondVideoMUGFocused()
    'm.isFirstTimeInsideOnSecondVideoMUGFocused = true
    ' m.totalScreenWidth = 1920
    ' m.totalWidthOccByFirstMUG = m.firstVideoMUG.itemSize[0] + m.outerLayoutGroup.itemSpacings[0]
    
    ' m.totalWidthOccBySecondMUG = m.totalScreenWidth - m.outerLayoutGroup.translation[0] - m.totalWidthOccByFirstMUG
    ' m.minWidthOfSecondMUGWhereNoTranslation = m.totalWidthOccBySecondMUG

    m.sizeOfAnItem = m.secondVideoMUG.itemSpacing[0] + m.secondVideoMUG.itemSize[0]
    m.sizeOfNextVideoToBeVisible = 50

    m.isCountDownFirstTime = true 
    renderFirstVideoComponent()
    renderSecondVideoComponent()

end sub

sub startCountDown()
    print "startCountDown()"
    if m.isCountDownFirstTime
        m.firstVideoChildContent.action = "startCountDown"
        m.startingCountDown.control = "start"
    end if
    
end sub
sub stopCountDown()
    print "stopCountDown()"
    m.countDownValue = 10
    stopFirstVideo()
    m.startingCountDown.control = "stop"
end sub

sub onTimerFired()
    print "onTimerFired()"
    m.firstVideoChildContent.action = "startCountDown"
    m.firstVideoChildContent.countDownValue = m.countDownValue
    m.countDownValue = m.countDownValue - 1

    if m.countDownValue = -1
        stopCountDown()
        m.gridItemSelected = "firstVideoMUG"
        parentDataDetails = {
            "action": "componentCreation",
            "componentName": "fullScreenVideoComponent"
            "pageData": "firstVideoPageData"
        }
        updateToParentData(parentDataDetails)
    end if
end sub

sub onFirstVideoMUGUnfocused()
    stopCountDown()
    stopFirstVideo()
end sub

sub onSecondVideoMUGUnfocused()

    m.previousFocusedColumn = m.secondVideoMUG.itemUnfocused

    if m.previousFocusedColumn >= m.secondVideoMUG.numColumns
        m.previousFocusedColumn = m.previousFocusedColumn - m.secondVideoMUG.numColumns
    end if

    stopSecondVideo()
end sub

sub onFirstVideoMUGFocused()
    playFirstVideo()
end sub

sub onSecondVideoMUGFocused()
    if m.isSecondVideoSelected
        m.isSecondVideoSelected = false
        return
        'If the video in secondVideoMUG is selected, it plays in full screen. After that,
        ' when back key is pressed, again the video gets focus and the translation 
        'occurs which should not be because, in the beginning, when the video gets focus,
        ' the translation has already occurred. So, it should not occur again. So, without the 
        ' translation getting done, this function returns control.
    end if
    
    if m.isFirstTimeInsideOnSecondVideoMUGFocused
        m.isFirstTimeInsideOnSecondVideoMUGFocused = false
        m.previousFocusedColumn = 0
    end if

    m.focusedItemIndex = m.secondVideoMUG.itemFocused
    m.focusedItem = m.secondVideoMUG.content.getChild(m.focusedItemIndex)
    m.lastFocusedItemOfSecondVideo = m.focusedItem  
    focusedCol = m.secondVideoMUG.currFocusColumn
    m.spaceToMove = 0
    
    if m.secondVideoMUG.horizFocusDirection = "right"
        m.spaceToMove = m.sizeOfAnItem * (focusedCol - m.previousFocusedColumn)
        parentDataDetails = {
            "action": "moveScreen",
            "component": "searchComponent"
            "direction": "right",
            "spaceToMove": m.spaceToMove
        }
        updateToParentData(parentDataDetails)
    else if m.secondVideoMUG.horizFocusDirection = "left"
        
        m.spaceToMove = m.sizeOfAnItem * (m.previousFocusedColumn - focusedCol)
        parentDataDetails = {
            "action": "moveScreen",
            "component": "searchComponent"
            "direction": "left",
            "spaceToMove": m.spaceToMove
        }
        updateToParentData(parentDataDetails)
    else if m.secondVideoMUG.horizFocusDirection = "none"

        ' if m.isUpKeyPressed or m.isDownKeyPressed
        '     m.isUpKeyPressed = false
        '     m.isDownKeyPressed = false
        '     return
        ' end if

        if m.secondVideoMUG.hasFocus()
            
            if m.previousFocusedColumn <> focusedCol
                
                if m.previousFocusedColumn - focusedCol > 0
                    print "m.previousFocusedColumn - focusedCol > 0"
                    print "m.previousFocusedColumn: "m.previousFocusedColumn
                    print "focusedCol: "focusedCol
                    m.spaceToMove = m.sizeOfAnItem * (m.previousFocusedColumn - focusedCol)
                    parentDataDetails = {
                        "action": "moveScreen",
                        "component": "searchComponent"
                        "direction": "left",
                        "spaceToMove": m.spaceToMove
                    }
                    updateToParentData(parentDataDetails)
                else
                    print "m.previousFocusedColumn - focusedCol <= 0"
                    print "m.previousFocusedColumn: "m.previousFocusedColumn
                    print "focusedCol: "focusedCol
                    m.spaceToMove = m.sizeOfAnItem * (focusedCol - m.previousFocusedColumn)
                    parentDataDetails = {
                        "action": "moveScreen",
                        "component": "searchComponent"
                        "direction": "right",
                        "spaceToMove": m.spaceToMove
                    }
                    updateToParentData(parentDataDetails)
                end if
            end if
        end if
        
    end if
    
    playSecondVideo()
end sub

function getFirstVideoPageData() as object
    pageData = {
        "title": m.firstVideoChildContent.firstVideoTitle,
        "control": m.firstVideoChildContent.firstVideoControl,
        "url": m.firstVideoChildContent.firstVideoUrl,
        "streamFormat": m.firstVideoChildContent.firstVideoStreamFormat
    }
    return pageData
end function

sub onFirstVideoMUGSelected()
    m.gridItemSelected = "firstVideoMUG"
    m.isCountDownFirstTime = false
    m.countDownValue = 10
    stopCountDown()
    stopFirstVideo()
    m.top.toParentData = {
        "action": "componentCreation",
        "componentName": "fullScreenVideoComponent"
        "pageData": getFirstVideoPageData()
    }
end sub

sub handleAfterOnFirstVideoMUGSelected()
    if m.gridItemSelected = "firstVideoMUG"
        m.firstVideoMUG.setFocus(true)
        playFirstVideo()
    else if m.gridItemSelected = "secondVideoMUG"
        m.secondVideoMUG.setFocus(true)
        playSecondVideo()
    end if
end sub

function getSecondVideoPageData() as object
    m.secondVideoSelectedIndex = m.secondVideoMUG.itemSelected
    m.secondVideoSelected = m.secondVideoMUG.content.getChild(m.secondVideoMUG.itemSelected)
    pageData = {
        "title": m.secondVideoSelected.secondVideoTitle,
        "control": m.secondVideoSelected.secondVideoControl,
        "url": m.secondVideoSelected.secondVideoUrl,
        "streamFormat": m.secondVideoSelected.secondVideoStreamFormat
    }
    return pageData
end function

sub onSecondVideoMUGSelected()
    print "onSecondVideoMUGSelected()"
    m.isSecondVideoSelected = true
    m.gridItemSelected = "secondVideoMUG"
    
    ' m.secondVideoSelected.secondVideoControl = "stop"
    print "m.secondVideoSelected: "m.secondVideoSelected
    print "to parent data assigned"
   

    ' m.secondVideoSelected.secondTimeRenderingSecondVideo = {
    '     "isSecondTime": true
    '     "control": "stop"
    ' }
    stopSecondVideo()
    parentDataDetails = {
        "action": "componentCreation",
        "componentName": "fullScreenVideoComponent"
        "pageData": "secondVideoPageData"
        
    }
    updateToParentData(parentDataDetails)
    
end sub
' sub onSecondVideoMUGFocused()
'     print "Inside onSecondVideoMUGFocused()"
'     print "onSecondVideoMUGFocused()"
'     m.focusedItemIndex = m.secondVideoMUG.itemFocused
'     if m.previouslyFocusedSecondVideoItemIndex = -1
'         m.previouslyFocusedSecondVideoItemIndex = 0
'     end if
'     print "m.focusedItemIndex: "m.focusedItemIndex

'     if m.focusedItemIndex <> 0 or m.focusedItemIndex <> 3
'         print "......................"
'         print "Inside IF"
'         print "m.previouslyFocusedSecondVideoItemIndex : "m.previouslyFocusedSecondVideoItemIndex 
'         print "m.focusedItemIndex: "m.focusedItemIndex

'         ' moveScreen()        
'     end if

'     m.focusedItem = m.secondVideoMUG.content.getChild(m.focusedItemIndex)
'     m.lastFocusedItemOfSecondVideo = m.focusedItem
'     m.focusedItem.secondTimeRenderingSecondVideo = {
'         "isSecondTime": true
'         "control": "play"
'     }
' end sub

function getFirstVideoDetails() as object
    firstVideoDetails = {
        "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
        "title" : "Test Video",
        "streamformat" : "hls",
        "control": "play",
        "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
    }
    return firstVideoDetails
end function

function getSecondVideoDetails() as object
    secondVideoDetails = [
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 1",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 2",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 3",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 4",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 5",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 6",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 1",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 2",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 3",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 4",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 5",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        },
        {
            "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
            "title" : "Test Video 6",
            "streamformat" : "hls",
            "control": "none",
            "desc": "300: Rise of an Empire is a 2014 American epic action film directed by Noam Murro."
        }
    ]
    return secondVideoDetails
end function


sub renderFirstVideoComponent()

    print "renderFirstVideoComponent()"

    firstVideoDetails = getFirstVideoDetails()
    m.firstVideoParentContent = CreateObject("roSGNode", "ContentNode")
    m.firstVideoChildContent = m.firstVideoParentContent.createChild("firstVideoItemField")
    m.firstVideoChildContent.firstVideoUrl = firstVideoDetails.url
    m.firstVideoChildContent.firstVideoTitle = firstVideoDetails.title
    m.firstVideoChildContent.firstVideoStreamFormat = firstVideoDetails.streamFormat
    m.firstVideoChildContent.firstVideoControl = firstVideoDetails.control
    m.firstVideoChildContent.firstVideoDuration = "2:50"
    m.firstVideoChildContent.firstVideoDesc = firstVideoDetails.desc
    m.firstVideoChildContent.action = "initialRendering"
    m.firstVideoMUG.content = m.firstVideoParentContent
    print "Rendered firstVideoComponent"

end sub

sub renderSecondVideoComponent()
    print "renderSecondVideoComponent()"
    secondVideoDetails = getSecondVideoDetails()
    m.secondVideoParentContent = CreateObject("roSGNode", "ContentNode")
    for each item in secondVideoDetails
        print "Inside for loop!!!!"
        m.secondVideoChildContent = m.secondVideoParentContent.createChild("secondVideoItemField")
        m.secondVideoChildContent.secondVideoUrl = item.url
        m.secondVideoChildContent.secondVideoTitle = item.title
        m.secondVideoChildContent.secondVideoStreamFormat = item.streamFormat
        m.secondVideoChildContent.secondVideoDuration = "2:50"
        m.secondVideoChildContent.secondVideoDesc = item.desc
        m.secondVideoChildContent.secondVideoAction = "initialRendering"
    end for
    print "setting content"
    m.secondVideoMUG.content = m.secondVideoParentContent
end sub

sub setFocusToFirstVideo()
    m.firstVideoMUG.setFocus(true)
end sub

sub setFocusToSecondVideo()
    m.secondVideoMUG.setFocus(true)
end sub

sub onSetFocus(event)
    
    print "inside: onSetFocus()"
    ' if m.isFirstTimeFirstVideoMUGGetsFocus
    '     m.isFirstTimeFirstVideoMUGGetsFocus = false
    '     setFocusToFirstVideo()
    ' end if
    ' renderFirstVideoComponent()
    ' renderSecondVideoComponent()
    ' if m.isPreviouslySecondVideoMUGFocused
    '     setFocusToSecondVideo()
    '     return
    ' else if m.isPreviouslyFirstVideoMUGFocused
    '     startCountDown()
    '     setFocusToFirstVideo()
    '     return
    ' end if
    
    if event.getData()
        startCountDown()
        'renderFirstVideoComponent()
        setFocusToFirstVideo()
        'playFirstVideo()
        ' print "if event.getData()"
        ' m.firstVideoMUG.setFocus(true)
        ' ' m.firstVideoChildContent.action = "startCountDown"
        ' print "About to start countdown!"
        ' startCountDown()
        ' print "ABOUT TO PLAYVIDEO()"
        ' playFirstVideo()
        ' print "AFTER PLAYVIDEO()"
        ' print "playFirstVideo(): executed"
    else
        stopCountDown()
        stopFirstVideo()
    end if
    
    ' print "m.firstVideoMUG.hasFocus(): "m.firstVideoMUG.hasFocus()
    ' m.firstVideoChildContent.firstVideoControl = "play"
    ' print "m.secondVideoMUG: "m.secondVideoMUG.hasFocus()
end sub

sub stopFirstVideo()
    m.isFirstVideoPlaying = false
    m.firstVideoChildContent.action = "stopVideo"
    ' m.firstVideoChildContent.secondTimeRenderingFirstVideo = {
    '     "isSecondTime": true
    '     "control": "stop"
    ' }
end sub

' sub onPlayFirstVideoSetToTrue()
'     m.firstVideoMUG.setFocus(true)
'     playFirstVideo()
' end sub

sub playFirstVideo()
    print "Inside playFirstVideo()"
    m.isFirstVideoPlaying = true
    m.firstVideoChildContent.action = "playVideo"
    ' m.firstVideoChildContent.secondTimeRenderingFirstVideo = {
    '     "isSecondTime": true
    '     "control": "play"
    ' }
    print "end playFirstVideo()"
end sub

sub updateToParentData(data as object)
    if data.action = "componentCreation"
        if data.pageData = "firstVideoPageData"
            m.top.toParentData = {
                "action": "componentCreation",
                "componentName": "fullScreenVideoComponent"
                "pageData": getFirstVideoPageData()
                
            }
        else if data.pageData = "secondVideoPageData"
            m.top.toParentData = {
                "action": "componentCreation",
                "componentName": "fullScreenVideoComponent"
                "pageData": getSecondVideoPageData()
                
            }
        end if
    else if data.action = "moveScreen"
        m.top.toParentData = data
    end if
end sub

sub playSecondVideo()
    m.isSecondVideoPlaying = true
    m.lastFocusedItemOfSecondVideo.secondVideoAction = "playVideo"
end sub
sub stopSecondVideo()
    m.isSecondVideoPlaying = false
    m.lastFocusedItemOfSecondVideo.secondVideoAction = "stopVideo"
end sub

sub handleWhenUpPressed()
    if m.firstVideoMUG.hasFocus()
        m.gridItemSelected = "firstVideoMUG"
    else
        m.gridItemSelected = "secondVideoMUG"
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "left"
            print "left clicked"
            if m.firstVideoMUG.hasFocus()
                parentDataDetails = {
                    "action": "moveScreen"
                    "direction": "original",
                    "component": "searchComponent",
                    "spaceToMove": 0
                }
                updateToParentData(parentDataDetails)
                ' m.top.toParentData = {
                '     "action": "moveScreen"
                '     "direction": "original",
                '     "component": "searchComponent",
                '     "spaceToMove": 0
                ' }
                stopCountDown()
                stopFirstVideo()
                return false
            else if m.secondVideoMUG.hasFocus()
                stopSecondVideo()
                m.previousFocusedColumn = 0
                parentDataDetails = {
                    "action": "moveScreen"
                    "direction": "original",
                    "component": "searchComponent",
                    "spaceToMove": 0
                }
                updateToParentData(parentDataDetails)
                ' m.top.toParentData = {
                '     "action": "moveScreen"
                '     "direction": "original",
                '     "component": "searchComponent",
                '     "spaceToMove": 0
                ' }
                startCountDown()
                setFocusToFirstVideo()
                'm.firstVideoMUG.setFocus(true)
                
                playFirstVideo()
                return true

            end if
        else if key = "right"
            print "right clicked"
            if m.firstVideoMUG.hasFocus()
                stopFirstVideo()
                stopCountDown()
                m.secondVideoMUG.setFocus(true)
                'm.secondVideoMUG.jumpToItem = 0
                
                return true
            end if
            return true
        else if key = "up"
            'to perform scroll for more functionality
            m.isUpKeyPressed = true
            handleWhenUpPressed()
            if m.isFirstVideoPlaying
                stopCountDown()
                stopFirstVideo()
            else if m.isSecondVideoPlaying

                m.secondVideoMUG.jumpToItem = 0
                m.previousFocusedColumn = 0
                parentDataDetails = {
                    "action": "moveScreen"
                    "direction": "original",
                    "component": "searchComponent",
                    "spaceToMove": 0
                }
                updateToParentData(parentDataDetails)
                stopSecondVideo()
            end if
            
            return false
        else if key = "down"
            'm.isDownKeyPressed = true
            if m.firstVideoMUG.hasFocus()
                stopCountDown()
                stopFirstVideo()
            else if m.secondVideoMUG.hasFocus()
                m.secondVideoMUG.jumpToItem = 0
                m.previousFocusedColumn = 0
                parentDataDetails = {
                    "action": "moveScreen"
                    "direction": "original",
                    "component": "searchComponent",
                    "spaceToMove": 0
                }
                updateToParentData(parentDataDetails)
                stopSecondVideo()
            end if
            return false
        else if key="back"
            print "back pressed"
            if m.firstVideoMUG.hasFocus()
                print "m.firstVideoMUG.hasFocus()"
                stopFirstVideo()
                return false
            else if m.secondVideoMUG.hasFocus()
                print "m.secondVideoMUG.hasFocus()"
                m.secondVideoMUG.jumpToItem = 0
                m.previousFocusedColumn = 0
                stopSecondVideo()
                parentDataDetails = {
                    "action": "moveScreen"
                    "direction": "original",
                    "component": "searchComponent",
                    "spaceToMove": 0
                }
                updateToParentData(parentDataDetails)
                ' m.top.toParentData = {
                '     "action": "moveScreen"
                '     "direction": "original",
                '     "component": "searchComponent",
                '     "spaceToMove": 0
                ' }
                return false
            ' else if not m.secondVideoMUG.hasFocus() or not m.firstVideoMUG.hasFocus()
            '     PRINT "BACK FROM SEARCH COMP IS HANDLED"
                
                
            '     m.firstVideoMUG.setFocus(true)
            '     return true
            end if
        end if
    end if
    return false
end function