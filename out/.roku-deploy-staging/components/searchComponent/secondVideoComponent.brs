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
    m.secondVideoAction = m.values.secondVideoAction

    if m.secondVideoAction = "initialRendering"
        initialRendering()
    else if m.secondVideoAction = "playVideo"
        initialRendering()
        playVideoOperation()
    else if m.secondVideoAction = "stopVideo"
        stopVideoOperation()
    end if
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
    setBackgroundImageVisible(true)
    secondVideoVisibility(false)
    setYellowBorder2(false)
    stopVideo()
end sub

sub playVideoOperation()
    setBackgroundImageVisible(false)
    secondVideoVisibility(true)
    setYellowBorder2(true)
    playVideo()
end sub

sub initialRendering()
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
    if m.secondVideo.state = "finished"
        m.secondVideo.control = "play"
    end if
end sub


