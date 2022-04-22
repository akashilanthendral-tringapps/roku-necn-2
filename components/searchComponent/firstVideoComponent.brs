sub init()
    print "init of firstVideoComponent..............."
    m.firstVideo = m.top.findNode("firstVideo")
    
    m.yellowBorder = m.top.findNode("yellowBorder")
    m.bgi = m.top.findNode("bgi")
    m.videoDurationDesc = m.top.findNode("videoDurationDesc")
    m.videoDurationDescRect = m.top.findNode("videoDurationDescRect")
    m.firstVideo.observeField("state", "handleState")
    m.firstVideoDescNode = m.top.findNode("firstVideoDesc")
    m.blackScreen = m.top.findNode("blackScreen")
    ' m.whiteRect = m.top.findNode("whiteRect")
    ' m.blackRect = m.top.findNode("blackRect")
    m.muteIcon = m.top.findNode("muteIcon")
    m.timerLabel = m.top.findNode("timerLabel")

    m.horizRect1 = m.top.findNode("horizRect1")
    m.horizRect2 = m.top.findNode("horizRect2")
    m.vertRect1 = m.top.findNode("vertRect1")
    m.vertRect2 = m.top.findNode("vertRect2")

    m.watchNowLabel = m.top.findNode("watchNowLabel")

    
    ' m.countDown = m.top.findNode("countDown")
    ' m.countDown.observeField("fire", "onCountDownFired")
    ' m.countDownValue = 0
end sub

' sub onCountDownFired()
'     m.timerLabel.text = m.countDownValue
'     m.countDownValue = m.countDownValue + 1

'     if m.countDownValue = 10
'         m.countDownValue = 0
'         countDownControl("stop")
'         setTimerLabelVisibility(false)
'     end if
' end sub

sub setTimerLabelVisibility(visibility)
    m.timerLabel.visible = visibility
    m.horizRect1.visible = visibility
    m.horizRect2.visible = visibility
    m.vertRect1.visible = visibility
    m.vertRect2.visible = visibility
end sub

sub setWatchNowLabelVisibility(visibility)
    m.watchNowLabel.visible = visibility
end sub
' sub countDownControl(control_ as String)
'     m.countDown.control = control_
' end sub

sub setContent()
    print "setContent()"
    m.values = m.top.itemContent
    m.action = m.values.action
    m.firstVideoUrl = m.values.firstVideoUrl
    m.firstVideoTitle = m.values.firstVideoTitle
    m.firstVideoControl = m.values.firstVideoControl
    m.firstVideoStreamFormat = m.values.firstVideoStreamFormat
    m.firstVideoDuration = m.values.firstVideoDuration
    m.countDownValue = m.values.countDownValue

    m.secondTimeRenderingFirstVideo = m.values.secondTimeRenderingFirstVideo
    m.firstVideoDesc = m.values.firstVideoDesc

    print "ACTION: "m.action
    if m.action = "initialRendering"
        initialRendering()
    else if m.action = "playVideo"
        initialRendering()
        playVideoOperation()
    else if m.action = "stopVideo"
        stopVideoOperation()
    else if m.action = "startCountDown"
        countDownOperation()
        
    ' else if m.secondTimeRenderingFirstVideo.isSecondTime = true 
    '     if m.secondTimeRenderingFirstVideo.control = "stop"
    '         ' setBlackScreen(false)
    '         ' 'setWhiteRectVisibility(false)
    '         ' setMuteIconVisibility(false)
    '         ' setBackgroundImageVisible(true)
    '         ' setYellowBorder(false)
    '         ' setVideoDurationDesc(true)
    '         ' setTimerLabelVisibility(false)
    '         ' stopVideo()
    '         ' setWatchNowLabelVisibility(false)
    '         stopVideoOperation()
    '     else
    '         playVideoOperation()
    '     end if
    end if 
    ' print "m.firstVideoCountDown: "m.firstVideoCountDown
    ' if not m.firstVideoCountDown = invalid
    '     print "m.firstVideoCountDown.visibility: "m.firstVideoCountDown.visibility
    '     setTimerLabelVisibility(m.firstVideoCountDown.visibility)
    '     m.timerLabel.text = m.firstVideoCountDown.value
    ' end if

    
end sub

sub countDownOperation()
    print "Count down value: "m.countDownValue
    if  m.countDownValue >= 0
            ' if m.countDownValue = 10 'copied from line 113
            '     setBlackScreen(false)
            '     setMuteIconVisibility(false)
            '     setBackgroundImageVisible(true)
            '     setYellowBorder(false)
            '     setVideoDurationDesc(true)
            '     setTimerLabelVisibility(false)
            '     stopVideo()
            '     setWatchNowLabelVisibility(false)
            '     return
            ' end if
            setBlackScreen(true)
            'setWhiteRectVisibility(true)
            setMuteIconVisibility(true)
            setBackgroundImageVisible(false)
            setYellowBorder(true)
            setVideoDurationDesc(false)
            setTimerLabelVisibility(true)
            ' countDownControl("start")
            print">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            'playVideo()
            setWatchNowLabelVisibility(true)
            print">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            setTimerLabelText(m.countDownValue)
            return
    end if
end sub

sub initialRendering()
    setBlackScreen(false)
    'setWhiteRectVisibility(false)
    setMuteIconVisibility(false)
    setBackgroundImageVisible(true)
    setYellowBorder(false)
    setTimerLabelVisibility(false)
    setWatchNowLabelVisibility(false)
    setVideo()
end sub

sub playVideoOperation()
    print "Inside: playVideoOperation()"
    print "m.values: "m.values
 
    setBlackScreen(true)
    'setWhiteRectVisibility(true)
    setMuteIconVisibility(true)
    setBackgroundImageVisible(false)
    setYellowBorder(true)
    setVideoDurationDesc(false)
    setTimerLabelVisibility(true)
    playVideo()
    setWatchNowLabelVisibility(true)
    setTimerLabelText(-1)
    
end sub

sub stopVideoOperation()
    setBlackScreen(false)
    'setWhiteRectVisibility(false)
    setMuteIconVisibility(false)
    setBackgroundImageVisible(true)
    setYellowBorder(false)
    setVideoDurationDesc(true)
    setTimerLabelVisibility(false)
    stopVideo()
    setWatchNowLabelVisibility(false)
end sub

sub setYellowBorder(visibility)
    if visibility
        m.yellowBorder.color = "#ffff00"
    else
        m.yellowBorder.color = "#9900cc"
    end if
end sub

sub setTimerLabelText(value as Integer) 
    if value = -1
        m.timerLabel.text = ""
    else
        m.timerLabel.text = value
    end if
    
end sub

sub setBlackScreen(visibility)
    m.blackScreen.visible = visibility
end sub

sub setVideoDurationDesc(visibility)
    m.videoDurationDescRect.visible = visibility
end sub

' sub setWhiteRectVisibility(visibility)
'     m.whiteRect.visible = visibility
' end sub 
sub setMuteIconVisibility(visibility)
    m.muteIcon.visible = visibility
end sub 

sub setBackgroundImageVisible(bool as boolean)
    m.bgi.visible = bool
    m.firstVideo.visible = not bool
end sub

sub stopVideo()
    m.firstVideo.control = "stop"
end sub

sub playVideo()
    print "firstVideoComponent playVideo()"
    m.firstVideo.control = "play"
end sub

function setVideo() as void
    print " setVideo()"
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = m.firstVideoUrl
    videoContent.title = m.firstVideoTitle
    videoContent.streamformat = m.firstVideoStreamFormat
    m.firstVideoDescNode.text = m.firstVideoDesc
    m.firstVideo.content = videoContent
    m.firstVideo.control = "none"
    m.videoDurationDesc.text = m.firstVideoDuration
    'm.firstVideo.setFocus(true)
   print "END setVideo()"
end function


sub handleState()
    print "handleState()"
    print "m.firstVideo.state: "m.firstVideo.state
    if m.firstVideo.state = "finished"
        print "video finished"
        m.firstVideo.control = "play"
    else if m.firstVideo.state = "playing"
        
    end if
end sub

' sub setFirstVideoSize()
'     print "sub handleincreaseFirstVideoSize()"
'         m.firstVideo.width = "1000"
'         m.firstVideo.height = "565.2"
'         m.firstVideo.translation = "[0,0]"
' end sub

' function onKeyEvent(key as String, press as boolean) as boolean
'     if press
'         if key = "back"
'             print "BACK FROM FIRST VIDEO COMPONENT IS HANDLED"
'             return false
'         else if key = "countDownOver"
'             return false
'         end if
'     end if
'     return false
' end function
