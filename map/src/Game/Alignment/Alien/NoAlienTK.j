function Trig_NoAlienTK_Func002Func002C takes nothing returns boolean 
    if((GetOwningPlayer(GetAttackedUnitBJ()) == udg_Parasite)) then 
        return true 
    endif 
    if((GetOwningPlayer(GetAttackedUnitBJ()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_NoAlienTK_Func002Func003Func002C takes nothing returns boolean 
    if((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())])] == true)) then 
        return true 
    endif 
    if((udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())] == Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return true 
    endif 
    if((udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())] == udg_Parasite)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_NoAlienTK_Func002Func003C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetAttackedUnitBJ()) == 'h02P')) then 
        return false 
    endif 
    if(not Trig_NoAlienTK_Func002Func003Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NoAlienTK_Func002C takes nothing returns boolean 
    if((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))] == true)) then 
        return true 
    endif 
    if(Trig_NoAlienTK_Func002Func002C()) then 
        return true 
    endif 
    if(Trig_NoAlienTK_Func002Func003C()) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_NoAlienTK_Conditions takes nothing returns boolean 
    if(not(udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))] == true)) then 
        return false 
    endif 
    if(not Trig_NoAlienTK_Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NoAlienTK_Actions takes nothing returns nothing 
    call IssueImmediateOrderBJ(GetAttacker(), "stop") 
    call DisplayTimedTextToPlayer(GetOwningPlayer(GetAttacker()), 0, 0, 30, "|cffFF0000You cannot attack your fellow alien!|r") 
endfunction 

//=========================================================================== 
function InitTrig_NoAlienTK takes nothing returns nothing 
    set gg_trg_NoAlienTK = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_NoAlienTK, EVENT_PLAYER_UNIT_ATTACKED) 
    call TriggerAddCondition(gg_trg_NoAlienTK, Condition(function Trig_NoAlienTK_Conditions)) 
    call TriggerAddAction(gg_trg_NoAlienTK, function Trig_NoAlienTK_Actions) 
endfunction 

