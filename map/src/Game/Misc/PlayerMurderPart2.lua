if Debug then Debug.beginFile "Game/Misc/PlayerMurderPart2" end
OnInit.map("PlayerMurderPart2", function(require)
    ---@return boolean
    function Trig_PlayerMurderPart2_Func001C()
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurderPart2_Func003Func007Func001C()
        if (not (IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false)) then
            return false
        end
        return true
    end

    function Trig_PlayerMurderPart2_Func003Func007A()
        if (Trig_PlayerMurderPart2_Func003Func007Func001C()) then
            SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED_VISION)
            SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED)
        else
        end
    end

    ---@return boolean
    function Trig_PlayerMurderPart2_Func003Func012C()
        if (not (udg_Player_TetrabinLevel[GetConvertedPlayerId(udg_TempPlayer)] >= 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurderPart2_Func003Func013C()
        if (not (udg_DeathType == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurderPart2_Func003Func014Func001C()
        if (not (IsUnitDeadBJ(GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_PlayerMurderPart2_Func003Func014A()
        if (Trig_PlayerMurderPart2_Func003Func014Func001C()) then
        else
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true)
        end
    end

    ---@return boolean
    function Trig_PlayerMurderPart2_Func003Func017Func001C()
        if (not (IsUnitDeadBJ(GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_PlayerMurderPart2_Func003Func017A()
        if (Trig_PlayerMurderPart2_Func003Func017Func001C()) then
        else
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true)
        end
    end

    ---@return boolean
    function Trig_PlayerMurderPart2_Func003Func023Func002C()
        if ((udg_Android_Preference == FourCC('h052'))) then
            return true
        end
        if hasRevivedAsPacificationBot == true then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_PlayerMurderPart2_Func003Func023C()
        if (not Trig_PlayerMurderPart2_Func003Func023Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurderPart2_Func003C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    function Trig_PlayerMurderPart2_Actions()
        if (Trig_PlayerMurderPart2_Func001C()) then
            return
        else
        end
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            RemoveItem(UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA()))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        if (Trig_PlayerMurderPart2_Func003C()) then
            DisplayTextToPlayer(udg_TempPlayer, 0, 0,
                "You have died. You will be allowed to watch only where your memory card is. As you are the android, you may yet be revived. If you do not wish to be revived or recognize this as impossible, you may type -shutdown to forfeit all revival priviledges.")
            ForGroupBJ(GetUnitsOfPlayerAll(udg_TempPlayer), Trig_PlayerMurderPart2_Func003Func017A)
            EnableTrigger(gg_trg_AndroidCardVision)
            EnableTrigger(gg_trg_AndroidChat)
            udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)] = GetPlayerName(udg_TempPlayer)
            SetPlayerName(udg_TempPlayer,
                (GetPlayerName(udg_TempPlayer) + (((("                                                                                                                                                                                                                                                " + "                                                                                                                                                                                                                                                ") + "                                                                                                                                                                                                                                                ") + "                                                                                                                                                                                                                                                ") + "                                                                                                                                                                                                                                                ")))
            ForceAddPlayerSimple(udg_TempPlayer, udg_DeadGroup)
            if (Trig_PlayerMurderPart2_Func003Func023C()) then
                RemoveItem(udg_Android_MemoryCard)
            else
            end
        else
            DisplayTextToPlayer(udg_TempPlayer, 0, 0,
                "You have died. You can stay and watch the game, or leave at any time.")
            if GetLocalPlayer() == udg_TempPlayer then
                MultiboardDisplay(ChatBoard, true)
            end
            udg_Player_Spectating[GetConvertedPlayerId(udg_TempPlayer)] = true
            ForForce(GetPlayersAll(), Trig_PlayerMurderPart2_Func003Func007A)
            SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPlayer, bj_ALLIANCE_ALLIED_VISION)
            ForceAddPlayerSimple(udg_TempPlayer, udg_DeadGroup)
            udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)] = GetPlayerName(udg_TempPlayer)
            SetPlayerName(udg_TempPlayer,
                (GetPlayerName(udg_TempPlayer) + (((("                                                                                                                                                                                                                                                " + "                                                                                                                                                                                                                                                ") + "                                                                                                                                                                                                                                                ") + "                                                                                                                                                                                                                                                ") + "                                                                                                                                                                                                                                                ")))
            if (Trig_PlayerMurderPart2_Func003Func012C()) then
                CameraClearNoiseForPlayer(udg_TempPlayer)
            else
            end
            if (Trig_PlayerMurderPart2_Func003Func013C()) then
                CustomDefeatBJ(udg_TempPlayer, "TRIGSTR_3582")
            else
            end
            ForGroupBJ(GetUnitsOfPlayerAll(udg_TempPlayer), Trig_PlayerMurderPart2_Func003Func014A)
        end
        TriggerExecute(gg_trg_WinCheck)
    end

    --===========================================================================
    gg_trg_PlayerMurderPart2 = CreateTrigger()
    TriggerAddAction(gg_trg_PlayerMurderPart2, Trig_PlayerMurderPart2_Actions)
end)
if Debug then Debug.endFile() end
