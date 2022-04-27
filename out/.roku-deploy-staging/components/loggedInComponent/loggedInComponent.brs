sub init()

    
    m.topRect = m.top.findNode("topRect")

    m.temperature = m.top.findNode("temperature")
    m.weather = m.top.findNode("weather")
    m.weather.font.size = 25
    m.temperature.font.size = 40

    m.layoutGroupAnimationRightMovingScreen = m.top.findNode("layoutGroupAnimationRightMovingScreen")
    m.layoutGroupAnimationLeftMovingScreen = m.top.findNode("layoutGroupAnimationLeftMovingScreen")

    m.layoutGroupInterpRightMovingScreen = m.top.findNode("layoutGroupInterpRightMovingScreen")
    m.layoutGroupInterpLeftMovingScreen = m.top.findNode("layoutGroupInterpLeftMovingScreen")

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
    m.homeComponentId.index = 0

    m.searchComponentId = m.top.findNode("searchComponentId")
    m.searchComponentId.observeField("toParentData", "handleToParentData")
    m.searchComponentId.index = 1

    m.profileComponentId = m.top.findNode("profileComponentId")
    m.profileComponentId.observeField("toParentData", "handleToParentData")
    m.profileComponentId.index = 2
    
    m.timeGridComponentId = m.top.findNode("timeGridComponentId")
    m.timeGridComponentId.observeField("toParentData", "handleToParentData")
    m.timeGridComponentId.index = 3
    
    
    m.componentsArray = [m.homeComponentId, m.searchComponentId, m.profileComponentId, m.timeGridComponentId]
    m.previousComp = m.homeComponentId
    m.playButton.observeField("buttonSelected", "onPlayButtonSelected") 

    m.scrollForMoreUp = m.top.findNode("scrollForMoreUp")
    m.scrollForMoreDown = m.top.findNode("scrollForMoreDown")

    setLeftMarkUpGridItems()
    setHomeComponent()
end sub

sub onMarkUpGridUnfocused()
    setLabelIconAndLabelOpacity(-1, -1, false)
end sub

sub removeYellow(itemUnfoc as object)
    itemUnfoc.setIconVisible = false
end sub

sub setLabelIconAndLabelOpacityWhenMUGIsUnfocused(itemFoc as integer, itemUnfoc as integer)
        item = m.leftMarkUpGridList.content.getChild(itemFoc)
        item.setIconVisible = false
        item.setNameVisible = 1.0
        if itemUnfoc = -1
            return
        end if
        unfocItem = m.leftMarkUpGridList.content.getChild(itemUnfoc)
        unfocItem.setIconVisible = false
        unfocItem.setNameVisible = 0.5
end sub

sub setLabelIconAndLabelOpacity(itemFoc as integer, itemUnfoc as integer, boolValue as boolean)
    if boolValue
        item = m.leftMarkUpGridList.content.getChild(itemFoc)
        item.setIconVisible = true
        item.setNameVisible = 1.0
        if itemUnfoc = -1
            'If the focus comes to the list for first time, there is no previous item that had focus.
            'So, we need not set the icon visibility to false and change the opacity of the name.
            return
        end if
        unfocItem = m.leftMarkUpGridList.content.getChild(itemUnfoc)
        unfocItem.setIconVisible = false
        unfocItem.setNameVisible = 0.5
    else
        if itemFoc = -1
            'If the focus comes to the list for first time, there is no previous item that had focus.
            'So, we need not set the icon visibility to false and change the opacity of the name.
            return
        end if
        unfocItem = m.leftMarkUpGridList.content.getChild(itemFoc)
        unfocItem.setIconVisible = false
        unfocItem.setNameVisible = 0.5
    end if
end sub

function getUnfocusedItemIndex() as Integer
    unFocusedItemIndex = m.leftMarkUpGridList.itemUnfocused
    return unFocusedItemIndex
end function

function getUnfocusedItem() as object
    unfocusedItem = m.leftMarkUpGridList.content.getChild(getUnfocusedItemIndex())
    return unfocusedItem
end function

function getFocusedItemIndex() as Integer
    focusedItemIndex = m.leftMarkUpGridList.itemFocused
    return focusedItemIndex
end function

function getFocusedItem() as object
    focusedItem = m.leftMarkUpGridList.content.getChild(getFocusedItemIndex())
    return focusedItem
end function

sub handleOnMarkUpGridFocused()
   
    setLabelIconAndLabelOpacity(getFocusedItemIndex(), getUnfocusedItemIndex(), true)
    focusedItem = getFocusedItem()
    if focusedItem.name = "Sign out"
        m.previousComp.visible = false
    else 
        compToRender = getComponent(focusedItem.componentName)
        renderComponent(compToRender, "focused")
    end if
end sub

' sub setLastFocusedItemIndex(i as integer)
'     m.lastFocusedItemIndex = i
' end sub

' function getLastFocusedItemIndex() as integer
'     return m.lastFocusedItemIndex
' end function

sub setScrollForMoreLabel()
    i = m.lastRenderedItemIndex
    if i = 0
        setTopScrollForMoreLabel(false)
        setBottomScrollForMoreLabel(true)
    else if getFocusedItemIndex() = 4
        setTopScrollForMoreLabel(true)
        setBottomScrollForMoreLabel(false)
    else
        setTopScrollForMoreLabel(true)
        setBottomScrollForMoreLabel(true) 
    end if
end sub

sub onMarkUpGridFocused()

    setScrollForMoreLabel() 'If the item focused is last item in the list (Sign out)
    ' i = getFocusedItemIndex()
    ' setLastFocusedItemIndex(i)
    handleOnMarkUpGridFocused()
end sub

sub setHomeComponent()

    m.lastRenderedItemIndex = 0
    m.previousComp = m.homeComponentId
    m.previousComp.visible = true
    m.previousComp.setFocus = true
    setScrollForMoreLabel()
end sub

sub onMarkUpGridSelected()
    
    selectedItemIndex = m.leftMarkUpGridList.itemSelected
    m.selectedItemOfLeftMarkUpGrid = selectedItemIndex
    selectedItem = getSelectedItem()
    selectedItem.setIconVisible = false 
    if selectedItem.name = "Sign out"
        m.previousComp.visible = false
        onLogoutButtonSelected()
    else 
        compToRender = getComponent(selectedItem.componentName)
        renderComponent(compToRender, "selected")
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


sub renderComponent(compToRender as object, operationPerformed as String)
    m.selectedItemOfLeftMarkUpGrid = compToRender.index
    m.lastRenderedItemIndex =  compToRender.index
    if operationPerformed = "selected"
        compToRender.setFocus = true
    else
        m.previousComp.visible = false
        m.previousComp = compToRender
        compToRender.visible = true
    end if
    setScrollForMoreLabel()
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
            "iconUri": "pkg:/images/separated/sideBarIcon2.png",
            ' "iconUri": "pkg:/images/separated/homeIconColored.png",
            "componentName": "homeComponentId"            
        },
        {
            "name": "Top News",
            "iconUri": "pkg:/images/separated/sideBarIcon2.png",
            ' "iconUri": "pkg:/images/separated/searchIconBlue2.png",
            "componentName": "searchComponentId"
        },
        {
            "name": "Profile",
            "iconUri": "pkg:/images/separated/sideBarIcon2.png",
            ' "iconUri": "pkg:/images/separated/profileIcon.png",
            "componentName": "profileComponentId"
        },
        {
            "name": "Shows",
            "iconUri": "pkg:/images/separated/sideBarIcon2.png",
            ' "iconUri": "pkg:/images/separated/liveIcon.png",
            "componentName": "timeGridComponentId"
        },
        {
            "name": "Sign out",
            "iconUri": "pkg:/images/separated/sideBarIcon2.png",
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
    if m.selectedItemOfLeftMarkUpGrid = 0
        m.playButton.setFocus(true)
    else if m.selectedItemOfLeftMarkUpGrid = 1
        m.searchComponentId.afterOnFirstVideoMUGSelected = true
    else 
        m.leftMarkUpGridList.setFocus(true)
    end if
end sub

sub setTopScrollForMoreLabel(visibility)
    m.scrollForMoreUp.visible = visibility
end sub

sub setBottomScrollForMoreLabel(visibility)
    m.scrollForMoreDown.visible = visibility
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "right"
            if m.leftMarkUpGridList.hasFocus()
                print " m.lastRenderedItemIndex: " m.lastRenderedItemIndex
                if getFocusedItemIndex() = 4
                    return true
                end if
                
                m.selectedItemOfLeftMarkUpGrid = m.leftMarkUpGridList.itemFocused
                itemFoc = m.leftMarkUpGridList.content.getChild(m.leftMarkUpGridList.itemFocused)
                itemFoc.setIconVisible = false
                m.lastRenderedItemIndex =  m.previousComp.index
                m.previousComp.setFocus = true
                return true
            end if
        else if key = "left"
             if m.playButton.hasFocus()
                m.playButton.setFocus(false)
                m.leftMarkUpGridList.setFocus(true)
                return true
            else if NOT m.leftMarkUpGridList.hasFocus() 
                m.leftMarkUpGridList.setFocus(true)
                return true
            else
                m.leftMarkUpGridList.setFocus(true)
            end if
        else if key = "back"
            if m.leftMarkUpGridList.hasFocus()
                return true
            end if
            m.leftMarkUpGridList.setFocus(true)
            return true
        else if key = "up"
         
            if not m.leftMarkUpGridList.hasFocus()
                
                moveScreen("original", 0)
                handleScrollForMoreUp()
                return true
            end if
        else if key = "down"
            if not m.leftMarkUpGridList.hasFocus()
                
                moveScreen("original", 0)
                if m.lastRenderedItemIndex = 3
                    m.leftMarkUpGridList.jumpToItem = 4
                    UnFocusedItem = m.leftMarkUpGridList.content.getChild(m.lastRenderedItemIndex)
                    comp = getComponent(UnFocusedItem.componentName)
                    comp.visible = false
                    UnFocusedItem.setIconVisible = false
                    UnFocusedItem.setNameVisible = 0.5
                    m.lastRenderedItemIndex = 4
                    m.leftMarkUpGridList.setFocus(true)
                    return true
                end if

                handleScrollForMoreDown()
                return true
            end if
        end if
    return false
    end if
end function

sub handleScrollForMoreUp()
    if getLastRenderedItem() = 0
        return
    end if
    indexOfItemToBeRendered = getLastRenderedItem() - 1
    item = m.leftMarkUpGridList.content.getChild(indexOfItemToBeRendered)
    compToRender = getComponent(item.componentName)
    setLabelIconAndLabelOpacityWhenMUGIsUnfocused(indexOfItemToBeRendered, getLastRenderedItem())
    renderComponent(compToRender, "focused")
    setScrollForMoreLabel()
    compToRender.setFocus = true
    m.leftMarkUpGridList.jumpToItem = getLastRenderedItem()
end sub


sub handleScrollForMoreDown()
    
    
    if getLastRenderedItem() = 3
        setFocusToSignOut()
        return
    end if
    indexOfItemToBeRendered = getLastRenderedItem() + 1
    item = m.leftMarkUpGridList.content.getChild(indexOfItemToBeRendered)
    compToRender = getComponent(item.componentName)
    setLabelIconAndLabelOpacityWhenMUGIsUnfocused(indexOfItemToBeRendered, getLastRenderedItem())
    renderComponent(compToRender, "focused")
    setScrollForMoreLabel()
    compToRender.setFocus = true
    m.leftMarkUpGridList.jumpToItem = getLastRenderedItem()
end sub

sub setFocusToSignOut()
    m.leftMarkUpGridList.jumpToItem = 4
end sub

function getLastRenderedItem()
    return m.lastRenderedItemIndex
end function

sub handleToParentData(event)
    dataFromChild = event.getData()
    if dataFromChild.action = "componentCreation"
        m.top.toChildData = dataFromChild.pageData
        m.top.getScene().compToPush = dataFromChild.componentName
    else if dataFromChild.action = "moveScreen"
        if dataFromChild.component = "searchComponent"
            moveScreen(dataFromChild.direction, dataFromChild.spaceToMove)
        end if
        
    end if
end sub

sub moveScreen(direction, spaceToMove)
    xCoordinate = m.layoutGroupId.translation[0]
    if direction = "right"
        
        m.layoutGroupInterpRightMovingScreen.keyValue = [[xCoordinate, 130], [xCoordinate-spaceToMove, 130]]
        m.layoutGroupAnimationRightMovingScreen.control = "start"
        
    else if direction="left"
        
        m.layoutGroupInterpLeftMovingScreen.keyValue = [[xCoordinate, 130], [xCoordinate+spaceToMove, 130]]
        m.layoutGroupAnimationLeftMovingScreen.control = "start"

    else
        m.layoutGroupInterpLeftMovingScreen.keyValue = [[xCoordinate, 130], [-25, 130]]
        m.layoutGroupAnimationLeftMovingScreen.control = "start"
    end if
    
end sub