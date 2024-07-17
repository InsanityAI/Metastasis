if Debug then Debug.beginFile "System/ChatSys/ChatGroupMutantBroadcast" end
OnInit.trig("ChatGroupMutantBroadcast", function(require)
    ---@return boolean
    function Trig_ChatGroupMutantBroadcast_Conditions()
        if (not (SubStringBJ(GetEventPlayerChatString(), 1, 1) == "[")) then
            return false
        end
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) ~= true)) then
            return false
        end
        return true
    end

    function Trig_ChatGroupMutantBroadcast_Actions()
        local i = 0 ---@type integer

        --   call ExecuteFunc( "ClearArguments" )
        --  call ExecuteFunc( "ParseEnteredString" )
        if not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetTriggerPlayer())] or GetTriggerPlayer() == udg_Mutant) or Player_IsDead(GetTriggerPlayer()) then
            return
        end
        udg_arguments[2] = SubStringBJ(GetEventPlayerChatString(), 2, 99)
        while i <= 11 do
            if (udg_Player_IsMutantSpawn[i + 1] or Player(i) == udg_Mutant) then
                DisplayTextToPlayer(Player(i), 0, 0,
                    "|cff800080" .. "[" .. "Mutant" .. "]|r" .. PlayerColours[GetTriggerPlayer()] ..
                    GetPlayerName(GetTriggerPlayer()) .. "|r: " .. udg_arguments[2])
            end
            i = i + 1
        end
    end

    --===========================================================================
    local i                         = 0 ---@type integer
    gg_trg_ChatGroupMutantBroadcast = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupMutantBroadcast, Player(i), "[", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_ChatGroupMutantBroadcast, Condition(Trig_ChatGroupMutantBroadcast_Conditions))
    TriggerAddAction(gg_trg_ChatGroupMutantBroadcast, Trig_ChatGroupMutantBroadcast_Actions)
end)
if Debug then Debug.endFile() end
