function Trig_Water_shield_Effect_Func003Func007Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnumUnit()) != 'n00I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Water_shield_Effect_Func003Func007A takes nothing returns nothing
    if ( Trig_Water_shield_Effect_Func003Func007Func001C() ) then
        call UnitDamageTargetBJ( udg_Alodimensional_Being, GetEnumUnit(), 5.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL )
    else
    endif
endfunction

function Trig_Water_shield_Effect_Func003C takes nothing returns boolean
    if ( not ( IsUnitDeadBJ(udg_Alodimensional_Being) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Water_shield_Effect_Func004C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_MANA, udg_Alodimensional_Being) <= 5.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Water_shield_Effect_Actions takes nothing returns nothing
    set udg_TempLoc3 = GetUnitLoc(udg_Alodimensional_Being)
    if ( Trig_Water_shield_Effect_Func003C() ) then
        call AddSpecialEffectLocBJ( PolarProjectionBJ(udg_TempLoc3, 100.00, udg_Water_Shield_Number), "Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl" )
        call DestroyEffectBJ( GetLastCreatedEffectBJ() )
        set udg_Water_Shield_Number = ( udg_Water_Shield_Number + 20.00 )
        set udg_TempUnitGroup2 = GetUnitsInRangeOfLocAll(280.00, udg_TempLoc3)
        call ForGroupBJ( udg_TempUnitGroup2, function Trig_Water_shield_Effect_Func003Func007A )
        call DestroyGroup(udg_TempUnitGroup2)
        call RemoveLocation(udg_TempLoc3)
    else
        call DisableTrigger( GetTriggeringTrigger() )
        return
    endif
    if ( Trig_Water_shield_Effect_Func004C() ) then
        call RemoveUnit( udg_Alodimensional_Being )
        call DisableTrigger( gg_trg_Alodimensional1 )
        call DisableTrigger( GetTriggeringTrigger() )
    else
    endif
endfunction

//===========================================================================
function InitTrig_Water_shield_Effect takes nothing returns nothing
    set gg_trg_Water_shield_Effect = CreateTrigger(  )
    call DisableTrigger( gg_trg_Water_shield_Effect )
    call TriggerRegisterTimerEventPeriodic( gg_trg_Water_shield_Effect, 0.03 )
    call TriggerAddAction( gg_trg_Water_shield_Effect, function Trig_Water_shield_Effect_Actions )
endfunction

