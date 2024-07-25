function Trig_NeurotoxinEnd_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07D')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NeurotoxinEnd_Actions takes nothing returns nothing 
    call DestroyTimer(LoadTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("neurotoxin_unit"))) 
    call DestroyLightning(LoadLightningHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("neuroLightning"))) 
endfunction 

//=========================================================================== 
function InitTrig_NeurotoxinEnd takes nothing returns nothing 
    set gg_trg_NeurotoxinEnd = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_NeurotoxinEnd, gg_unit_h04E_0259, EVENT_UNIT_SPELL_ENDCAST) 
    call TriggerAddCondition(gg_trg_NeurotoxinEnd, Condition(function Trig_NeurotoxinEnd_Conditions)) 
    call TriggerAddAction(gg_trg_NeurotoxinEnd, function Trig_NeurotoxinEnd_Actions) 
endfunction 

