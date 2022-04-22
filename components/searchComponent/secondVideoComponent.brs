sub init()
    print "init() secondVideoComponent!"
    m.secondVideo = m.top.findNode("secondVideo")
    m.yellowBorder2 = m.top.findNode("yellowBorder2")
    m.bgi = m.top.findNode("bgi")
    m.videoDurationDesc = m.top.findNode("videoDurationDesc")
    m.secondVideoDescNode = m.top.findNode("secondVideoDesc")
    m.secondVideo.observeField("state", "handleState2")
end sub

sub setContent2()
    print "setContent2()"
    m.values = m.top.itemContent
  

    m.secondVideoUrl = m.values.secondVideoUrl
    m.secondVideoTitle = m.values.secondVideoTitle
    m.secondVideoControl = m.values.secondVideoControl
    m.secondVideoStreamFormat = m.values.secondVideoStreamFormat
    m.increaseSecondVideoSize = m.values.increaseSecondVideoSize
    m.secondVideoDesc = m.values.secondVideoDesc
    m.secondVideoDuration = m.values.secondVideoDuration
    m.secondVideoAction = m.values.secondVideoAction
    print "m.secondVideoAction: "m.secondVideoAction
    if m.secondVideoAction = "initialRendering"
        initialRendering()
    else if m.secondVideoAction = "playVideo"
        initialRendering()
        playVideoOperation()
    else if m.secondVideoAction = "stopVideo"
        stopVideoOperation()
    end if

    ' m.secondTimeRenderingSecondVideo = m.values.secondTimeRenderingSecondVideo
    ' if m.secondTimeRenderingSecondVideo.isSecondTime = false
    '     ' print "m.secondTimeRenderingSecondVideo.isSecondTime = false"
    '     ' setBackgroundImageVisible(true)
    '     ' setYellowBorder2(false)
    '     ' setVideo2()
    ' else
    '     ' print "m.secondTimeRenderingSecondVideo.isSecondTime = true"
    '     if m.secondTimeRenderingSecondVideo.control = "stop"
    '         ' print "stop:"
    '         ' print "m.secondVideo.state: "m.secondVideo.state
    '         ' setBackgroundImageVisible(true)
    '         ' setYellowBorder2(false)
    '         ' m.secondVideo.control = "stop"
    '         ' print "m.secondVideo: "m.secondVideo
    '     else
    '         ' print "play:"
    '         ' print "m.secondVideo.state: "m.secondVideo.state
    '         ' setBackgroundImageVisible(false)
    '         ' setYellowBorder2(true)
    '         ' m.secondVideo.control = "play"
    '         ' print "m.secondVideo: "m.secondVideo
    '     end if
    ' end if
end sub

sub stopVideo()
    m.secondVideo.control = "stop"
end sub

sub playVideo()
    m.secondVideo.control = "play"
end sub

sub secondVideoVisibility(value as boolean)
    m.secondVideo.visible = value
end sub

sub stopVideoOperation()
    print "stopVideoOperation()"
    setBackgroundImageVisible(true)
    secondVideoVisibility(false)
    setYellowBorder2(false)
    stopVideo()
end sub

sub playVideoOperation()
    print "playVideoOperation()"
    setBackgroundImageVisible(false)
    secondVideoVisibility(true)
    setYellowBorder2(true)
    playVideo()
end sub

sub initialRendering()
    print "initialRendering()"
    setBackgroundImageVisible(true)
    secondVideoVisibility(false)
    setYellowBorder2(false)
    setVideo2()
end sub

sub setYellowBorder2(visibility)
    if visibility
        m.yellowBorder2.color = "#ffff00"
    else
        m.yellowBorder2.color = "#9900cc"
    end if
end sub

sub setBackgroundImageVisible(bool as boolean)
    m.bgi.visible = bool    
end sub

function setVideo2() as void
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = m.secondVideoUrl
    videoContent.title = m.secondVideoTitle
    videoContent.streamformat = m.secondVideoStreamFormat
    m.secondVideoDescNode.text = m.secondVideoDesc
    m.videoDurationDesc.text = m.secondVideoDuration
    m.secondVideo.content = videoContent
end function


sub handleState2()
    ' print "handleState2()"
    ' print "m.secondVideo.state: "m.secondVideo.state
    if m.secondVideo.state = "finished"
        ' print "m.secondVideo.state = finished"
        m.secondVideo.control = "play"
        ' print "m.secondVideo.control = stop"
    else if m.secondVideo.state = "error"
        ' print "m.secondVideo.errorCode: "m.secondVideo.errorCode
        ' print "m.secondVideo.errorMsg: "m.secondVideo.errorMsg
        ' print "m.secondVideo.errorStr: "m.secondVideo.errorStr
    else if m.secondVideo.state = "play"
        ' print "playing"
    end if
end sub


