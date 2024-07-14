//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_RotaryDodge_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A065' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RotaryDodge_Actions takes nothing returns nothing
local unit a=GetSpellAbilityUnit()
    call UnitAddAbilityForPeriod(a,'Avul',5.0)
    call DamageAreaForPlayer(GetOwningPlayer(a),225.0,100.0,GetUnitX(GetSpellAbilityUnit()),GetUnitY(GetSpellAbilityUnit()))
   
    call UnitAddAbilityBJ( 'Amrf', a)
    call SetUnitTimeScale(a,2.0)
    call SetUnitMoveSpeed(a,420.0)
    call SetUnitFlyHeightBJ( a, 450.00, 250.00 )
    call UnitRemoveAbilityBJ( 'Amrf', a )
    call PolledWait( 4.20 )
    call UnitAddAbilityBJ( 'Amrf', a )
    call SetUnitFlyHeightBJ( a, 0.00, 587.50 )
    call UnitRemoveAbilityBJ( 'Amrf', a )
    call PolledWait( 0.70 )
        call SetUnitMoveSpeed(a,310.0)
    call SetUnitTimeScale(a,1.0)
set bj_lastCreatedEffect= AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",GetUnitX(a),GetUnitY(a))
call SFXThreadClean()
    call DamageAreaForPlayer(GetOwningPlayer(a),225.0,100.0,GetUnitX(a),GetUnitY(a))
endfunction

//===========================================================================
function InitTrig_RotaryDodge takes nothing returns nothing
    set gg_trg_RotaryDodge = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_RotaryDodge, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_RotaryDodge, Condition( function Trig_RotaryDodge_Conditions ) )
    call TriggerAddAction( gg_trg_RotaryDodge, function Trig_RotaryDodge_Actions )
endfunction

