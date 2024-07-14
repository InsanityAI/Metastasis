function Trig_CoreoverloadStop_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A06C' ) ) then
        return false
    endif
    return true
endfunction

function Trig_CoreoverloadStop_Actions takes nothing returns nothing
    call SetUnitManaBJ( GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_MANA, GetSpellAbilityUnit()) - 20.00 ) )
    call DestroyUnitBar(GetSpellAbilityUnit())
endfunction

//===========================================================================
function InitTrig_CoreoverloadStop takes nothing returns nothing
    set gg_trg_CoreoverloadStop = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_CoreoverloadStop, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
    call TriggerAddCondition( gg_trg_CoreoverloadStop, Condition( function Trig_CoreoverloadStop_Conditions ) )
    call TriggerAddAction( gg_trg_CoreoverloadStop, function Trig_CoreoverloadStop_Actions )
endfunction

