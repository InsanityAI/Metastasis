if Debug then Debug.beginFile "System/ChatSys/ChatGroupRemove" end
OnInit.trig("ChatGroupRemove", function(require)
    ---@return boolean
    function Trig_ChatGroupRemove_Conditions()
        return IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) ~= true and
            SubStringBJ(GetEventPlayerChatString(), 1, 7) == "-remove"
    end

    ---@return boolean
    function Trig_ChatGroupRemove_IsOwner()
        return udg_TempInt > 0 and GetConvertedPlayerId(GetTriggerPlayer()) == udg_TempInt2
    end

    function Trig_ChatGroupRemove_Actions()
        local targettedPlayer ---@type player
        local i = 0 ---@type integer
        ClearArguments()
        ParseEnteredString()
        udg_TempInt2 = LoadInteger(LS(), GetHandleId(gg_trg_ChatGroupAdd), StringHash(udg_arguments[2]))
        udg_TempInt = S2I(udg_arguments[3])
        udg_TempPlayerGroup = LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_arguments[2]))
        udg_TempString = udg_arguments[2]
        if Trig_ChatGroupRemove_IsOwner() then
            if udg_TempInt == 1337 then
                DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30,
                    " |cff008000All players have been removed from group |r|cff0080C0" .. (udg_TempString .. "|r."))
                while i <= 11 do
                    ForceRemovePlayerSimple(Player(i), udg_TempPlayerGroup)
                    DisplayTimedTextToPlayer(Player(i), 0, 0, 30,
                        ("You" .. (" |cff008000have been removed from group |r|cff0080C0" .. (udg_TempString .. "|r."))))
                    i = i + 1
                end
            else
                targettedPlayer = Anonymity.shuffledPlayers.orderedKeys[udg_TempInt]
                ForceRemovePlayerSimple(targettedPlayer, udg_TempPlayerGroup)
                DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30,
                    (PlayerColours[targettedPlayer] .. GetPlayerName(targettedPlayer) .. ("|r |cff008000has been removed from group |r|cff0080C0" .. (udg_TempString .. "|r."))))
                DisplayTimedTextToPlayer(targettedPlayer, 0, 0, 30,
                    ("You" .. (" |cff008000have been removed from group |r|cff0080C0" .. (udg_TempString .. "|r."))))
            end
        end
    end

    --===========================================================================
    local i                = 0 ---@type integer
    gg_trg_ChatGroupRemove = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupRemove, Player(i), "-remove", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_ChatGroupRemove, Condition(Trig_ChatGroupRemove_Conditions))
    TriggerAddAction(gg_trg_ChatGroupRemove, Trig_ChatGroupRemove_Actions)
end)
if Debug then Debug.endFile() end
