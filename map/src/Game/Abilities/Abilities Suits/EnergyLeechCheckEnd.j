function Trig_EnergyLeechCheckEnd_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07X')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_EnergyLeechCheckEnd_Actions takes nothing returns nothing 
    local timer l = LoadTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("EnergyLeech_CheckTimer")) 
    call FlushChildHashtable(LS(), GetHandleId(l)) 
    call PauseTimer(l) 
    call DestroyTimer(l) 
endfunction 

//=========================================================================== 
function InitTrig_EnergyLeechCheckEnd takes nothing returns nothing 
    set gg_trg_EnergyLeechCheckEnd = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_EnergyLeechCheckEnd, EVENT_PLAYER_UNIT_SPELL_ENDCAST) 
    call TriggerAddCondition(gg_trg_EnergyLeechCheckEnd, Condition(function Trig_EnergyLeechCheckEnd_Conditions)) 
    call TriggerAddAction(gg_trg_EnergyLeechCheckEnd, function Trig_EnergyLeechCheckEnd_Actions) 
endfunction 

