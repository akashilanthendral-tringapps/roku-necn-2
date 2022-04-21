sub init()
  m.top.setFocus(true)
  m.loginSection = CreateObject("roRegistrySection", "loginSection")
  m.backStackArray = []
  m.keyboardStackCountt = 0
  userLoggedIn = isUserLoggedIn()
  print "userLoggedIn: "userLoggedIn
  if userLoggedIn = "true"
    m.top.deleteBackStackArray = true
    m.top.compToPush = "loggedInComponent"
  else

    m.top.deleteBackStackArray = true
    m.top.compToPush = "loginComponent"

  end if
end sub

function isUserLoggedIn() as String
  userLoggedIn = m.loginSection.read("isUserLoggedIn")
  return userLoggedIn
end function

sub handleDeleteBackStackArray()
  m.backStackArray.clear()
end sub


sub handleLogIn()

  isWritten = m.loginSection.write("isUserLoggedIn", "true")
  m.loginSection.flush()

end sub

sub handleLogOut()

  isWritten = m.loginSection.write("isUserLoggedIn", "false")
  m.loginSection.flush()

end sub

sub renderNewComponent()
  print "renderNewComponent()"
  print "newComponentToBePushed: "m.top.compToPush
  newComponentToBePushed = CreateObject("roSGNode", m.top.compToPush)
  if m.backStackArray.count() >= 1
    previousComponent = m.backStackArray.peek()  
    print "previousComponent: "previousComponent
    newComponentToBePushed.fromParentData = previousComponent.toChildData
    print "previousComponent.toChildData: "previousComponent.toChildData
    print "newComponentToBePushed.fromParentData: "newComponentToBePushed.fromParentData
  end if
  
  m.top.removeChild(m.backStackArray.peek())
  m.backStackArray.push(newComponentToBePushed)
  m.top.appendChild(newComponentToBePushed)
  newComponentToBePushed.setFocus(true)  
  print "End of renderNewCOmponent()"
end sub

sub onGoBack()

  childScreen = m.backStackArray.pop()
  parentScreen = m.backStackArray.peek()
  
  m.top.removeChild(childScreen)
  m.top.appendChild(parentScreen)
  parentScreen.setFocus(true)
  parentScreen.fromChildData = childScreen.toParentData
  print "parentScreen.fromChildData: "parentScreen.fromChildData
  print "parentScreen.fromChildData = childScreen.toParentData"

end sub

sub setValuesToTopComponent(event)
  previousComponent = m.backStackArray.peek()
  previousComponent.toChildData = event.GetData()
end sub

sub handleSetDataFromLogInComp()
  
  if m.keyboardStackCountt >= 2
    
    keyboardComp = m.backStackArray.pop()
    
    loginComp = m.backStackArray.peek()

    if loginComp.selectedItem = 0
      keyboardComp.dataFromLogInComp = loginComp.usernameData
    else if loginComp.selectedItem = 1
      keyboardComp.dataFromLogInComp = loginComp.passwordData
    end if

    m.backStackArray.push(keyboardComp)
  end if
end sub

sub handleIsKeyboardCompPushed()
  m.keyboardStackCountt = m.keyboardStackCountt + 1
end sub