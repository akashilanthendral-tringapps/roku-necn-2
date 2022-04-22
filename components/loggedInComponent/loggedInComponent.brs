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

    setLeftMarkUpGridItems()
    setHomeComponent()
end sub

sub onMarkUpGridUnfocused()
    print "onMarkUpGridUnfocused()"

    setLabelIconAndLabelOpacity(-1, -1, false)
    
end sub

sub removeYellow(itemUnfoc as object)
    itemUnfoc.setIconVisible = false
end sub

sub setLabelIconAndLabelOpacityWhenMUGIsUnfocused(itemFoc as integer, itemUnfoc as integer, boolValue as boolean)
    if boolValue
        print "boolValue: true"
        item = m.leftMarkUpGridList.content.getChild(itemFoc)
        
        item.setIconVisible = false

        item.setNameVisible = 1.0
        print "item: "item

        ' m.unfocusedItemIndex = m.leftMarkUpGridList.itemUnfocused
        ' if m.unfocusedItemIndex = -1
        '     return
        ' end if
        if itemUnfoc = -1
            return
        end if
        unfocItem = m.leftMarkUpGridList.content.getChild(itemUnfoc)
        unfocItem.setIconVisible = false
        unfocItem.setNameVisible = 0.5
    else
        print "boolValue: false"
        print "CALLED FROM ITEM UNFOCUSED"
        ' if m.unfocusedItemIndex = -1
        '     return
        ' end if
        ' m.unfocusedItem = m.leftMarkUpGridList.content.getChild(m.unfocusedItemIndex)
        ' m.unfocusedItem.setIconVisible = false
        ' m.unfocusedItem.setNameVisible = 0.5
        if itemFoc = -1
            return
        end if
        unfocItem = m.leftMarkUpGridList.content.getChild(itemFoc)
        unfocItem.setIconVisible = false
        unfocItem.setNameVisible = 0.5
        print "unfocItem: "unfocItem

    end if
end sub

sub setLabelIconAndLabelOpacity(itemFoc as integer, itemUnfoc as integer, boolValue as boolean)
    print "setLabelIconAndLabelOpacity()"
    if boolValue
        print "boolValue: true"
        item = m.leftMarkUpGridList.content.getChild(itemFoc)
        
        item.setIconVisible = true

        item.setNameVisible = 1.0
        print "item: "item

        ' m.unfocusedItemIndex = m.leftMarkUpGridList.itemUnfocused
        ' if m.unfocusedItemIndex = -1
        '     return
        ' end if
        if itemUnfoc = -1
            return
        end if
        unfocItem = m.leftMarkUpGridList.content.getChild(itemUnfoc)
        unfocItem.setIconVisible = false
        unfocItem.setNameVisible = 0.5
    else
        print "boolValue: false"
        print "CALLED FROM ITEM UNFOCUSED"
        ' if m.unfocusedItemIndex = -1
        '     return
        ' end if
        ' m.unfocusedItem = m.leftMarkUpGridList.content.getChild(m.unfocusedItemIndex)
        ' m.unfocusedItem.setIconVisible = false
        ' m.unfocusedItem.setNameVisible = 0.5
        if itemFoc = -1
            return
        end if
        unfocItem = m.leftMarkUpGridList.content.getChild(itemFoc)
        unfocItem.setIconVisible = false
        unfocItem.setNameVisible = 0.5
        print "unfocItem: "unfocItem

    end if
    print "END setLabelIconAndLabelOpacity()"
    print "...................."
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

sub handleOnMarkUpGridFocused(itemIndex)
    print "handleOnMarkUpGridFocused()"
    setLabelIconAndLabelOpacity(getFocusedItemIndex(), getUnfocusedItemIndex(), true)
    focusedItem = getFocusedItem()
    if not focusedItem.name = "Sign out"
        compToRender = getComponent(focusedItem.componentName)
        renderComponent(compToRender, "focused")
    end if

end sub

sub setLastFocusedItemIndex(i as integer)
    m.lastFocusedItemIndex = i
end sub

function getLastFocusedItemIndex() as integer
    return m.lastFocusedItemIndex
end function

sub onMarkUpGridFocused()
    print "onMarkUpGridFocused()"
    i = getFocusedItemIndex()
    setLastFocusedItemIndex(i)
    handleOnMarkUpGridFocused(i)
end sub

sub setHomeComponent()
    print "setHomeComponent()"
    m.lastRenderedItemIndex = 0
    m.previousComp = m.homeComponentId
    m.previousComp.visible = true
    m.previousComp.setFocus = true
    print "END setHomeComponent()"
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
    print "renderComponent()"
    print "compToRender: "compToRender
    m.lastRenderedItemIndex =  compToRender.index
   
    if operationPerformed = "selected"
        compToRender.setFocus = true
    else
        m.previousComp.visible = false
        m.previousComp = compToRender
        compToRender.visible = true
    end if
    print "END of rendercomponent()"
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
                if m.lastRenderedItemIndex = 4
                    m.leftMarkUpGridList.setFocus(true)
                    return true
                end if
                m.selectedItemOfLeftMarkUpGrid = m.leftMarkUpGridList.itemFocused
                itemFoc = m.leftMarkUpGridList.content.getChild(m.leftMarkUpGridList.itemFocused)
                itemFoc.setIconVisible = false
                m.lastRenderedItemIndex =  m.previousComp.index
                m.previousComp.setFocus = true
                'm.selectedItemOfLeftMarkUpGrid = m.leftMarkUpGridList.itemFocused

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
        else if key = "up"
            print "key = up"
            if not m.leftMarkUpGridList.hasFocus()
                print "loggedincomponent: handleScrollForMoreUp() is called!!!"
                handleScrollForMoreUp()
                return true
            end if
        else if key = "down"
            print "key = down"
            if not m.leftMarkUpGridList.hasFocus()
                print "loggedincomponent: handleScrollForMoreDown() is called!!!"
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

sub scrollForMoreRenderComponent(compToRender as object)

    print "scrollForMoreRenderComponent()"
    print "compToRender: "compToRender
    print "previous comp: "m.previousComp
    'm.previousComp.setFocus = false
    m.previousComp.visible = false
    m.previousComp = compToRender
    m.lastRenderedItemIndex = compToRender.index
    compToRender.visible = true
    compToRender.setFocus = true
    m.leftMarkUpGridList.jumpToItem = compToRender.index

end sub

sub setLabelIconAndLabelOpacityAfterScrollForMoreUp()
    print "setLabelIconAndLabelOpacityAfterScrollForMoreUp() "
    print "m.lastRenderedItemIndex: "m.lastRenderedItemIndex
    UnFocusedItem = m.leftMarkUpGridList.content.getChild(m.lastRenderedItemIndex)
    UnFocusedItem.setIconVisible = false
    UnFocusedItem.setNameVisible = 0.5

    focusedItem = m.leftMarkUpGridList.content.getChild(m.lastRenderedItemIndex - 1)
    focusedItem.setIconVisible = false 
    focusedItem.setNameVisible = 1.0
end sub

sub setLabelIconAndLabelOpacityAfterScrollForMoreDown()

    print "m.lastRenderedItemIndex: "m.lastRenderedItemIndex
    UnFocusedItem = m.leftMarkUpGridList.content.getChild(m.lastRenderedItemIndex)
    UnFocusedItem.setIconVisible = false
    UnFocusedItem.setNameVisible = 0.5
    focusedItem = m.leftMarkUpGridList.content.getChild(m.lastRenderedItemIndex + 1) 
    focusedItem.setIconVisible = false
    focusedItem.setNameVisible = 1.0
end sub

sub handleScrollForMoreUp()
    if getLastRenderedItem() = 0
        return
    end if
    indexOfItemToBeRendered = getLastRenderedItem() - 1
    item = m.leftMarkUpGridList.content.getChild(indexOfItemToBeRendered)
    compToRender = getComponent(item.componentName)
    setLabelIconAndLabelOpacityWhenMUGIsUnfocused(indexOfItemToBeRendered, getLastRenderedItem(), true)
    renderComponent(compToRender, "focused")
    compToRender.setFocus = true
    m.leftMarkUpGridList.jumpToItem = getLastRenderedItem()
    ' print "handleScrollForMoreUp()"
    ' if m.lastRenderedItemIndex = 0
    '     return
    ' else
    '     focusedItemInMUG = m.leftMarkUpGridList.content.getChild( m.lastRenderedItemIndex - 1)
    '     compToRender = getComponent(focusedItemInMUG.componentName)
    ' end if
    ' setLabelIconAndLabelOpacityAfterScrollForMoreUp()
    ' scrollForMoreRenderComponent(compToRender)
end sub


sub handleScrollForMoreDown()
    print "handleScrollForMoreDown()"
    
    if getLastRenderedItem() = 3
        setFocusToSignOut()
        return
    end if
    indexOfItemToBeRendered = getLastRenderedItem() + 1
    item = m.leftMarkUpGridList.content.getChild(indexOfItemToBeRendered)
    compToRender = getComponent(item.componentName)
    setLabelIconAndLabelOpacityWhenMUGIsUnfocused(indexOfItemToBeRendered, getLastRenderedItem(), true)
    renderComponent(compToRender, "focused")
    compToRender.setFocus = true
    m.leftMarkUpGridList.jumpToItem = getLastRenderedItem()
end sub

sub setFocusToSignOut()
    print "setFocusToSignOut()"
    m.leftMarkUpGridList.jumpToItem = 4
    print "END setFocusToSignOut()"
end sub

function getLastRenderedItem()
    return m.lastRenderedItemIndex
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