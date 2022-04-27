sub init()
    m.firstVideo = m.top.findNode("firstVideo")
    
    m.yellowBorder = m.top.findNode("yellowBorder")
    m.bgi = m.top.findNode("bgi")
    m.videoDurationDesc = m.top.findNode("videoDurationDesc")
    m.videoDurationDescRect = m.top.findNode("videoDurationDescRect")
    m.firstVideo.observeField("state", "handleState")
    m.firstVideoDescNode = m.top.findNode("firstVideoDesc")
    m.blackScreen = m.top.findNode("blackScreen")

    m.muteIcon = m.top.findNode("muteIcon")
    m.timerLabel = m.top.findNode("timerLabel")

    m.horizRect1 = m.top.findNode("horizRect1")
    m.horizRect2 = m.top.findNode("horizRect2")
    m.vertRect1 = m.top.findNode("vertRect1")
    m.vertRect2 = m.top.findNode("vertRect2")

    m.watchNowLabel = m.top.findNode("watchNowLabel")
end sub

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

sub setContent()
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

    if m.action = "initialRendering"
        initialRendering()
    else if m.action = "playVideo"
        initialRendering()
        playVideoOperation()
    else if m.action = "stopVideo"
        stopVideoOperation()
    else if m.action = "startCountDown"
        countDownOperation()
    end if 


    
end sub

sub countDownOperation()
    if  m.countDownValue >= 0
            setBlackScreen(true)
            setMuteIconVisibility(true)
            setBackgroundImageVisible(false)
            setYellowBorder(true)
            setVideoDurationDesc(false)
            setTimerLabelVisibility(true)
            setWatchNowLabelVisibility(true)
            setTimerLabelText(m.countDownValue)
            return
    end if
end sub

sub initialRendering()
    setBlackScreen(false)
    setMuteIconVisibility(false)
    setBackgroundImageVisible(true)
    setYellowBorder(false)
    setTimerLabelVisibility(false)
    setWatchNowLabelVisibility(false)
    setVideoDurationDesc(true)
    setVideo()
end sub

sub playVideoOperation()
    setBlackScreen(true)
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
    m.firstVideo.control = "play"
end sub

function setVideo() as void
    print "setVideo()"
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = m.firstVideoUrl
    videoContent.title = m.firstVideoTitle
    videoContent.streamformat = m.firstVideoStreamFormat
    m.firstVideoDescNode.text = m.firstVideoDesc
    m.firstVideoDescNode.font.size = 50
    m.firstVideo.content = videoContent
    m.firstVideo.control = "none"
    print "m.firstVideoDuration: "m.firstVideoDuration
    m.videoDurationDesc.text = m.firstVideoDuration
end function


sub handleState()

    if m.firstVideo.state = "finished"
        m.firstVideo.control = "play"
    end if
end sub
