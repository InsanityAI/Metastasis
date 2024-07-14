function Trig_Deterministic_Invigoration_Convert_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A09V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Deterministic_Invigoration_Convert_Actions takes nothing returns nothing
    call UnitRemoveAbilityBJ( 'A09V', GetTriggerUnit() )
    call UnitRemoveAbilityBJ( 'A09W', GetTriggerUnit() )
endfunction

//===========================================================================
function InitTrig_Deterministic_Invigoration_Convert takes nothing returns nothing
    set gg_trg_Deterministic_Invigoration_Convert = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Deterministic_Invigoration_Convert, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Deterministic_Invigoration_Convert, Condition( function Trig_Deterministic_Invigoration_Convert_Conditions ) )
    call TriggerAddAction( gg_trg_Deterministic_Invigoration_Convert, function Trig_Deterministic_Invigoration_Convert_Actions )
endfunction

