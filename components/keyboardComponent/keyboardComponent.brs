sub init()
    
    m.top.setFocus(true)
    m.backButton = m.top.findNode("backButton")
    m.keyboard1 = m.top.findNode("keyboard1")
    m.backButton.observeField("buttonSelected", "onButtonSelected")
    
end sub

sub handleFromParentData()
    m.keyboard1.text = m.top.fromParentData.keyboardData
    m.keyboard1.textEditBox.cursorPosition = len(m.keyboard1.text)
end sub

sub onButtonSelected()
    m.top.toParentData = {
        "keyboardData": m.keyboard1.text
    }
    m.top.getScene().goBack = true
end sub

Function onKeyEvent(key as String, press as boolean) as boolean

    if press
      
        if key = "up"
          
            if(m.backButton.hasFocus())
                m.keyboard1.setFocus(true)
                return true
            end if
        end if
        if key = "down"
             m.keyboard1.hasFocus()
                m.backButton.setFocus(true)
                return true
        end if
        if key = "back"
            m.top.toParentData = {
                "keyboardData": m.keyboard1.text
            }
            m.top.getScene().goBack = true
        end if
    end if
    return false       
end function