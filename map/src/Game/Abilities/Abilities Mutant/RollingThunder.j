function Trig_RollingThunder_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A08T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RollingThunder_Actions takes nothing returns nothing
    local unit a=GetSpellAbilityUnit()
    set udg_TempUnit=a
    call UnitRemoveAbilityBJ( 'A08T', udg_TempUnit )
    call UnitAddAbilityBJ( 'A08U', udg_TempUnit )
    call TriggerSleepAction( 15.00 )
    set udg_TempUnit=a
    call UnitRemoveAbilityBJ( 'A08U', udg_TempUnit )
    call UnitAddAbilityBJ( 'A08T', udg_TempUnit )
endfunction

//===========================================================================
function InitTrig_RollingThunder takes nothing returns nothing
    set gg_trg_RollingThunder = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_RollingThunder, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_RollingThunder, Condition( function Trig_RollingThunder_Conditions ) )
    call TriggerAddAction( gg_trg_RollingThunder, function Trig_RollingThunder_Actions )
endfunction

