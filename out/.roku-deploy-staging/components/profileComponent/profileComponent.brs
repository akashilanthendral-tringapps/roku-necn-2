sub init()
    m.profileCompLabelValue = m.top.findNode("profileCompLabelValue")
end sub

sub onSetfocus(event)
    print "onChange(event): profileComponent"
    booleanValue = event.getData()
    'm.buttonGroup.visible = booleanValue
    m.profileCompLabelValue.setFocus(booleanValue)
end sub