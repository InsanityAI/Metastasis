function Trig_Rapid_Infection_Bugfix_Func002C takes nothing returns boolean 
    if((GetUnitTypeId(GetTriggerUnit()) == 'h01M')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetTriggerUnit()) == 'h01L')) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_Rapid_Infection_Bugfix_Func003C takes nothing returns boolean 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h01M')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h01L')) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_Rapid_Infection_Bugfix_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A01X')) then 
        return false 
    endif 
    if(not Trig_Rapid_Infection_Bugfix_Func002C()) then 
        return false 
    endif 
    if(not Trig_Rapid_Infection_Bugfix_Func003C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Rapid_Infection_Bugfix_Actions takes nothing returns nothing 
    call IssueImmediateOrderBJ(GetTriggerUnit(), "stop") 
endfunction 

//=========================================================================== 
function InitTrig_Rapid_Infection_Bugfix takes nothing returns nothing 
    set gg_trg_Rapid_Infection_Bugfix = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Rapid_Infection_Bugfix, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Rapid_Infection_Bugfix, Condition(function Trig_Rapid_Infection_Bugfix_Conditions)) 
    call TriggerAddAction(gg_trg_Rapid_Infection_Bugfix, function Trig_Rapid_Infection_Bugfix_Actions) 
endfunction 

