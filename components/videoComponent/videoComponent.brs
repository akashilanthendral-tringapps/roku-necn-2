sub init()
    m.top.setFocus(true)
    setVideo()
end sub
  
function setVideo() as void
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8"
    videoContent.title = "Test Video"
    videoContent.streamformat = "hls"
  
    m.video = m.top.findNode("videoId")
    m.video.observeField("state", "handleState")
    m.video.content = videoContent
    m.video.control = "play"
    m.video.setFocus(true)
end function

sub handleState()
    print "hanlde state of video component"
    print "m.video.state: "m.video.state
    if m.video.state = "finished"
        m.top.toParentData = {
            "temp":"temp"
        }
        m.top.getScene().goBack = true
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "back"
            m.video.control = "stop"
            m.top.toParentData = {
                "temp":"temp"
            }
            m.top.getScene().goBack = true
            return true
        end if
    end if
end function