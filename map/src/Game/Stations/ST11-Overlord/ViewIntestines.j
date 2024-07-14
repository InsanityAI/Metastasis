function Trig_ViewIntestines_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A08M' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ViewIntestines_Actions takes nothing returns nothing
    set udg_TempPoint = GetRectCenter(gg_rct_OverlordRect)
    call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0 )
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_ViewIntestines takes nothing returns nothing
    set gg_trg_ViewIntestines = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ViewIntestines, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddCondition( gg_trg_ViewIntestines, Condition( function Trig_ViewIntestines_Conditions ) )
    call TriggerAddAction( gg_trg_ViewIntestines, function Trig_ViewIntestines_Actions )
endfunction

