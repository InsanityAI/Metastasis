function Trig_Explorer_infection_Bugfix_Func001C takes nothing returns boolean 
    if((GetSpellAbilityId() == 'A013')) then 
        return true 
    endif 
    if((GetSpellAbilityId() == 'A01S')) then 
        return true 
    endif 
    if((GetSpellAbilityId() == 'A01X')) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_Explorer_infection_Bugfix_Conditions takes nothing returns boolean 
    if(not Trig_Explorer_infection_Bugfix_Func001C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Explorer_infection_Bugfix_Func003Func007C takes nothing returns boolean 
    return false 
endfunction 

function Trig_Explorer_infection_Bugfix_Func003C takes nothing returns boolean 
    if(not Trig_Explorer_infection_Bugfix_Func003Func007C()) then 
        return false 
    endif 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'h001')) then 
        return false 
    endif 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'h02I')) then 
        return false 
    endif 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'h02K')) then 
        return false 
    endif 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'h02S')) then 
        return false 
    endif 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'h03K')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Explorer_infection_Bugfix_Actions takes nothing returns nothing 
    if(Trig_Explorer_infection_Bugfix_Func003C()) then 
        call IssueImmediateOrderBJ(GetTriggerUnit(), "stop") 
        call CreateTextTagUnitBJ("TRIGSTR_4838", GetTriggerUnit(), 0, 10, 100.00, 100.00, 100, 0) 
        call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90) 
        call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false) 
        call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 5) 
        call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 4) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Explorer_infection_Bugfix takes nothing returns nothing 
    set gg_trg_Explorer_infection_Bugfix = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Explorer_infection_Bugfix, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Explorer_infection_Bugfix, Condition(function Trig_Explorer_infection_Bugfix_Conditions)) 
    call TriggerAddAction(gg_trg_Explorer_infection_Bugfix, function Trig_Explorer_infection_Bugfix_Actions) 
endfunction 

