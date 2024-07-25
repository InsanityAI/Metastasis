function Trig_RDGLimit_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A056')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RDGLimit_Func001002002001 takes nothing returns boolean 
    return(IsUnitAliveBJ(GetFilterUnit()) == true) 
endfunction 

function Trig_RDGLimit_Func001002002002 takes nothing returns boolean 
    return(GetUnitTypeId(GetFilterUnit()) == 'e018') 
endfunction 

function Trig_RDGLimit_Func001002002 takes nothing returns boolean 
    return GetBooleanAnd(Trig_RDGLimit_Func001002002001(), Trig_RDGLimit_Func001002002002()) 
endfunction 

function Trig_RDGLimit_Func002C takes nothing returns boolean 
    if(not(CountUnitsInGroup(udg_TempUnitGroup) >= 4)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RDGLimit_Actions takes nothing returns nothing 
    local boolexpr be = Condition(function Trig_RDGLimit_Func001002002) 
    set udg_TempUnitGroup = GetUnitsOfPlayerMatching(GetOwningPlayer(GetTriggerUnit()), be) 
    if(Trig_RDGLimit_Func002C()) then 
        call IssueImmediateOrder(GetSpellAbilityUnit(), "stop") 
    else 
    endif 
    call DestroyGroup(udg_TempUnitGroup) 
    call DestroyBoolExpr(be) 
    set be = null 
endfunction 

//=========================================================================== 
function InitTrig_RDGLimit takes nothing returns nothing 
    set gg_trg_RDGLimit = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_RDGLimit, EVENT_PLAYER_UNIT_SPELL_CAST) 
    call TriggerAddCondition(gg_trg_RDGLimit, Condition(function Trig_RDGLimit_Conditions)) 
    call TriggerAddAction(gg_trg_RDGLimit, function Trig_RDGLimit_Actions) 
endfunction 

