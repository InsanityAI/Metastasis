if Debug then Debug.beginFile "Game/RandomEvents/CommunicationError" end
OnInit.map("CommunicationError", function(require)
    ---@return boolean
    function Trig_CommunicationError_Func005Func001Func003001002001()
        return (GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER)
    end

    ---@return boolean
    function Trig_CommunicationError_Func005Func001C()
        if (not (IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), GetPlayersMatching(Condition(Trig_CommunicationError_Func005Func001Func003001002001))) == true)) then
            return false
        end
        return true
    end

    function Trig_CommunicationError_Func006A()
        SetPlayerName(GetEnumPlayer(),
            ("  " + (((("                                                                                                                                                                                                                                                " + "                                                                                                                                                                                                                                                ") + "                                                                                                                                                                                                                                                ") + "                                                                                                                                                                                                                                                ") + "                                                                                                                                                                                                                                                ")))
    end

    ---@return boolean
    function Trig_CommunicationError_Func009Func001Func001001002001()
        return (GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER)
    end

    ---@return boolean
    function Trig_CommunicationError_Func009Func001Func002Func002C()
        if (not (udg_ColorArray[udg_TempInt] == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_CommunicationError_Func009Func001C()
        if (not (IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), GetPlayersMatching(Condition(Trig_CommunicationError_Func009Func001Func001001002001))) == true)) then
            return false
        end
        return true
    end

    function Trig_CommunicationError_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[18] = true
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(240.00, 600.00))
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4179")
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_CommunicationError_Func005Func001C()) then
                udg_NamesTemp[GetForLoopIndexA()] = GetPlayerName(ConvertedPlayer(GetForLoopIndexA()))
                udg_ColorArray[GetForLoopIndexA()] = true
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        ForForce(udg_AllPlayers, Trig_CommunicationError_Func006A)
        TriggerSleepAction(60.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4181")
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_CommunicationError_Func009Func001C()) then
                bj_forLoopBIndex = 1
                bj_forLoopBIndexEnd = 1000
                while bj_forLoopBIndex <= bj_forLoopBIndexEnd do
                    udg_TempInt = GetRandomInt(1, 12)
                    if (Trig_CommunicationError_Func009Func001Func002Func002C()) then
                        bj_forLoopBIndex = 10000
                    else
                    end
                    bj_forLoopBIndex = bj_forLoopBIndex + 1
                end
                SetPlayerName(ConvertedPlayer(GetForLoopIndexA()), udg_NamesTemp[udg_TempInt])
                SetPlayerColorBJ(ConvertedPlayer(GetForLoopIndexA()), GetPlayerColor(ConvertedPlayer(udg_TempInt)), true)
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    --===========================================================================
    gg_trg_CommunicationError = CreateTrigger()
    DisableTrigger(gg_trg_CommunicationError)
    TriggerAddAction(gg_trg_CommunicationError, Trig_CommunicationError_Actions)
end)
if Debug then Debug.endFile() end
