function Trig_AntiacquireRemote_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetTriggerUnit()) == udg_HiddenAndroid ) ) then
        return false
    endif
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AntiacquireRemote_Actions takes nothing returns nothing
    call UnitRemoveItemSwapped( GetManipulatedItem(), GetManipulatingUnit() )
endfunction

//===========================================================================
function InitTrig_AntiacquireRemote takes nothing returns nothing
    set gg_trg_AntiacquireRemote = CreateTrigger(  )
    call DisableTrigger( gg_trg_AntiacquireRemote )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_AntiacquireRemote, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddCondition( gg_trg_AntiacquireRemote, Condition( function Trig_AntiacquireRemote_Conditions ) )
    call TriggerAddAction( gg_trg_AntiacquireRemote, function Trig_AntiacquireRemote_Actions )
endfunction

