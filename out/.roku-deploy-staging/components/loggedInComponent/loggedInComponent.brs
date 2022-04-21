sub init()

    m.topRect = m.top.findNode("topRect")
    m.topRectTranslations = ["[0,0]", "[-300,0]", "[-600,0]", "[0,0]", "[-300,0]", "[-600,0]"]

    m.topRectAnimationRightMovingScreen = m.top.findNode("topRectAnimationRightMovingScreen")
    m.topRectAnimationLeftMovingScreen = m.top.findNode("topRectAnimationLeftMovingScreen")

    m.topRectInterpRightMovingScreen = m.top.findNode("topRectInterpRightMovingScreen")
    m.topRectInterpLeftMovingScreen = m.top.findNode("topRectInterpLeftMovingScreen")

    m.layoutGroupId = m.top.findNode("layoutGroupId")

    m.playButton = m.top.findNode("playButton")
    m.playButton.setFocus(true)
    m.buttonGroupId = m.top.findNode("buttonGroupId")
    m.leftMarkUpGridList = m.top.findNode("leftMarkUpGridList")
    m.leftMarkUpGridList.observeField("itemFocused", "onMarkUpGridFocused")
    m.leftMarkUpGridList.observeField("itemUnfocused", "onMarkUpGridUnfocused")
    m.leftMarkUpGridList.observeField("itemSelected", "onMarkUpGridSelected")
    m.isFirstTimeInsideOnMarkUpGridFocused = true
    
    m.homeComponentId = m.top.findNode("homeComponentId")
    m.homeComponentId.observeField("toParentData", "handleToParentData")

    m.searchComponentId = m.top.findNode("searchComponentId")
    m.searchComponentId.observeField("toParentData", "handleToParentData")

    m.profileComponentId = m.top.findNode("profileComponentId")
    m.profileComponentId.observeField("toParentData", "handleToParentData")
    
    m.timeGridComponentId = m.top.findNode("timeGridComponentId")
    m.timeGridComponentId.observeField("toParentData", "handleToParentData")
    
    
    m.componentsArray = [m.homeComponentId, m.searchComponentId, m.profileComponentId, m.timeGridComponentId]
    m.previousComp = m.homeComponentId
    m.playButton.observeField("buttonSelected", "onPlayButtonSelected") 

    setLeftMarkUpGridItems()
    setHomeComponent()
end sub

sub onMarkUpGridUnfocused()
    print "onMarkUpGridUnfocused()"
    setLabelIconAndLabelOpacity(false)
    
end sub

sub setLabelIconAndLabelOpacity(boolValue as boolean)
    print "setLabelIconAndLabelOpacity()"
    if boolValue
            m.focusedItemIndex = m.leftMarkUpGridList.itemFocused 
            m.lastFocusedItemIndex = m.focusedItemIndex
            m.focusedItem = m.leftMarkUpGridList.content.getChild(m.focusedItemIndex)
            m.focusedItem.setIconVisible = true
            m.focusedItem.setNameVisible = 1.0
    else
        if m.leftMarkUpGridList.hasFocus()
            m.unfocusedItemIndex = m.leftMarkUpGridList.itemUnfocused
            m.unfocusedItem = m.leftMarkUpGridList.content.getChild(m.unfocusedItemIndex)
            m.unfocusedItem.setIconVisible = false
            m.unfocusedItem.setNameVisible = 0.5
        end if
    end if
end sub

function getUnfocusedItem()
    unfocusedItemIndex = m.leftMarkUpGridList.itemUnfocused
    unfocusedItem = m.leftMarkUpGridList.content.getChild(unfocusedItemIndex)
    return unfocusedItem
end function

function getFocusedItem()
    focusedItemIndex = m.leftMarkUpGridList.itemFocused
    focusedItem = m.leftMarkUpGridList.content.getChild(focusedItemIndex)
    return focusedItem
end function
sub onMarkUpGridFocused()
    print "onMarkUpGridFocused()"

    setLabelIconAndLabelOpacity(true)
    focusedItemIndex = m.leftMarkUpGridList.itemFocused
    focusedItem = m.leftMarkUpGridList.content.getChild(focusedItemIndex)
    ' focusedItem = getFocusedItem()
    if not focusedItem.name = "Sign out"
        print "......................"
        print "focusedItem.componentName: "focusedItem.componentName
        renderComponent(focusedItem.componentName, "focused")
    end if
end sub

sub setHomeComponent()
    m.homeComponentId.visible = true
    m.previousComp = m.homeComponentId
    m.previousComp.setFocus = true
end sub

sub onMarkUpGridSelected()
    
    selectedItemIndex = m.leftMarkUpGridList.itemSelected
    m.selectedItemOfLeftMarkUpGrid = selectedItemIndex
    print "selected item: "m.selectedItemOfLeftMarkUpGrid 

    selectedItem = getSelectedItem()
    selectedItem.setIconVisible = false 
    if selectedItem.name = "Sign out"
        onLogoutButtonSelected()
    else 
        renderComponent(selectedItem.componentName, "selected")
    end if
end sub




function getComponent(compName as String) as object
    compToRender = m.top.findNode(compName)
    return compToRender
end function

function getSelectedItem() as object
    selectedItemIndex = m.leftMarkUpGridList.itemSelected
    selectedItem = m.leftMarkUpGridList.content.getChild(selectedItemIndex)
    return selectedItem
end function


sub renderComponent(compName as String, operationPerformed as String)
    print "renderComponent()"
    print "compName: "compName
    compToRender = getComponent(compName)
    if operationPerformed = "selected"
        compToRender.setFocus = true
    else
        m.previousComp.setFocus = false
        m.previousComp.visible = false
        m.previousComp = compToRender
        compToRender.visible = true
    end if
end sub

sub renderLiveComponent()
    timeGridComponent = CreateObject("rosgnode", "timeGridComponent")
    m.top.appendChild(timeGridComponent)
    timeGridComponent.setFocus(true)
end sub

sub setLeftMarkUpGridItems()

    m.markUpGridItemContents = [
        {
            "name": "Home",
            "iconUri": "pkg:/images/separated/sideBarIcon.png",
            ' "iconUri": "pkg:/images/separated/homeIconColored.png",
            "componentName": "homeComponentId"            
        },
        {
            "name": "Search",
            "iconUri": "pkg:/images/separated/sideBarIcon.png",
            ' "iconUri": "pkg:/images/separated/searchIconBlue2.png",
            "componentName": "searchComponentId"
        },
        {
            "name": "Profile",
            "iconUri": "pkg:/images/separated/sideBarIcon.png",
            ' "iconUri": "pkg:/images/separated/profileIcon.png",
            "componentName": "profileComponentId"
        },
        {
            "name": "Live",
            "iconUri": "pkg:/images/separated/sideBarIcon.png",
            ' "iconUri": "pkg:/images/separated/liveIcon.png",
            "componentName": "timeGridComponentId"
        },
        {
            "name": "Sign out",
            "iconUri": "pkg:/images/separated/sideBarIcon.png",
            ' "iconUri": "pkg:/images/separated/signoutIcon.png",
            "componentName": "signOutComponent"
        }
    ]


    parentContent = CreateObject("roSGNode", "contentNode")

    for each item in m.markUpGridItemContents
        childContent = parentContent.createChild("leftMarkUpGridContent")
        childContent.iconUri = item.iconUri
        childContent.name = item.name
        childContent.componentName = item.componentName
        if item.name = "Home"
            childContent.setIconVisible = false
            childContent.setNameVisible = 1.0
        else 
            childContent.setIconVisible = false
            childContent.setNameVisible = 0.5
        end if
    end for

    m.leftMarkUpGridList.content = parentContent
end sub

sub onLogoutButtonSelected()
    m.top.getScene().deleteBackStackArray = true
    m.top.getScene().logOut = true
    m.top.getScene().compToPush = "loginComponent"

end sub

sub onPlayButtonSelected()
    m.selectedItemOfLeftMarkUpGrid = 0
    m.top.getScene().compToPush = "videoComponent"
end sub


sub handleFromChildData()
    print "handleFromChildData()"
    print "m.selectedItemOfLeftMarkUpGrid: "m.selectedItemOfLeftMarkUpGrid
    if m.selectedItemOfLeftMarkUpGrid = 0
        m.playButton.setFocus(true)
    else if m.selectedItemOfLeftMarkUpGrid = 1
        m.searchComponentId.afterOnFirstVideoMUGSelected = true
    else 
        m.leftMarkUpGridList.setFocus(true)
    end if
    
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "right"
            print "Right key pressed"
            if m.leftMarkUpGridList.hasFocus()
                print "m.leftMarkUpGridList.hasFocus(): "m.leftMarkUpGridList.hasFocus()
                m.selectedItemOfLeftMarkUpGrid = m.leftMarkUpGridList.itemFocused
                itemFoc = m.leftMarkUpGridList.content.getChild(m.leftMarkUpGridList.itemFocused)
                itemFoc.setIconVisible = false
                m.previousComp.setFocus = true
                return true
            end if
        else if key = "left"
            print "left pressed"
             if m.playButton.hasFocus()
                print "m.playButton.hasFocus()"
                m.playButton.setFocus(false)
                m.leftMarkUpGridList.setFocus(true)
                return true
            else if NOT m.leftMarkUpGridList.hasFocus() 
                m.leftMarkUpGridList.setFocus(true)
                return true
            else
                print "else part handled"
                m.leftMarkUpGridList.setFocus(true)
            end if
        
        else if key = "back"
            if m.leftMarkUpGridList.hasFocus()
                return true
            end if
            m.leftMarkUpGridList.setFocus(true)
            return true
        else if key = "ok"
            if m.leftMarkUpGridList.hasFocus()

            end if
        end if
    return false
    end if
end function

sub handleToParentData(event)
    print "hanldeToParentData INside: LOggedInComponent"
    dataFromChild = event.getData()
    if dataFromChild.action = "componentCreation"
        print "Inside component creation IF statement"
        m.top.toChildData = dataFromChild.pageData
        print "dataFromChild.pageData: "dataFromChild.pageData
        print "dataFromChild.componentName: "dataFromChild.componentName
        m.top.getScene().compToPush = dataFromChild.componentName
    else if dataFromChild.action = "moveScreen"
        if dataFromChild.component = "searchComponent"
            moveScreen(dataFromChild.direction, dataFromChild.spaceToMove)
        end if
        
    end if
end sub

sub moveScreen(direction, spaceToMove)
    print "moveScreen()"
    print "direction: "direction
    print "spaceToMove: "spaceToMove
    xCoordinate = m.topRect.translation[0]
    if direction = "right"
        
        m.topRectInterpRightMovingScreen.keyValue = [[xCoordinate, 100], [xCoordinate-spaceToMove, 100]]
        m.topRectAnimationRightMovingScreen.control = "start"
        
    else if direction="left"
        
        m.topRectInterpLeftMovingScreen.keyValue = [[xCoordinate, 100], [xCoordinate+spaceToMove, 100]]
        m.topRectAnimationLeftMovingScreen.control = "start"

    else
        m.topRectInterpLeftMovingScreen.keyValue = [[xCoordinate, 100], [0, 100]]
        m.topRectAnimationLeftMovingScreen.control = "start"
    end if
    
end sub