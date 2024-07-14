function Trig_ATMAcquire_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A06T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ATMAcquire_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h006' ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A06R', GetSpellTargetUnit()) == 0 ) ) then
        return false
    endif
    if ( not ( udg_Kyo_ATM_Armed == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ATMAcquire_Actions takes nothing returns nothing
    if ( Trig_ATMAcquire_Func003C() ) then
        set udg_Kyo_ATM_Armed = true
        set udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
        call SetSoundPositionLocBJ( gg_snd_Lever, udg_TempPoint, 0 )
        call PlaySoundBJ( gg_snd_Lever )
        call RemoveItem( GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I01T') )
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl" )
        call SFXThreadClean()
        call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl" )
        call SFXThreadClean()
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl" )
        call SFXThreadClean()
        call RemoveLocation(udg_TempPoint)
        set udg_TempUnit = gg_unit_h007_0027
        set udg_Kyo_ATM_LightningRing=LightningRing(udg_TempUnit)
        call UnitAddAbilityBJ( 'A06U', gg_unit_h007_0027 )
    else
    endif
endfunction

//===========================================================================
function InitTrig_ATMAcquire takes nothing returns nothing
    set gg_trg_ATMAcquire = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ATMAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ATMAcquire, Condition( function Trig_ATMAcquire_Conditions ) )
    call TriggerAddAction( gg_trg_ATMAcquire, function Trig_ATMAcquire_Actions )
endfunction

