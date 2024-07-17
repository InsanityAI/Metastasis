if Debug then Debug.beginFile "System/ChatSys/ChatGroupAlienBroadcast" end
OnInit.trig("ChatGroupAlienBroadcast", function(require)
    require "PlayerColor"
    ---@return boolean
    function Trig_ChatGroupAlienBroadcast_Conditions()
        if (not (SubStringBJ(GetEventPlayerChatString(), 1, 1) == "[")) then
            return false
        end
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) ~= true)) then
            return false
        end
        return true
    end

    function Trig_ChatGroupAlienBroadcast_Actions()
        local i = 0 ---@type integer

        --   call ExecuteFunc( "ClearArguments" )
        --  call ExecuteFunc( "ParseEnteredString" )
        if not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetTriggerPlayer())] or GetTriggerPlayer() == udg_Parasite) or Player_IsDead(GetTriggerPlayer()) then
            return
        end
        udg_arguments[2] = SubStringBJ(GetEventPlayerChatString(), 2, 99)
        while i <= 11 do
            if (udg_Player_IsParasiteSpawn[i + 1] or Player(i) == udg_Parasite) then
                DisplayTextToPlayer(Player(i), 0, 0,
                    "|cff800080" .. "[" .. "Alien" .. "]|r" .. PlayerColor[GetTriggerPlayer()] ..
                    GetPlayerName(GetTriggerPlayer()) .. "|r: " .. udg_arguments[2])
            end
            i = i + 1
        end
    end

    --===========================================================================

    local i                        = 0 ---@type integer
    gg_trg_ChatGroupAlienBroadcast = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupAlienBroadcast, Player(i), "[", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_ChatGroupAlienBroadcast, Condition(Trig_ChatGroupAlienBroadcast_Conditions))
    TriggerAddAction(gg_trg_ChatGroupAlienBroadcast, Trig_ChatGroupAlienBroadcast_Actions)
end)
if Debug then Debug.endFile() end
