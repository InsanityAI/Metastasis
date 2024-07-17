if Debug then Debug.beginFile "Game/Allignment/Alien/ParasiteUpgradeFinish" end
OnInit.map("ParasiteUpgradeFinish", function(require)
    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func002C()
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func003C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h02V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func004C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h03P'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func005C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h02Y'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func006Func003Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func006C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h031'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func007Func004Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func007C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h037'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func008C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h03E'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func009C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h03A'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func010C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h035'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func011Func027Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == true)) then
            return false
        end
        if (not (IsUnitType(udg_Playerhero[GetForLoopIndexA()], UNIT_TYPE_MECHANICAL) == true)) then
            return false
        end
        if (not (udg_HiddenAndroid ~= ConvertedPlayer(GetForLoopIndexA()))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func011C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h033'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func012C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h03C'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func013C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h03G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func014C()
        if (not (udg_ParasiteUpgradingTo == FourCC('h03V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func036C()
        if (not (udg_Masq_evolved ~= true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgradeFinish_Func037Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == true)) then
            return false
        end
        if (not (IsUnitType(udg_Playerhero[GetForLoopIndexA()], UNIT_TYPE_MECHANICAL) == true)) then
            return false
        end
        if (not (udg_HiddenAndroid ~= ConvertedPlayer(GetForLoopIndexA()))) then
            return false
        end
        return true
    end

    function Trig_ParasiteUpgradeFinish_Actions()
        local a ---@type unit
        if (Trig_ParasiteUpgradeFinish_Func002C()) then
        else
            return
        end
        if (Trig_ParasiteUpgradeFinish_Func003C()) then
            udg_ParasiteChildInfectee = FourCC('h02W')
            CreateNUnitsAtLoc(1, FourCC('e00T'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func004C()) then
            udg_ParasiteChildInfectee = FourCC('h03R')
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func005C()) then
            EnableTrigger(gg_trg_ClosedTimeLikeLoopSavePos)
            CreateNUnitsAtLoc(1, FourCC('e00J'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
            udg_ParasiteChildInfectee = FourCC('h030')
            ExecuteFunc("CreateCTLRequirement")
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func006C()) then
            CreateNUnitsAtLoc(1, FourCC('e00M'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
            udg_ParasiteChildInfectee = FourCC('h032')
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 12
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                if (Trig_ParasiteUpgradeFinish_Func006Func003Func001C()) then
                    CreateNUnitsAtLoc(1, FourCC('e00M'), ConvertedPlayer(GetForLoopIndexA()), udg_HoldZone,
                        bj_UNIT_FACING)
                else
                end
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func007C()) then
            CreateNUnitsAtLoc(1, FourCC('e00O'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
            CreateNUnitsAtLoc(1, FourCC('e00P'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
            udg_ParasiteChildInfectee = FourCC('h039')
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 12
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                if (Trig_ParasiteUpgradeFinish_Func007Func004Func001C()) then
                    CreateNUnitsAtLoc(1, FourCC('e00M'), ConvertedPlayer(GetForLoopIndexA()), udg_HoldZone,
                        bj_UNIT_FACING)
                else
                end
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func008C()) then
            EnableTrigger(gg_trg_NeurotoxicPoison)
            udg_ParasiteChildInfectee = FourCC('h03F')
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func009C()) then
            udg_ParasiteChildInfectee = FourCC('h03B')
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func010C()) then
            udg_ParasiteChildInfectee = FourCC('h036')
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func011C()) then
            udg_Masq_evolved = true
            udg_ParasiteChildInfectee = FourCC('h034')
            CreateNUnitsAtLoc(1, FourCC('e015'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
            -- -----------------------------
            -- -----------------------------
            udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
            a = udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]
            udg_AlienCurrentForm = udg_ParasiteUpgradingTo
            udg_AlienForm_Alien = nil
            CreateNUnitsAtLoc(1, udg_ParasiteUpgradingTo, Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING)
            SetUnitX(GetLastCreatedUnit(), GetLocationX(udg_TempPoint))
            SetUnitY(GetLastCreatedUnit(), GetLocationY(udg_TempPoint))
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 6
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                UnitAddItemSwapped(
                    UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], GetForLoopIndexA()),
                    GetLastCreatedUnit())
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
            udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = nil
            udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = nil
            udg_TempUnit = a
            KillUnit(udg_TempUnit)
            RemoveLocation(udg_TempPoint)
            udg_ParasiteIsUpgrading = false
            udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
            udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
            udg_AlienForm_Alien = GetLastCreatedUnit()
            SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Parasite)
            CreateNUnitsAtLoc(1, FourCC('e00L'), udg_Parasite, udg_HoldZone, bj_UNIT_FACING)
            udg_Alien_ShopWorkaround = GetLastCreatedUnit()
            EnableTrigger(gg_trg_AlienAdjustShop)
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 12
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                if (Trig_ParasiteUpgradeFinish_Func011Func027Func001C()) then
                    udg_TempUnitType = udg_ParasiteChildInfectee
                    udg_TempUnit = udg_Playerhero[GetForLoopIndexA()]
                    udg_TempPlayer = ConvertedPlayer(GetForLoopIndexA())
                    ExecuteFunc("PendUpgrade")
                    TriggerExecute(gg_trg_ParasiteSpawnCreateSpell)
                else
                end
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
            -- Trigger - Turn off Infinite Alien bugfix <gen> BUT WHY TE FUCK ITS HERE!>?
            return
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func012C()) then
            udg_ParasiteChildInfectee = FourCC('h03D')
            CreateNUnitsAtLoc(1, FourCC('e00S'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func013C()) then
            udg_ParasiteChildInfectee = FourCC('h03H')
            CreateNUnitsAtLoc(1, FourCC('e00V'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
        else
        end
        if (Trig_ParasiteUpgradeFinish_Func014C()) then
            udg_ParasiteChildInfectee = FourCC('h03W')
        else
        end
        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        a = udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]
        udg_AlienCurrentForm = udg_ParasiteUpgradingTo
        udg_AlienForm_Alien = nil
        CreateNUnitsAtLoc(1, udg_ParasiteUpgradingTo, Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING)
        SetUnitX(GetLastCreatedUnit(), GetLocationX(udg_TempPoint))
        SetUnitY(GetLastCreatedUnit(), GetLocationY(udg_TempPoint))
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            UnitAddItemSwapped(UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], GetForLoopIndexA()),
                GetLastCreatedUnit())
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = nil
        udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = nil
        udg_TempUnit = a
        KillUnit(udg_TempUnit)
        RemoveLocation(udg_TempPoint)
        udg_ParasiteIsUpgrading = false
        udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
        udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
        udg_AlienForm_Alien = GetLastCreatedUnit()
        SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Parasite)
        CreateNUnitsAtLoc(1, FourCC('e00L'), udg_Parasite, udg_HoldZone, bj_UNIT_FACING)
        udg_Alien_ShopWorkaround = GetLastCreatedUnit()
        EnableTrigger(gg_trg_AlienAdjustShop)
        if (Trig_ParasiteUpgradeFinish_Func036C()) then
            PlaySoundBJ(gg_snd_DragonYesAttack3)
            CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 2, "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp",
                0.00, 100.00, 100.00, 0)
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4587")
        else
        end
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_ParasiteUpgradeFinish_Func037Func001C()) then
                udg_TempUnitType = udg_ParasiteChildInfectee
                udg_TempUnit = udg_Playerhero[GetForLoopIndexA()]
                udg_TempPlayer = ConvertedPlayer(GetForLoopIndexA())
                ExecuteFunc("PendUpgrade")
                TriggerExecute(gg_trg_ParasiteSpawnCreateSpell)
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        -- Trigger - Turn off Infinite Alien bugfix <gen>
    end

    --===========================================================================
    gg_trg_ParasiteUpgradeFinish = CreateTrigger()
    TriggerAddAction(gg_trg_ParasiteUpgradeFinish, Trig_ParasiteUpgradeFinish_Actions)
end)
if Debug then Debug.endFile() end
