function Trig_TacticalNuclearWarhead_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A02D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_TacticalNuclearWarhead_Actions takes nothing returns nothing
    call PauseUnitBJ( true, GetSpellAbilityUnit() )
    call AddSpecialEffectTargetUnitBJ( "origin", GetSpellAbilityUnit(), "Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedDamage.mdl" )
    call SFXThreadClean()
    set udg_TempUnit = GetSpellAbilityUnit()
    set udg_CountUpBarColor = "|cffFF80C0"
    call UnitAddAbilityForPeriod(GetSpellAbilityUnit(),'Avul',7)
    call PauseUnitForPeriod(GetSpellAbilityUnit(),7.0)
    call CountUpBar(udg_TempUnit, 40, 0.16, "TacNukeExplosion")
endfunction

//===========================================================================
function InitTrig_TacticalNuclearWarhead takes nothing returns nothing
    set gg_trg_TacticalNuclearWarhead = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_TacticalNuclearWarhead, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_TacticalNuclearWarhead, Condition( function Trig_TacticalNuclearWarhead_Conditions ) )
    call TriggerAddAction( gg_trg_TacticalNuclearWarhead, function Trig_TacticalNuclearWarhead_Actions )
endfunction

