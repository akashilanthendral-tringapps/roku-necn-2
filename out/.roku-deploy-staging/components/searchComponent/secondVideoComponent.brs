sub init()

    m.secondVideo = m.top.findNode("secondVideo")
    m.yellowBorder2 = m.top.findNode("yellowBorder2")
    m.bgi = m.top.findNode("bgi")
    m.videoDurationDesc = m.top.findNode("videoDurationDesc")
    m.secondVideoDescNode = m.top.findNode("secondVideoDesc")
    m.secondVideo.observeField("state", "handleState2")
end sub

sub setContent2()
    
    m.values = m.top.itemContent
  

    m.secondVideoUrl = m.values.secondVideoUrl
    m.secondVideoTitle = m.values.secondVideoTitle
    m.secondVideoControl = m.values.secondVideoControl
    m.secondVideoStreamFormat = m.values.secondVideoStreamFormat
    m.increaseSecondVideoSize = m.values.increaseSecondVideoSize
    m.secondVideoDesc = m.values.secondVideoDesc
    m.secondVideoDuration = m.values.secondVideoDuration

    m.secondTimeRenderingSecondVideo = m.values.secondTimeRenderingSecondVideo
    setVideoSize2()
    if m.secondTimeRenderingSecondVideo.isSecondTime = false
        ' print "m.secondTimeRenderingSecondVideo.isSecondTime = false"
        setBackgroundImageVisible(true)
        setYellowBorder2(false)
        setVideo2()
    else
        ' print "m.secondTimeRenderingSecondVideo.isSecondTime = true"
        if m.secondTimeRenderingSecondVideo.control = "stop"
            ' print "stop:"
            ' print "m.secondVideo.state: "m.secondVideo.state
            setBackgroundImageVisible(true)
            setYellowBorder2(false)
            m.secondVideo.control = "stop"
            ' print "m.secondVideo: "m.secondVideo
        else
            ' print "play:"
            ' print "m.secondVideo.state: "m.secondVideo.state
            setBackgroundImageVisible(false)
            setYellowBorder2(true)
            m.secondVideo.control = "play"
            ' print "m.secondVideo: "m.secondVideo
        end if
        'pauseVideo()
    end if

    ' setVideoSize2()
    ' setVideo2()
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
    m.secondVideo.visible = not bool
    
end sub

sub setVideoSize2()
    handleIncreaseSecondVideoSize2()
end sub

function setVideo2() as void
    ' print " setVideo2()"
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = m.secondVideoUrl
    videoContent.title = m.secondVideoTitle
    videoContent.streamformat = m.secondVideoStreamFormat
    m.secondVideoDescNode.text = m.secondVideoDesc
    m.videoDurationDesc.text = m.secondVideoDuration
    m.secondVideo.content = videoContent
    ' m.secondVideo.control = m.secondVideoControl
    ' print "m.secondVideo.control: "m.secondVideo.control
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

sub handleIncreaseSecondVideoSize2()
    ' print "handleIncreaseSecondVideoSize2()"
        m.secondVideo.width = "305"
        m.secondVideo.height = "171.5625"
end sub


