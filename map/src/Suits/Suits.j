function Trig_Suits_Conditions takes nothing returns boolean
    if ( not ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == GetTriggerUnit() ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func004C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func005C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I001' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func006C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I007' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func007C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I008' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func008C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I009' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func009C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func010C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func011C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00C' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func012C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func013C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func014C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func015C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func016C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func017C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I011' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func018C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func019C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func020C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I020' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func021C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I021' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func022C takes nothing returns boolean
    if ( not ( SubStringBJ(I2S(GetUnitPointValue(GetTriggerUnit())), 2, 2) != "2" ) ) then
        return false
    endif
    if ( not ( udg_TempInt != 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func023Func001C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A0AF', GetManipulatingUnit()) >= 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func023Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetManipulatingUnit()) == 'h04K' ) ) then
        return false
    endif
    if ( not ( GetItemTypeId(GetManipulatedItem()) != 'I020' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Func023C takes nothing returns boolean
    if ( not ( udg_TempInt != 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suits_Actions takes nothing returns nothing
    set udg_TempInt = 0
    if ( Trig_Suits_Func004C() ) then
        set udg_TempInt = 2
    else
    endif
    if ( Trig_Suits_Func005C() ) then
        set udg_TempInt = 3
    else
    endif
    if ( Trig_Suits_Func006C() ) then
        set udg_TempInt = 4
    else
    endif
    if ( Trig_Suits_Func007C() ) then
        set udg_TempInt = 5
    else
    endif
    if ( Trig_Suits_Func008C() ) then
        set udg_TempInt = 6
    else
    endif
    if ( Trig_Suits_Func009C() ) then
        set udg_TempInt = 7
    else
    endif
    if ( Trig_Suits_Func010C() ) then
        set udg_TempInt = 8
    else
    endif
    if ( Trig_Suits_Func011C() ) then
        set udg_TempInt = 9
    else
    endif
    if ( Trig_Suits_Func012C() ) then
        set udg_TempInt = 10
    else
    endif
    if ( Trig_Suits_Func013C() ) then
        set udg_TempInt = 11
    else
    endif
    if ( Trig_Suits_Func014C() ) then
        set udg_TempInt = 12
    else
    endif
    if ( Trig_Suits_Func015C() ) then
        set udg_TempInt = 13
    else
    endif
    if ( Trig_Suits_Func016C() ) then
        set udg_TempInt = 14
    else
    endif
    if ( Trig_Suits_Func017C() ) then
        set udg_TempInt = 15
    else
    endif
    if ( Trig_Suits_Func018C() ) then
        set udg_TempInt = 16
    else
    endif
    if ( Trig_Suits_Func019C() ) then
        set udg_TempInt = 17
    else
    endif
    if ( Trig_Suits_Func020C() ) then
        set udg_TempInt = 18
    else
    endif
    if ( Trig_Suits_Func021C() ) then
        set udg_TempInt = 19
    else
    endif
    if ( Trig_Suits_Func022C() ) then
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cffffcc00This unit cannot use suits.|r")
        return
    else
    endif
    if ( Trig_Suits_Func023C() ) then
        if ( Trig_Suits_Func023Func001C() ) then
            set udg_TempItem = udg_Player_Suit[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]
            call SetItemUserData( udg_TempItem, 0 )
            call SetItemVisibleBJ( true, udg_TempItem )
            set udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
            call SetItemPositionLoc( udg_TempItem, udg_TempPoint )
            call RemoveLocation(udg_TempPoint)
            call UnitAddItemSwapped( udg_TempItem, GetManipulatingUnit() )
        else
        endif
        set udg_TempReal = GetUnitLifePercent(GetManipulatingUnit())
        call SetItemUserData( GetManipulatedItem(), GetUnitUserData(GetManipulatingUnit()) )
        if ( Trig_Suits_Func023Func004C() ) then
            if HaveSavedHandle(LS(),GetHandleId(GetManipulatingUnit()),StringHash("Suit_SlivGroup")) then
            call DestroyGroup(LoadGroupHandle(LS(),GetHandleId(GetManipulatingUnit()),StringHash("Suit_SlivGroup")))
            endif
        else
        endif
        call UnitAddAbilityBJ( 'S001', GetManipulatingUnit() )
        call SetUnitAbilityLevelSwapped( 'S001', GetManipulatingUnit(), udg_TempInt )
        set udg_Player_Suit[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] = GetManipulatedItem()
        call UnitRemoveItemSwapped( GetManipulatedItem(), GetManipulatingUnit() )
        call UnitRemoveItemSwapped( GetManipulatedItem(), GetManipulatingUnit() )
        call SetItemVisibleBJ( false, GetManipulatedItem() )
        call SetItemPawnable( GetManipulatedItem(), true )
        set udg_TempUnit = GetManipulatingUnit()
        call SetUnitLifePercentBJ( GetManipulatingUnit(), udg_TempReal )
        call ExecuteFunc("SuitRoleAbilityReAdd")
        call SetUnitLifePercentBJ( GetManipulatingUnit(), udg_TempReal )
    else
    endif
endfunction

//===========================================================================
function InitTrig_Suits takes nothing returns nothing
    set gg_trg_Suits = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Suits, EVENT_PLAYER_UNIT_USE_ITEM )
    call TriggerAddCondition( gg_trg_Suits, Condition( function Trig_Suits_Conditions ) )
    call TriggerAddAction( gg_trg_Suits, function Trig_Suits_Actions )
endfunction

