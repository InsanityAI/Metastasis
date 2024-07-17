if Debug then Debug.beginFile "Game/Allignment/Mutant/MutantUpgradeFinish" end
OnInit.trig("MutantUpgradeFinish", function(require)
    ---@return boolean
    function Trig_MutantUpgradeFinish_Func001C()
        if (not (IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func002C()
        if (not (udg_MutantUpgradingTo == FourCC('h00U'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func003C()
        if (not (udg_MutantUpgradingTo == FourCC('h00V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func004C()
        if (not (udg_MutantUpgradingTo == FourCC('h01I'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func005C()
        if (not (udg_MutantUpgradingTo == FourCC('h01L'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func006C()
        if (not (udg_MutantUpgradingTo == FourCC('h01K'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func007C()
        if (not (udg_MutantUpgradingTo == FourCC('h01O'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func008C()
        if (not (udg_MutantUpgradingTo == FourCC('h01V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func009C()
        if (not (udg_MutantUpgradingTo == FourCC('h04G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func010C()
        if (not (udg_MutantUpgradingTo == FourCC('h04W'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func016Func003C()
        if (not (udg_TempBool == true)) then
            return false
        end
        if (not (RectContainsUnit(gg_rct_Timeout, udg_TempUnit2) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func016Func006C()
        if (not (RectContainsLoc(gg_rct_Space, udg_TempPoint2) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func016Func008C()
        if (not (RectContainsLoc(gg_rct_Space, udg_TempPoint) == false)) then
            return false
        end
        return true
    end

    function Trig_MutantUpgradeFinish_Func016Func024A()
        SetUnitOwner(GetEnumUnit(), udg_Mutant, true)
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func016C()
        if (not (udg_MutantUpgradingTo == FourCC('h04G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func023C()
        if (not (udg_MutantUpgradingTo == FourCC('h04W'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func027Func001C()
        if (not (udg_Player_IsMutantSpawn[GetForLoopIndexA()] == true)) then
            return false
        end
        if (not (udg_HiddenAndroid ~= ConvertedPlayer(GetForLoopIndexA()))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func028C()
        if (not (udg_MutantUpgradingTo == FourCC('h01G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func029C()
        if (not (udg_MutantUpgradingTo == FourCC('h01V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func030C()
        if (not (udg_MutantUpgradingTo == FourCC('h01C'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func031C()
        if (not (udg_MutantUpgradingTo == FourCC('h01L'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgradeFinish_Func032C()
        if (not (udg_MutantUpgradingTo == FourCC('h01B'))) then
            return false
        end
        return true
    end

    function Trig_MutantUpgradeFinish_Actions()
        if (Trig_MutantUpgradeFinish_Func001C()) then
            return
        else
        end
        if (Trig_MutantUpgradeFinish_Func002C()) then
            udg_Mutant_IsPerfection = true
        else
        end
        if (Trig_MutantUpgradeFinish_Func003C()) then
            udg_MutantChildInfectee = FourCC('h00W')
        else
        end
        if (Trig_MutantUpgradeFinish_Func004C()) then
            udg_MutantChildInfectee = FourCC('h01J')
        else
        end
        if (Trig_MutantUpgradeFinish_Func005C()) then
            udg_MutantChildInfectee = FourCC('h01M')
        else
        end
        if (Trig_MutantUpgradeFinish_Func006C()) then
            udg_MutantChildInfectee = FourCC('h01N')
        else
        end
        if (Trig_MutantUpgradeFinish_Func007C()) then
            udg_MutantChildInfectee = FourCC('h01R')
        else
        end
        if (Trig_MutantUpgradeFinish_Func008C()) then
            udg_MutantChildInfectee = FourCC('h01X')
        else
        end
        if (Trig_MutantUpgradeFinish_Func009C()) then
            udg_MutantChildInfectee = FourCC('h01T')
        else
        end
        if (Trig_MutantUpgradeFinish_Func010C()) then
            udg_MutantChildInfectee = FourCC('h01Y')
            SetPlayerTechMaxAllowedSwap(FourCC('h01T'), 1, udg_Mutant)
            SetPlayerTechMaxAllowedSwap(FourCC('h01U'), 10, udg_Mutant)
            udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
            CreateNUnitsAtLoc(1, FourCC('h01T'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
            SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant)
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 6
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                UnitAddItemSwapped(
                    UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], GetForLoopIndexA()),
                    GetLastCreatedUnit())
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
        else
        end
        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
        CreateNUnitsAtLoc(1, udg_MutantUpgradingTo, udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
        udg_TempUnit = GetLastCreatedUnit()
        SetUnitX(GetLastCreatedUnit(), GetLocationX(udg_TempPoint))
        SetUnitY(GetLastCreatedUnit(), GetLocationY(udg_TempPoint))
        if (Trig_MutantUpgradeFinish_Func016C()) then
            udg_TempUnit2 = udg_Sector_Space[GetUnitSector(udg_TempUnit)]
            udg_TempBool = IsUnitExplorer(udg_TempUnit2)
            if (Trig_MutantUpgradeFinish_Func016Func003C()) then
                udg_TempPoint2 = GetUnitLoc(udg_Sector_Space[GetUnitSector(udg_SS_Landed[GetUnitAN(udg_TempUnit2)])])
            else
                udg_TempPoint2 = GetUnitLoc(udg_TempUnit2)
            end
            if (Trig_MutantUpgradeFinish_Func016Func006C()) then
                RemoveLocation(udg_TempPoint2)
                udg_TempPoint2 = GetRandomLocInRect(gg_rct_Space)
            else
            end
            udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 256, GetRandomDirectionDeg())
            if (Trig_MutantUpgradeFinish_Func016Func008C()) then
                RemoveLocation(udg_TempPoint)
                udg_TempPoint = udg_TempPoint2
            else
                RemoveLocation(udg_TempPoint2)
            end
            SetUnitX(GetLastCreatedUnit(), GetLocationX(udg_TempPoint))
            SetUnitY(GetLastCreatedUnit(), GetLocationY(udg_TempPoint))
            PanCameraToTimedLocForPlayer(udg_Mutant, udg_TempPoint, 0)
            RemoveLocation(udg_TempPoint)
            udg_TempPoint = GetRectCenter(gg_rct_OverlordRect)
            udg_Sector_Space[27] = udg_TempUnit
            GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup)
            NewUnitRegister(udg_TempUnit)
            udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 100.00
            TriggerExecute(gg_trg_ST11Init)
            SetPlayerTechMaxAllowedSwap(FourCC('h01T'), 1, udg_Mutant)
            SetPlayerTechMaxAllowedSwap(FourCC('h01U'), 10, udg_Mutant)
            udg_UpgradePointsMutant = 600.00
            SetPlayerStateBJ(udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER, 600)
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 6
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                SetItemPositionLoc(
                    UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], GetForLoopIndexA()), udg_TempPoint)
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
            ForGroupBJ(GetUnitsInRectAll(gg_rct_OverlordRect), Trig_MutantUpgradeFinish_Func016Func024A)
        else
            SetUnitLifePercentBJ(GetLastCreatedUnit(), udg_MutantUpgrade_Health)
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 6
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                UnitAddItemSwapped(
                    UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], GetForLoopIndexA()),
                    GetLastCreatedUnit())
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
        end
        SetUnitOwner(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], Player(PLAYER_NEUTRAL_PASSIVE), true)
        SizeUnitOverTime(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], 3, 1, 0.01, false)
        FadeUnitOverTime(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], 5, true)
        RemoveLocation(udg_TempPoint)
        udg_MutantIsUpgrading = false
        udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] = GetLastCreatedUnit()
        if (Trig_MutantUpgradeFinish_Func023C()) then
            -- Let the OG selection to select harbringer ;)
        else
            SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant)
        end
        PlaySoundBJ(gg_snd_FreakyForest4)
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 2, "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 100.00,
            100.00, 0, 0)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2935")
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_MutantUpgradeFinish_Func027Func001C()) then
                udg_TempUnitType = udg_MutantChildInfectee
                udg_TempUnit = udg_Playerhero[GetForLoopIndexA()]
                udg_TempPlayer = ConvertedPlayer(GetForLoopIndexA())
                ExecuteFunc("PendUpgrade")
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        if (Trig_MutantUpgradeFinish_Func028C()) then
            udg_TempUnit = GetLastCreatedUnit()
            ExecuteFunc("FleshGolemLoop")
        else
        end
        if (Trig_MutantUpgradeFinish_Func029C()) then
            udg_TempUnit = GetLastCreatedUnit()
            ExecuteFunc("DefilerGoo")
        else
        end
        if (Trig_MutantUpgradeFinish_Func030C()) then
            EnableTrigger(gg_trg_CrabMutant)
            CrabTeleport(GetLastCreatedUnit())
        else
        end
        if (Trig_MutantUpgradeFinish_Func031C()) then
            udg_Mutant_IsRapidGestation = true
        else
        end
        if (Trig_MutantUpgradeFinish_Func032C()) then
            SetUnitTimeScalePercent(GetLastReplacedUnitBJ(), 160.00)
        else
        end
        -- Trigger - Turn off Infinite Mutant bugfix <gen>
    end

    --===========================================================================
    gg_trg_MutantUpgradeFinish = CreateTrigger()
    TriggerAddAction(gg_trg_MutantUpgradeFinish, Trig_MutantUpgradeFinish_Actions)
end)
if Debug then Debug.endFile() end
