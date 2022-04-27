sub init()
    m.buttonGroup = m.top.findNode("buttonGroup")
    m.playButton = m.top.findNode("playButton")
end sub

sub onSetfocus(event)
    booleanValue = event.getData()
    m.playButton.setFocus(booleanValue)
end sub