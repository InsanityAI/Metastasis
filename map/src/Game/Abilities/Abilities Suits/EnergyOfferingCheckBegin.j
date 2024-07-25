function Trig_EnergyOfferingCheckBegin_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A0A3')) then 
        return false 
    endif 
    return true 
endfunction 

function EnergyOfferingCheck_Again takes nothing returns nothing 
    local timer l = GetExpiredTimer() 
    local unit abil = LoadUnitHandle(LS(), GetHandleId(l), StringHash("unit")) 
    local unit targ = LoadUnitHandle(LS(), GetHandleId(l), StringHash("unit2")) 

    //User is out of mana, or target is full mana 
    if(GetUnitState(abil, UNIT_STATE_MANA) <= 1 or GetUnitState(targ, UNIT_STATE_MANA) > 99) then 
        call IssueImmediateOrder(abil, "stop") 
    endif 
endfunction 

function Trig_EnergyOfferingCheckBegin_Actions takes nothing returns nothing 
    local timer l = CreateTimer() 
    call SaveTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("EnergyOffering_CheckTimer"), l) 
    call SaveUnitHandle(LS(), GetHandleId(l), StringHash("unit"), GetSpellAbilityUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(l), StringHash("unit2"), GetSpellTargetUnit()) 
    call TimerStart(l, 0.1, true, function EnergyOfferingCheck_Again) 
endfunction 

//=========================================================================== 
function InitTrig_EnergyOfferingCheckBegin takes nothing returns nothing 
    set gg_trg_EnergyOfferingCheckBegin = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_EnergyOfferingCheckBegin, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_EnergyOfferingCheckBegin, Condition(function Trig_EnergyOfferingCheckBegin_Conditions)) 
    call TriggerAddAction(gg_trg_EnergyOfferingCheckBegin, function Trig_EnergyOfferingCheckBegin_Actions) 
endfunction 

