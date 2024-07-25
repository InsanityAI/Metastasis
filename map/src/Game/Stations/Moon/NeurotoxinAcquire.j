function Trig_NeurotoxinAcquire_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07C')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NeurotoxinAcquire_Func003C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'h04F')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NeurotoxinAcquire_Actions takes nothing returns nothing 
    if(Trig_NeurotoxinAcquire_Func003C()) then 
        set udg_TempUnit2 = GetSpellTargetUnit() 
        set udg_TempPoint = GetUnitLoc(GetSpellTargetUnit()) 
        call RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I01X')) 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl") 
        call SFXThreadClean() 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl") 
        call SFXThreadClean() 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl") 
        call UnitAddAbilityBJ('A07D', gg_unit_h04E_0259) 
        call SFXThreadClean() 
        call RemoveLocation(udg_TempPoint) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_NeurotoxinAcquire takes nothing returns nothing 
    set gg_trg_NeurotoxinAcquire = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_NeurotoxinAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_NeurotoxinAcquire, Condition(function Trig_NeurotoxinAcquire_Conditions)) 
    call TriggerAddAction(gg_trg_NeurotoxinAcquire, function Trig_NeurotoxinAcquire_Actions) 
endfunction 

