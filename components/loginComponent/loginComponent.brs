sub init()
      m.myList = m.top.findNode("myList")
      m.loginButton = m.top.findNode("loginButton")
      m.usernameOrPasswordWrong = m.top.findNode("usernameOrPasswordWrong")
      m.loginButton.observeField("buttonSelected", "logIn")
      m.selectedItem = 0
      m.top.observeField("focusedChild", "setFocusToMyList")
      setLogInContent()
end sub

sub logIn()

    password = m.myList.content.getChild(1).texteditbox1

    if password = "aaa"
        m.top.getScene().deleteBackStackArray = true
        m.top.getScene().logIn = true
        m.top.getScene().compToPush = "loggedInComponent"

    else

        m.usernameOrPasswordWrong.text = "Password wrong"

    end if
end sub
sub setFocusToMyList()

  if m.top.hasFocus()
    m.myList.setFocus(true)
  end if
end sub

sub handleFromChildData()
  m.dataFetched = m.top.fromChildData
  m.selectedItem = m.myList.itemSelected
  item = m.myList.content.getChild(m.selectedItem)
  item.texteditbox1 = m.dataFetched.keyboardData
  m.myList.setFocus(true)

end sub  
  
sub setLogInContent()
  
  parentContent = createObject("roSgNode", "contentNode")
  
  contents = [
    {
      "content1": "username",
      "texteditbox1":""
    },
    {
      "content1": "password",
      "texteditbox1":""
    }
  ]

  for each item in contents 

    childContent = parentContent.createChild("signInContent")
    childContent.content1 = item.content1

  end for
    m.myList.content = parentContent
    m.myList.observeField("itemSelected","onItemSelected")
    m.myList.setFocus(true)

end sub
  
sub onItemSelected()

  m.selectedItem = m.myList.itemSelected
  item = m.myList.content.getChild(m.selectedItem)
  m.top.toChildData = {
    "keyboardData": item.texteditbox1
  }
  m.top.getScene().compToPush = "keyboardComponent"
end sub

function onKeyEvent(key as String, press as boolean) as boolean

  if press
      if key = "down"
          if m.myList.hasFocus()
              m.loginButton.setFocus(true)
              return true
          end if
      end if
      if key = "up"
          if m.loginButton.hasFocus()
              m.myList.setFocus(true)
              return true
          end if
      end if
  end if
  return false

end function