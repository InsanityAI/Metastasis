if Debug then Debug.beginFile "Game/Abilities/Alien/BackFromHellDialog" end
OnInit.trig("BackFromHellDialog", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_BackFromHellDialog_Func002C()
        if (not (udg_BackFromHellDialogButtons[0] == GetClickedButtonBJ())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_BackFromHellDialog_Func005C()
        if (not (udg_EldritchBeastExists == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_BackFromHellDialog_Func006Func001C()
        if (not (udg_BackFromHellDialogButtons[GetForLoopIndexA()] == GetClickedButtonBJ())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_BackFromHellDialog_Func009Func007C()
        if (not (udg_Mutant == udg_TempPlayer)) then
            return false
        end
        return true
    end

    function Trig_BackFromHellDialog_Func009Func016A()
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED)
        SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED)
    end

    function Trig_BackFromHellDialog_Func009Func019A()
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_UNALLIED)
        SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
    end

    ---@return boolean
    function Trig_BackFromHellDialog_Func009C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    function Trig_BackFromHellDialog_Actions()
        if (Trig_BackFromHellDialog_Func002C()) then
            DialogDisplayBJ(true, udg_BackFromHellDialog, GetTriggerPlayer())
            return
        else
        end
        udg_TempBool = false
        -- TempBool determines if eldritch beast spawn or player
        if (Trig_BackFromHellDialog_Func005C()) then
            udg_TempInt = 1
        else
            udg_TempInt = 2
        end
        bj_forLoopAIndex = udg_TempInt
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_BackFromHellDialog_Func006Func001C()) then
                udg_TempPlayer = udg_BackFromHellDialog_Player[GetForLoopIndexA()]
                udg_TempBool = true
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        udg_TempPoint2 = GetUnitLoc(udg_AlienForm_Alien)
        udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 25.00, GetUnitFacing(udg_AlienForm_Alien))
        if (Trig_BackFromHellDialog_Func009C()) then
            if GetLocalPlayer() == udg_TempPlayer then
                MultiboardDisplay(ChatBoard, false)
            end
            CreateNUnitsAtLoc(1, FourCC('n00E'), udg_TempPlayer, udg_TempPoint, bj_UNIT_FACING)
            udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_TempPlayer)] = true
            udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_TempPlayer)] = false
            if (Trig_BackFromHellDialog_Func009Func007C()) then
                udg_Mutant = nil
            end
            StateTable.SetPlayerRole(udg_TempPlayer, Role.AlienSpawn)
            StateTable.SetPlayerState(udg_TempPlayer, State.Alive)
            DisplayTextToPlayer(GetOwningPlayer(GetDyingUnit()), 0, 0,
                "|cffFF0000You have been turned into the alien's spawn! Work with the alien to ensure victory.|r")
            SetUnitLifeBJ(GetLastCreatedUnit(), 1.00)
            udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit()
            SetPlayerName(udg_TempPlayer, udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)])
            ShowInterfaceForceOn(GetForceOfPlayer(udg_TempPlayer), 0.25)
            PanCameraToTimedLocForPlayer(udg_TempPlayer, udg_TempPoint, 0)
            SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_TempPlayer)
            ForceRemovePlayerSimple(udg_TempPlayer, udg_DeadGroup)
            ForForce(GetPlayersAll(), Trig_BackFromHellDialog_Func009Func016A)
            SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPlayer, bj_ALLIANCE_ALLIED)
            SetPlayerAllianceStateBJ(udg_TempPlayer, Player(bj_PLAYER_NEUTRAL_EXTRA), bj_ALLIANCE_ALLIED)
            ForForce(udg_DeadGroup, Trig_BackFromHellDialog_Func009Func019A)
        else
            CreateNUnitsAtLoc(1, FourCC('h02Z'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING)
            udg_EldritchBeastExists = true
        end
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_BackFromHellDialog = CreateTrigger()
    TriggerRegisterDialogEventBJ(gg_trg_BackFromHellDialog, udg_BackFromHellDialog)
    TriggerAddAction(gg_trg_BackFromHellDialog, Trig_BackFromHellDialog_Actions)
end)
if Debug then Debug.endFile() end
