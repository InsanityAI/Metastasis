if Debug then Debug.beginFile "Game/Misc/WinCheck" end
OnInit.trig("WinCheck", function(require)
    ---@return boolean
    function Trig_WinCheck_Func001C()
        if (not (udg_WC_Disable == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WinCheck_Func003Func003Func001C()
        if (not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(ConvertedPlayer(GetForLoopIndexA()))] == true)) then
            return false
        end
        if (not (IsUnitAliveBJ(udg_Playerhero[GetForLoopIndexA()]) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WinCheck_Func003Func004Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(ConvertedPlayer(GetForLoopIndexA()))] == true)) then
            return false
        end
        if (not (IsUnitAliveBJ(udg_Playerhero[GetForLoopIndexA()]) == true)) then
            return false
        end
        return true
    end

    function Trig_WinCheck_Func003Func005Func010A()
        SetUnitAnimation(GetEnumUnit(), "victory")
    end

    function Trig_WinCheck_Func003Func005Func011A()
        SetPlayerName(GetEnumPlayer(), udg_OriginalName[GetConvertedPlayerId(GetEnumPlayer())])
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            SetPlayerAllianceStateBJ(ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    ---@return boolean
    function Trig_WinCheck_Func003Func005C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WinCheck_Func003Func006C()
        if ((IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true)) then
            return true
        end
        if ((udg_Allow_Mutant == false)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_WinCheck_Func003Func007C()
        if ((IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == true)) then
            return true
        end
        if ((udg_Allow_Parasite == false)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_WinCheck_Func003C()
        if (not (udg_GameEnd == false)) then
            return false
        end
        if (not Trig_WinCheck_Func003Func006C()) then
            return false
        end
        if (not Trig_WinCheck_Func003Func007C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WinCheck_Func004Func003Func001C()
        if (not (IsUnitAliveBJ(udg_Playerhero[GetForLoopIndexA()]) == true)) then
            return false
        end
        if (not (IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), udg_DeadGroup) == false)) then
            return false
        end
        if (not (ConvertedPlayer(GetForLoopIndexA()) ~= udg_Mutant)) then
            return false
        end
        if (not (udg_Player_IsMutantSpawn[GetForLoopIndexA()] == false)) then
            return false
        end
        return true
    end

    function Trig_WinCheck_Func004Func004Func010A()
        SetPlayerName(GetEnumPlayer(), udg_OriginalName[GetConvertedPlayerId(GetEnumPlayer())])
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            SetPlayerAllianceStateBJ(ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    function Trig_WinCheck_Func004Func004Func012A()
        SetUnitAnimation(GetEnumUnit(), "victory")
    end

    ---@return boolean
    function Trig_WinCheck_Func004Func004C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WinCheck_Func004Func005C()
        if ((IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == true)) then
            return true
        end
        if ((udg_Allow_Parasite == false)) then
            return true
        end
        if ((GetPlayerSlotState(udg_Parasite) ~= PLAYER_SLOT_STATE_PLAYING)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_WinCheck_Func004C()
        if (not (udg_GameEnd == false)) then
            return false
        end
        if (not Trig_WinCheck_Func004Func005C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WinCheck_Func005Func003Func001C()
        if (not (IsUnitAliveBJ(udg_Playerhero[GetForLoopIndexA()]) == true)) then
            return false
        end
        if (not (IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), udg_DeadGroup) == false)) then
            return false
        end
        if (not (ConvertedPlayer(GetForLoopIndexA()) ~= udg_Parasite)) then
            return false
        end
        if (not (udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == false)) then
            return false
        end
        return true
    end

    function Trig_WinCheck_Func005Func004Func010A()
        SetPlayerName(GetEnumPlayer(), udg_OriginalName[GetConvertedPlayerId(GetEnumPlayer())])
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            SetPlayerAllianceStateBJ(ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    function Trig_WinCheck_Func005Func004Func012A()
        SetUnitAnimation(GetEnumUnit(), "victory")
    end

    ---@return boolean
    function Trig_WinCheck_Func005Func004C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WinCheck_Func005Func005C()
        if ((IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true)) then
            return true
        end
        if ((udg_Allow_Mutant == false)) then
            return true
        end
        if ((GetPlayerSlotState(udg_Mutant) ~= PLAYER_SLOT_STATE_PLAYING)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_WinCheck_Func005C()
        if (not (udg_GameEnd == false)) then
            return false
        end
        if (not Trig_WinCheck_Func005Func005C()) then
            return false
        end
        return true
    end

    function Trig_WinCheck_Actions()
        if (Trig_WinCheck_Func001C()) then
            return
        else
        end
        PolledWait(0.25)
        if (Trig_WinCheck_Func003C()) then
            udg_TempBool = true
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 12
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                if (Trig_WinCheck_Func003Func003Func001C()) then
                    udg_TempBool = false
                else
                end
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 12
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                if (Trig_WinCheck_Func003Func004Func001C()) then
                    udg_TempBool = false
                else
                end
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
            if (Trig_WinCheck_Func003Func005C()) then
                udg_GameEnd = true
                DestroyTrigger(gg_trg_PlayerDeathText)
                DestroyTrigger(gg_trg_WinCheck)
                DestroyTrigger(gg_trg_PlayerMurder)
                DestroyTrigger(GetTriggeringTrigger())
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1068")
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1624")
                PlaySoundBJ(gg_snd_HumanVictory)
                PolledWait(2.00)
                ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_WinCheck_Func003Func005Func010A)
                ForForce(GetPlayersAll(), Trig_WinCheck_Func003Func005Func011A)
                FogEnableOff()
                PolledWait(10.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1070")
                PolledWait(15.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1071")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1072")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1073")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1074")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1075")
                PolledWait(1.00)
                EndGame(true)
            else
            end
        else
        end
        if (Trig_WinCheck_Func004C()) then
            udg_TempBool = true
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 12
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                if (Trig_WinCheck_Func004Func003Func001C()) then
                    udg_TempBool = false
                else
                end
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
            if (Trig_WinCheck_Func004Func004C()) then
                udg_GameEnd = true
                DestroyTrigger(gg_trg_PlayerDeathText)
                DestroyTrigger(gg_trg_WinCheck)
                DestroyTrigger(GetTriggeringTrigger())
                DestroyTrigger(gg_trg_PlayerMurder)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1076")
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1623")
                PlaySoundBJ(gg_snd_DarkVictory)
                PolledWait(2)
                ForForce(GetPlayersAll(), Trig_WinCheck_Func004Func004Func010A)
                FogEnableOff()
                ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_WinCheck_Func004Func004Func012A)
                PolledWait(10.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1622")
                PolledWait(15.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1079")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1080")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1081")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1082")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1083")
                PolledWait(1.00)
                EndGame(true)
            else
            end
        else
        end
        if (Trig_WinCheck_Func005C()) then
            udg_TempBool = true
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 12
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                if (Trig_WinCheck_Func005Func003Func001C()) then
                    udg_TempBool = false
                else
                end
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
            if (Trig_WinCheck_Func005Func004C()) then
                udg_GameEnd = true
                DestroyTrigger(gg_trg_PlayerDeathText)
                DestroyTrigger(gg_trg_WinCheck)
                DestroyTrigger(gg_trg_PlayerMurder)
                DestroyTrigger(GetTriggeringTrigger())
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1084")
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1085")
                PlaySoundBJ(gg_snd_SadMystery)
                PolledWait(2)
                ForForce(GetPlayersAll(), Trig_WinCheck_Func005Func004Func010A)
                FogEnableOff()
                ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_WinCheck_Func005Func004Func012A)
                PolledWait(10.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1621")
                PolledWait(15.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1087")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1088")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1089")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1090")
                PolledWait(1.00)
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1091")
                PolledWait(1.00)
                EndGame(true)
            else
            end
        else
        end
    end

    --===========================================================================
    gg_trg_WinCheck = CreateTrigger()
    DisableTrigger(gg_trg_WinCheck)
    TriggerAddAction(gg_trg_WinCheck, Trig_WinCheck_Actions)
end)
if Debug then Debug.endFile() end
