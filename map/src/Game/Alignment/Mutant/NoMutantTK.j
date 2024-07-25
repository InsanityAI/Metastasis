function Trig_NoMutantTK_Func002Func003Func002C takes nothing returns boolean 
    if((udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())])] == true)) then 
        return true 
    endif 
    if((udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())] == udg_Mutant)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_NoMutantTK_Func002Func003C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetAttackedUnitBJ()) == 'h02P')) then 
        return false 
    endif 
    if(not Trig_NoMutantTK_Func002Func003Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NoMutantTK_Func002C takes nothing returns boolean 
    if((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))] == true)) then 
        return true 
    endif 
    if((GetOwningPlayer(GetAttackedUnitBJ()) == udg_Mutant)) then 
        return true 
    endif 
    if(Trig_NoMutantTK_Func002Func003C()) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_NoMutantTK_Conditions takes nothing returns boolean 
    if(not(udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))] == true)) then 
        return false 
    endif 
    if(not Trig_NoMutantTK_Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NoMutantTK_Actions takes nothing returns nothing 
    call IssueImmediateOrderBJ(GetAttacker(), "stop") 
    call DisplayTimedTextToPlayer(GetOwningPlayer(GetAttacker()), 0, 0, 30, "|cffFF0000You cannot attack your fellow mutant!|r") 
endfunction 

//=========================================================================== 
function InitTrig_NoMutantTK takes nothing returns nothing 
    set gg_trg_NoMutantTK = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_NoMutantTK, EVENT_PLAYER_UNIT_ATTACKED) 
    call TriggerAddCondition(gg_trg_NoMutantTK, Condition(function Trig_NoMutantTK_Conditions)) 
    call TriggerAddAction(gg_trg_NoMutantTK, function Trig_NoMutantTK_Actions) 
endfunction 

