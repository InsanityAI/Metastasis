function Trig_ARDAcquire_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A075')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ARDAcquire_Func003C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'h00A')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ARDAcquire_Actions takes nothing returns nothing 
    if(Trig_ARDAcquire_Func003C()) then 
        set udg_TempUnit2 = GetSpellTargetUnit() 
        set udg_TempPoint = GetUnitLoc(GetSpellTargetUnit()) 
        call UnitAddAbilityBJ('A074', gg_unit_h009_0029) 
        call RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I01V')) 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl") 
        call SFXThreadClean() 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl") 
        call SFXThreadClean() 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Other\\Awaken\\Awaken.mdl") 
        call SFXThreadClean() 
        call RemoveLocation(udg_TempPoint) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_ARDAcquire takes nothing returns nothing 
    set gg_trg_ARDAcquire = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ARDAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_ARDAcquire, Condition(function Trig_ARDAcquire_Conditions)) 
    call TriggerAddAction(gg_trg_ARDAcquire, function Trig_ARDAcquire_Actions) 
endfunction 

