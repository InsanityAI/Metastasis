function Trig_ChatGroupQuickBroadcast_Conditions takes nothing returns boolean 
    return SubString(GetEventPlayerChatString(), 0, 1) == "." and not Player_IsDead(GetTriggerPlayer()) 
endfunction 

function Trig_ChatGroupQuickBroadcast_RemoveDeadPlayers takes nothing returns nothing 
    if Player_IsDead(GetEnumPlayer()) then 
        call ForceRemovePlayer(udg_TempPlayerGroup, GetEnumPlayer()) 
    endif 
endfunction 

function Trig_ChatGroupQuickBroadcast_Actions takes nothing returns nothing 
    local string message = SubString(GetEventPlayerChatString(), 1, 99) 
    local player trigPlayer = GetTriggerPlayer() 
    local integer playerId = GetConvertedPlayerId(trigPlayer) 
    if Player_IsDead(trigPlayer) then 
        return 
    endif 

    set udg_TempPlayerGroup = udg_Player_DefaultChatGroup[playerId] 
    if udg_TempPlayerGroup == null then
        call DisplayTextToPlayer(trigPlayer, 0, 0, "|cFFFF0000Error: Default group is not set!")
        return
    endif
    set message = "|cff808040" + "[" + udg_Player_DefaultChatGroupName[playerId] + "]|r" + PlayerColor_GetPlayerTextColor(trigPlayer) + GetPlayerName(trigPlayer) + "|r: " + message 
    if IsPlayerInForce(trigPlayer, udg_TempPlayerGroup) then 
        call ForForce(udg_TempPlayerGroup, function Trig_ChatGroupQuickBroadcast_RemoveDeadPlayers) 
        call DisplayTextToForce(udg_TempPlayerGroup, message) 
        call DisplayTextToForce(udg_DeadGroup, message) 
    endif 

    set message = null 
    set trigPlayer = null 
endfunction 

//===========================================================================      
function InitTrig_ChatGroupQuickBroadcast_Events takes nothing returns nothing
    call TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupQuickBroadcast, GetEnumPlayer(), ".", false) 
endfunction

function InitTrig_ChatGroupQuickBroadcast takes nothing returns nothing 
    set gg_trg_ChatGroupQuickBroadcast = CreateTrigger() 
    call ForForce(GetPlayersAll(), function InitTrig_ChatGroupQuickBroadcast_Events)
    call TriggerAddCondition(gg_trg_ChatGroupQuickBroadcast, Condition(function Trig_ChatGroupQuickBroadcast_Conditions)) 
    call TriggerAddAction(gg_trg_ChatGroupQuickBroadcast, function Trig_ChatGroupQuickBroadcast_Actions) 
endfunction 
