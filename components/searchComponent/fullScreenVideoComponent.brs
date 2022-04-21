sub init()
    print "INIT OF FULL SCREEN VIDEO COMPONENT"
    m.fullScreenVideo = m.top.findNode("fullScreenVideo")
    m.fullScreenVideo.observeField("state", "handleState")
   
end sub

sub onVideoDataReceived()
    print "onVideoDataReceived()"
    print "m.videoDetails: "m.videoDetails
    m.videoTitle = m.videoDetails.title
    m.videoUrl = m.videoDetails.url
    m.videoStreamFormat = m.videoDetails.streamFormat
    m.videoControl = m.videoDetails.control
    playVideo()
end sub

sub hanldeState()
    print "handleState()"
    print "state: "m.fullScreenVideo.state
end sub

sub playVideo()
    print "playVideo()"
    videoContent = CreateObject("roSGNode", "ContentNode")
    videoContent.url = m.videoUrl
    videoContent.title = m.videoTitle
    videoContent.streamFormat = m.videoStreamFormat
    m.fullScreenVideo.content = videoContent
    m.fullScreenVideo.control = "play"
    m.fullScreenVideo.setFocus(true)
    print "End of playVideo() function"
end sub

sub handleFromParentData()
    print "handleFromParentData()"
    
    m.videoDetails = m.top.fromParentData
    onVideoDataReceived()
end sub

function onKeyEvent(key as String, press as boolean) as boolean
    if press
        if key = "back"
            m.fullScreenVideo.control = "stop"
            m.fullScreenVideo.setFocus(false)
            m.top.toParentData = {
                "value": "tempValue"
            }
            m.top.getScene().goBack = "true"
        end if
    end if
end function 