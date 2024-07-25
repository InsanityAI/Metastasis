function Trig_ParasiteRemovePrion_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A02N')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ParasiteRemovePrion_Func003C takes nothing returns boolean 
    if(not(udg_Infection3_initiated == true)) then 
        return false 
    endif 
    if(not(UnitHasBuffBJ(GetSpellTargetUnit(), 'B009') == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ParasiteRemovePrion_Actions takes nothing returns nothing 
    if(Trig_ParasiteRemovePrion_Func003C()) then 
        call IssueImmediateOrderBJ(GetTriggerUnit(), "stop") 
    else 
        call UnitRemoveBuffBJ('B009', GetSpellTargetUnit()) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_ParasiteRemovePrion takes nothing returns nothing 
    set gg_trg_ParasiteRemovePrion = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ParasiteRemovePrion, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_ParasiteRemovePrion, Condition(function Trig_ParasiteRemovePrion_Conditions)) 
    call TriggerAddAction(gg_trg_ParasiteRemovePrion, function Trig_ParasiteRemovePrion_Actions) 
endfunction 

