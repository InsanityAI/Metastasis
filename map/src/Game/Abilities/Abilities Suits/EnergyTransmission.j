function Trig_EnergyTransmission_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A02H')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_EnergyTransmission_Func011C takes nothing returns boolean 
    if(not(GetSpellAbilityUnit() == GetSpellTargetUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_EnergyTransmission_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempPoint2 = GetUnitLoc(GetSpellTargetUnit()) 
    call AddSpecialEffectLocBJ(udg_TempPoint, "war3mapImported\\HealthGain.mdx") 
    call SFXThreadClean() 
    call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl") 
    call SFXThreadClean() 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
    if(Trig_EnergyTransmission_Func011C()) then 
        call SetUnitLifeBJ(GetSpellTargetUnit(), (GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) + 100.00)) 
    else 
        call SetUnitLifeBJ(GetSpellTargetUnit(), (GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) + 150.00)) 
        call SetUnitLifeBJ(GetSpellAbilityUnit(), (GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) -50.00)) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_EnergyTransmission takes nothing returns nothing 
    set gg_trg_EnergyTransmission = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_EnergyTransmission, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_EnergyTransmission, Condition(function Trig_EnergyTransmission_Conditions)) 
    call TriggerAddAction(gg_trg_EnergyTransmission, function Trig_EnergyTransmission_Actions) 
endfunction 

