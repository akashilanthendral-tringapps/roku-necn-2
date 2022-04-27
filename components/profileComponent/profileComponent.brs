sub init()
    m.profileCompLabelValue = m.top.findNode("profileCompLabelValue")
end sub

sub onSetfocus(event)
    booleanValue = event.getData()
    m.profileCompLabelValue.setFocus(booleanValue)
end sub