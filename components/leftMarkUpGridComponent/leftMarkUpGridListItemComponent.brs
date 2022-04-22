sub init()
    m.name = m.top.findNode("name")
    m.iconUri = m.top.findNode("iconUri")


end sub

sub setContent()
    print "LEFTMARKUP GRID SET CONTENT()"
    m.itemContentValues = m.top.itemContent
    m.name.text = m.itemContentValues.name
    m.name.opacity = m.itemContentValues.setNameVisible
    m.iconUri.uri = m.itemContentValues.iconUri
    
    m.setIconVisible = m.itemContentValues.setIconVisible
    PRINT "m.setIconVisible: "m.setIconVisible 
    m.iconUri.visible = m.setIconVisible
end sub