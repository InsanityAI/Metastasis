function Trig_PhaseShift_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A00R')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PhaseShift_Actions takes nothing returns nothing 
    local unit a = GetTriggerUnit() 
    call UnitAddAbilityBJ('Avul', a) 
    call PolledWait(1) 
    call UnitRemoveAbilityBJ('Avul', a) 
endfunction 

//=========================================================================== 
function InitTrig_PhaseShift takes nothing returns nothing 
    set gg_trg_PhaseShift = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_PhaseShift, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_PhaseShift, Condition(function Trig_PhaseShift_Conditions)) 
    call TriggerAddAction(gg_trg_PhaseShift, function Trig_PhaseShift_Actions) 
endfunction 

