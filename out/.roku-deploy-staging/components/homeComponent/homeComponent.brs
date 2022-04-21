sub init()
    m.buttonGroup = m.top.findNode("buttonGroup")
    m.playButton = m.top.findNode("playButton")
    ' m.playButton.observeField("buttonSelected", "onPlayButtonSelected")
end sub

sub onSetfocus(event)
    print "onChange(event): homeComponent"
    booleanValue = event.getData()
    'm.buttonGroup.visible = booleanValue
    m.playButton.setFocus(booleanValue)
end sub