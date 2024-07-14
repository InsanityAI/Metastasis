function Trig_GravitationalPush_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A080' ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A079', GetSpellTargetUnit()) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_GravitationalPush_Actions takes nothing returns nothing
    call Push2(GetSpellTargetUnit(),250.0,300.0,AngleBetweenUnits(GetSpellAbilityUnit(),GetSpellTargetUnit()))
endfunction

//===========================================================================
function InitTrig_GravitationalPush takes nothing returns nothing
    set gg_trg_GravitationalPush = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_GravitationalPush, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_GravitationalPush, Condition( function Trig_GravitationalPush_Conditions ) )
    call TriggerAddAction( gg_trg_GravitationalPush, function Trig_GravitationalPush_Actions )
endfunction

