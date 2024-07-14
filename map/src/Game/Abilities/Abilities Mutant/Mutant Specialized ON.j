function Trig_Mutant_Specialized_ON_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A01X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mutant_Specialized_ON_Func003C takes nothing returns boolean
    if ( not ( udg_Mutant_IsRapidGestation == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mutant_Specialized_ON_Actions takes nothing returns nothing
    if ( Trig_Mutant_Specialized_ON_Func003C() ) then
        set udg_Infection3_initiated = true
        call DestroyTrigger(GetTriggeringTrigger())
    else
    endif
endfunction

//===========================================================================
function InitTrig_Mutant_Specialized_ON takes nothing returns nothing
    set gg_trg_Mutant_Specialized_ON = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Mutant_Specialized_ON, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Mutant_Specialized_ON, Condition( function Trig_Mutant_Specialized_ON_Conditions ) )
    call TriggerAddAction( gg_trg_Mutant_Specialized_ON, function Trig_Mutant_Specialized_ON_Actions )
endfunction

