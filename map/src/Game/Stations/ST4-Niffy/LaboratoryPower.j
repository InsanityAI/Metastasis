function Trig_LaboratoryPower_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A06F')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_LaboratoryPower_Actions takes nothing returns nothing 
    call TriggerExecute(gg_trg_ResetPowerBonus) 
    set udg_Power_Bonus = 4 
    call EnableTrigger(gg_trg_LaboratorySpawnExperiments) 
    call PlaySoundBJ(gg_snd_LightningShieldTarget) 
    call SetUnitAnimation(gg_unit_h049_0139, "work") 
    set udg_TempUnit = gg_unit_h049_0139 
    call PauseUnitBJ(false, gg_unit_h049_0139) 
    call RemoveUnitPeriodPause(udg_TempUnit) 
    call PacificationBotEnable() 
endfunction 

//=========================================================================== 
function InitTrig_LaboratoryPower takes nothing returns nothing 
    set gg_trg_LaboratoryPower = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LaboratoryPower, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_LaboratoryPower, Condition(function Trig_LaboratoryPower_Conditions)) 
    call TriggerAddAction(gg_trg_LaboratoryPower, function Trig_LaboratoryPower_Actions) 
endfunction 

