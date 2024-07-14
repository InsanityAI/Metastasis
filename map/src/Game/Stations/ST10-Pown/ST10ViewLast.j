function Trig_ST10ViewLast_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A084' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST10ViewLast_Actions takes nothing returns nothing
    set udg_TempPoint=LoadLocationHandle(LS(),GetHandleId(GetSpellAbilityUnit()),StringHash("PortPlace"))
    call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0.25 )
endfunction

//===========================================================================
function InitTrig_ST10ViewLast takes nothing returns nothing
    set gg_trg_ST10ViewLast = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ST10ViewLast, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ST10ViewLast, Condition( function Trig_ST10ViewLast_Conditions ) )
    call TriggerAddAction( gg_trg_ST10ViewLast, function Trig_ST10ViewLast_Actions )
endfunction

