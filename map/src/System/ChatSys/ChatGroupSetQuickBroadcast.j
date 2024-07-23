function Trig_ChatGroupSetQuickBroadcast_Conditions takes nothing returns boolean 
    if(not(SubStringBJ(GetEventPlayerChatString(), 1, 8) == "-default")) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChatGroupSetQuickBroadcast_Actions takes nothing returns nothing 
    local string recepientGroupName = SubString(GetEventPlayerChatString(), 9, 99)
    local force recepientGroup = LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(recepientGroupName)) 
    local player trigPlayer = GetTriggerPlayer()
    local integer playerId = GetConvertedPlayerId(trigPlayer)

    if recepientGroup == null then 
        call DisplayTextToPlayer(trigPlayer, 0, 0, "|cFFFF0000Error: Chat group not found.|r") 
    else 
        call DisplayTextToPlayer(trigPlayer, 0, 0, "Chat group default set.")
        set udg_Player_DefaultChatGroup[playerId] = recepientGroup 
        set udg_Player_DefaultChatGroupName[playerId] = recepientGroupName
    endif 

    set recepientGroupName = null
    set recepientGroup = null 
    set trigPlayer = null
endfunction 

//===========================================================================  
function InitTrig_ChatGroupSetQuickBroadcast takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_ChatGroupSetQuickBroadcast = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupSetQuickBroadcast, Player(i), "-default", false) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_ChatGroupSetQuickBroadcast, Condition(function Trig_ChatGroupSetQuickBroadcast_Conditions)) 
    call TriggerAddAction(gg_trg_ChatGroupSetQuickBroadcast, function Trig_ChatGroupSetQuickBroadcast_Actions) 
endfunction 

