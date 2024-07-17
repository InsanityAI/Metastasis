if Debug then Debug.beginFile "Commands/Votekick" end
OnInit.trig("Votekick", function(require)
    require "Anonymity"
    ---@return boolean
    function Trig_Votekick_Conditions()
        return SubStringBJ(GetEventPlayerChatString(), 1, 10) == "-votekick "
    end

    ---@return boolean
    function Trig_Votekick_IsAlive()
        return IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), udg_DeadGroup) == false and
            GetPlayerSlotState(ConvertedPlayer(GetForLoopIndexA())) == PLAYER_SLOT_STATE_PLAYING
    end

    ---@return boolean
    function Trig_Votekick_IsAndroid()
        return ConvertedPlayer(udg_TempInt) == udg_HiddenAndroid
    end

    ---@return boolean
    function Trig_Votekick_ReachedThreshold()
        return udg_Player_DeadKickVotes[udg_TempInt] >= (udg_TempInt2 / 2)
    end

    ---@return boolean
    function Trig_Votekick_Func019Func002C()
        if (not (IsPlayerInForce(ConvertedPlayer(udg_TempInt), udg_DeadGroup) == true)) then
            return false
        end
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) == false)) then
            return false
        end
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_Player_VotedKickGroup[udg_TempInt]) == false)) then
            return false
        end
        return true
    end

    function Trig_Votekick_Actions()
        -- Standard argument parsing. Parses any entered string into a series of arguments seperated by spaces. -kill noob becausehesucks would set arguments[1] equal to -kill, arguments[2] to noob, etc.
        ExecuteFunc("ClearArguments")
        ExecuteFunc("ParseEnteredString")
        -- Nasty crashes can occur if you don't check if you have an integer before you use it.
        if udg_arguments[2] ~= nil and udg_arguments[2] ~= "" then
            udg_TempInt = GetConvertedPlayerId(Anonymity.shuffledPlayers[S2I(udg_arguments[2]) - 1])
            if (Trig_Votekick_Func019Func002C()) then
                udg_Player_DeadKickVotes[udg_TempInt] = (udg_Player_DeadKickVotes[udg_TempInt] + 1)
                udg_TempInt2 = 0
                ForceAddPlayerSimple(GetTriggerPlayer(), udg_Player_VotedKickGroup[udg_TempInt])
                bj_forLoopAIndex = 1
                bj_forLoopAIndexEnd = 12
                while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                    if (Trig_Votekick_IsAlive()) then
                        udg_TempInt2 = (udg_TempInt2 + 1)
                    else
                    end
                    bj_forLoopAIndex = bj_forLoopAIndex + 1
                end
                if (Trig_Votekick_ReachedThreshold()) then
                    if (Trig_Votekick_IsAndroid()) then
                        DisplayTextToForce(GetPlayersAll(),
                            ("Dialoguing offensive android..." .. (" " .. (udg_Player_OriginalName[udg_TempInt] .. "!"))))
                        ShowInterfaceForceOff(GetForceOfPlayer(udg_HiddenAndroid), 2.00)
                    else
                        DisplayTextToForce(GetPlayersAll(),
                            ("Dialoguing offensive player..." .. (" " .. (udg_Player_OriginalName[udg_TempInt] .. "!"))))
                        ShowInterfaceForceOff(GetForceOfPlayer(ConvertedPlayer(udg_TempInt)), 2.00)
                    end
                else
                    DisplayTextToForce(GetPlayersAll(),
                        (I2S(((udg_TempInt2 / 2) - udg_Player_DeadKickVotes[udg_TempInt])) .. (" votes left to kick " .. (udg_Player_OriginalName[udg_TempInt] .. "!"))))
                end
            else
            end
        else
        end
    end

    --===========================================================================
    gg_trg_Votekick = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(0), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(1), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(2), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(3), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(4), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(5), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(6), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(7), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(8), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(9), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(10), "-votekick ", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Votekick, Player(11), "-votekick ", false)
    TriggerAddCondition(gg_trg_Votekick, Condition(Trig_Votekick_Conditions))
    TriggerAddAction(gg_trg_Votekick, Trig_Votekick_Actions)
end)
if Debug then Debug.endFile() end
