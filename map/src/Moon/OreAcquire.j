function Trig_OreAcquire_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A07B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_OreAcquire_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h04F' ) ) then
        return false
    endif
    return true
endfunction

function Trig_OreAcquire_Actions takes nothing returns nothing
    if ( Trig_OreAcquire_Func003C() ) then
        set udg_TempUnit2 = GetSpellTargetUnit()
        set udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
        call RemoveItem( GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I01W') )
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl" )
        call SFXThreadClean()
        call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl" )
        call SFXThreadClean()
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl" )
        call SetUnitManaBJ( gg_unit_h04E_0259, ( GetUnitStateSwap(UNIT_STATE_MANA, gg_unit_h04E_0259) + 150.00 ) )
        call SFXThreadClean()
        call RemoveLocation(udg_TempPoint)
    else
    endif
endfunction

//===========================================================================
function InitTrig_OreAcquire takes nothing returns nothing
    set gg_trg_OreAcquire = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_OreAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_OreAcquire, Condition( function Trig_OreAcquire_Conditions ) )
    call TriggerAddAction( gg_trg_OreAcquire, function Trig_OreAcquire_Actions )
endfunction

