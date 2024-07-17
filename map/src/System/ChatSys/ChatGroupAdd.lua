if Debug then Debug.beginFile "System/ChatSys/ChatGroupAdd" end
OnInit.map("ChatGroupAdd", function(require)
    ---@return boolean
    function Trig_ChatGroupAdd_Conditions()
        return IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) ~= true and
            SubStringBJ(GetEventPlayerChatString(), 1, 4) == "-add"
    end

    ---@return boolean
    function Trig_ChatGroupAdd_IsOwner()
        return udg_TempInt > 0 and GetConvertedPlayerId(GetTriggerPlayer()) == udg_TempInt2
    end

    function Trig_ChatGroupAdd_Actions()
        local targettedPlayer ---@type player
        local i = 0 ---@type integer
        ClearArguments()
        ParseEnteredString()
        udg_TempInt2 = LoadInteger(LS(), GetHandleId(gg_trg_ChatGroupAdd), StringHash(udg_arguments[2]))
        udg_TempInt = S2I(udg_arguments[3])
        udg_TempPlayerGroup = LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_arguments[2]))
        udg_TempString = udg_arguments[2]
        if Trig_ChatGroupAdd_IsOwner() then
            if udg_TempInt == 1337 then
                DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30,
                    " |cff008000All players have been added to group |r|cff0080C0" + (udg_TempString + "|r."))
                while i <= 11 do
                    ForceAddPlayerSimple(Player(i), udg_TempPlayerGroup)
                    DisplayTimedTextToPlayer(Player(i), 0, 0, 30,
                        ("You" + (" |cff008000have been added to group |r|cff0080C0" + (udg_TempString + "|r."))))
                    i = i + 1
                end
            else
                targettedPlayer = Anonymity_ShuffledPlayersArray[udg_TempInt]
                ForceAddPlayer(udg_TempPlayerGroup, targettedPlayer)
                DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30,
                    (PlayerColor_GetPlayerTextColor(targettedPlayer) + GetPlayerName(targettedPlayer) + ("|r |cff008000has been added to group |r|cff0080C0" + (udg_TempString + "|r."))))
                DisplayTimedTextToPlayer(targettedPlayer, 0, 0, 30,
                    ("You" + (" |cff008000have been added to group |r|cff0080C0" + (udg_TempString + "|r."))))
            end
        end
    end

    --===========================================================================
    local i             = 0 ---@type integer
    gg_trg_ChatGroupAdd = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupAdd, Player(i), "-add", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_ChatGroupAdd, Condition(Trig_ChatGroupAdd_Conditions))
    TriggerAddAction(gg_trg_ChatGroupAdd, Trig_ChatGroupAdd_Actions)
end)
if Debug then Debug.endFile() end
