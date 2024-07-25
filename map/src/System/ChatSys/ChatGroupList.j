function Trig_ChatGroupList_Conditions takes nothing returns boolean 
    if(not(IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) != true)) then 
        return false 
    endif 
    if(not(SubStringBJ(GetEventPlayerChatString(), 1, 5) == "-list")) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChatGroupList_Func007Func002A takes nothing returns nothing 
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, PlayerColor_GetPlayerTextColor(GetEnumPlayer()) + GetPlayerName(GetEnumPlayer()) + "|r") 
endfunction 

function Trig_ChatGroupList_Func007C takes nothing returns boolean 
    if(not(IsPlayerInForce(GetTriggerPlayer(), udg_TempPlayerGroup) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChatGroupList_Actions takes nothing returns nothing 
    call ExecuteFunc("ClearArguments") 
    call ExecuteFunc("ParseEnteredString") 
    set udg_TempPlayerGroup = LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_arguments[2])) 
    set udg_TempString = udg_arguments[2] 
    if(Trig_ChatGroupList_Func007C()) then 
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, ("|cff808000Players in group |cff0080C0" + (udg_TempString + "|r:"))) 
        call ForForce(udg_TempPlayerGroup, function Trig_ChatGroupList_Func007Func002A) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_ChatGroupList takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_ChatGroupList = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupList, Player(i), "-list", false) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_ChatGroupList, Condition(function Trig_ChatGroupList_Conditions)) 
    call TriggerAddAction(gg_trg_ChatGroupList, function Trig_ChatGroupList_Actions) 
endfunction 

