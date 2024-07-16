function Trig_Item_drop_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'n00I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Item_drop_Actions takes nothing returns nothing
    set udg_TempLoc = GetUnitLoc(GetTriggerUnit())
    call CreateItemLoc( 'I02X', udg_TempLoc )
    call DisableTrigger( gg_trg_Alodimensional_A_I )
    call RemoveLocation(udg_TempLoc)
endfunction

//===========================================================================
function InitTrig_Item_drop takes nothing returns nothing
    set gg_trg_Item_drop = CreateTrigger(  )
    call TriggerRegisterPlayerUnitEventSimple( gg_trg_Item_drop, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( gg_trg_Item_drop, Condition( function Trig_Item_drop_Conditions ) )
    call TriggerAddAction( gg_trg_Item_drop, function Trig_Item_drop_Actions )
endfunction

