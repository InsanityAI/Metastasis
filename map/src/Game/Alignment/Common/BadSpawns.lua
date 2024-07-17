if Debug then Debug.beginFile "Game/Allignment/Common/BadSpawns" end
OnInit.trig("BadSpawns", function(require)
    ---@return boolean
    function Trig_BadSpawns_Conditions()
        return SubStringBJ(GetEventPlayerChatString(), 1, 10) == "-liquidate" or
            SubStringBJ(GetEventPlayerChatString(), 1, 2) == "-l"
    end

    ---@param spawnPlayer player
    ---@return boolean
    function Trig_BadSpawns_IsAlien(spawnPlayer)
        return udg_Parasite == GetTriggerPlayer() and
            udg_Player_IsParasiteSpawn[GetConvertedPlayerId(spawnPlayer)] == true
    end

    ---@param spawnPlayer player
    ---@return boolean
    function Trig_BadSpawns_IsMutant(spawnPlayer)
        return udg_Mutant == GetTriggerPlayer() and udg_Player_IsMutantSpawn[GetConvertedPlayerId(spawnPlayer)] == true
    end

    function Trig_BadSpawns_Actions()
        local targettedPlayer ---@type player
        ExecuteFunc("ClearArguments")
        ExecuteFunc("ParseEnteredString")
        if udg_arguments[2] == nil or udg_arguments[2] == "" then
            return
        end
        udg_TempInt = S2I(udg_arguments[2])
        if udg_TempInt ~= 0 then
            targettedPlayer = Anonymity.shuffledPlayers.orderedKeys[udg_TempInt - 1]
            if Trig_BadSpawns_IsAlien(targettedPlayer) then
                DialogClearBJ(udg_Liquidate_AreYouSure2)
                DialogSetMessageBJ(udg_Liquidate_AreYouSure2,
                    ("Are you sure you wish to liquidate " .. (PlayerColours[targettedPlayer] .. (GetPlayerName(targettedPlayer) .. "|r?"))))
                DialogAddButtonBJ(udg_Liquidate_AreYouSure2, "TRIGSTR_2556")
                udg_Liquidate_AreYouSureButton2[1] = GetLastCreatedButtonBJ()
                DialogAddButtonBJ(udg_Liquidate_AreYouSure2, "TRIGSTR_2557")
                udg_Liquidate_AreYouSureButton2[2] = GetLastCreatedButtonBJ()
                udg_Liquidate_ToLiquidate2 = udg_TempInt
                DialogDisplayBJ(true, udg_Liquidate_AreYouSure2, udg_Parasite)
            end
            if Trig_BadSpawns_IsMutant(targettedPlayer) then
                DialogClearBJ(udg_Liquidate_AreYouSure)
                DialogSetMessageBJ(udg_Liquidate_AreYouSure,
                    ("Are you sure you wish to liquidate " .. (PlayerColours[targettedPlayer] .. (GetPlayerName(targettedPlayer) .. "|r?"))))
                DialogAddButtonBJ(udg_Liquidate_AreYouSure, "TRIGSTR_2556")
                udg_Liquidate_AreYouSureButton[1] = GetLastCreatedButtonBJ()
                DialogAddButtonBJ(udg_Liquidate_AreYouSure, "TRIGSTR_2557")
                udg_Liquidate_AreYouSureButton[2] = GetLastCreatedButtonBJ()
                udg_Liquidate_ToLiquidate = udg_TempInt
                DialogDisplayBJ(true, udg_Liquidate_AreYouSure, udg_Mutant)
            end
        end
    end

    --===========================================================================
    local i          = 0 ---@type integer
    gg_trg_BadSpawns = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_BadSpawns, Player(i), "-liquidate ", false)
        TriggerRegisterPlayerChatEvent(gg_trg_BadSpawns, Player(i), "-l ", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_BadSpawns, Condition(Trig_BadSpawns_Conditions))
    TriggerAddAction(gg_trg_BadSpawns, Trig_BadSpawns_Actions)
end)
if Debug then Debug.endFile() end
