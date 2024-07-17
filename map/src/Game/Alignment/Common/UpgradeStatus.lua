if Debug then Debug.beginFile "Game/Allignment/Common/UpgradeStatus" end
OnInit.map("UpgradeStatus", function(require)
    ---@return boolean
    function Trig_UpgradeStatus_Func004Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetEnumPlayer())] == true)) then
            return false
        end
        if (not (IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false)) then
            return false
        end
        return true
    end

    function Trig_UpgradeStatus_Func004A()
        if (Trig_UpgradeStatus_Func004Func001C()) then
            udg_UpgradePointsAlien = (udg_UpgradePointsAlien + 0.28)
        else
        end
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func005Func001C()
        if (not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetEnumPlayer())] == true)) then
            return false
        end
        if (not (IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false)) then
            return false
        end
        return true
    end

    function Trig_UpgradeStatus_Func005A()
        if (Trig_UpgradeStatus_Func005Func001C()) then
            udg_UpgradePointsMutant = (udg_UpgradePointsMutant + 0.40)
        else
        end
    end

    function Trig_UpgradeStatus_Func006A()
        udg_UpgradePointsAlien = (udg_UpgradePointsAlien + 0.20)
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func007Func002C()
        if (not (udg_UpgradePointsAlien <= 1370.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func007C()
        if (not (udg_UpgradePointsAlien <= 660.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func008Func004Func001Func001C()
        if (not (udg_UpgradePointsMutant <= 1800.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func008Func004Func001C()
        if (not (udg_UpgradePointsMutant <= 900.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func008Func004C()
        if (not (udg_UpgradePointsMutant <= 300.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func008C()
        if (not (FourCC('h04G') ~= udg_MutantUpgradingTo)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func012C()
        if (not (GetPlayerState(udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER) >= 300)) then
            return false
        end
        if (not (udg_MutantUpgrades[1] == false)) then
            return false
        end
        if (not (IsPlayerInForce(udg_Mutant, udg_DeadGroup) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func013C()
        if (not (udg_MutantUpgrades[1] == true)) then
            return false
        end
        if (not (udg_MutantUpgrades[2] == false)) then
            return false
        end
        if (not (IsPlayerInForce(udg_Mutant, udg_DeadGroup) == false)) then
            return false
        end
        if (not (GetPlayerState(udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER) >= 900)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func014C()
        if (not (udg_MutantUpgrades[2] == true)) then
            return false
        end
        if (not (udg_MutantUpgrades[3] == false)) then
            return false
        end
        if (not (IsPlayerInForce(udg_Mutant, udg_DeadGroup) == false)) then
            return false
        end
        if (not (GetPlayerState(udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER) >= 1800)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func015C()
        if (not (GetPlayerState(udg_Parasite, PLAYER_STATE_RESOURCE_LUMBER) >= 660)) then
            return false
        end
        if (not (udg_ParasiteUpgrades[1] == false)) then
            return false
        end
        if (not (IsPlayerInForce(udg_Parasite, udg_DeadGroup) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func016C()
        if (not (GetPlayerState(udg_Parasite, PLAYER_STATE_RESOURCE_LUMBER) >= 1370)) then
            return false
        end
        if (not (udg_ParasiteUpgrades[2] == false)) then
            return false
        end
        if (not (IsPlayerInForce(udg_Parasite, udg_DeadGroup) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_UpgradeStatus_Func017C()
        if (not (GetPlayerState(udg_HiddenAndroid, PLAYER_STATE_RESOURCE_LUMBER) >= 2000)) then
            return false
        end
        if (not (udg_AndroidUpgrades[1] == false)) then
            return false
        end
        if (not (IsUnitAliveBJ(gg_unit_h003_0018) == true)) then
            return false
        end
        return true
    end

    function Trig_UpgradeStatus_Actions()
        udg_UpgradePointsAndroid = (udg_UpgradePointsAndroid + 1.50)
        udg_UpgradePointsAlien = (udg_UpgradePointsAlien + 0.40)
        ForForce(GetPlayersAll(), Trig_UpgradeStatus_Func004A)
        ForForce(GetPlayersAll(), Trig_UpgradeStatus_Func005A)
        ForGroupBJ(udg_Parasite_EggGroup, Trig_UpgradeStatus_Func006A)
        if (Trig_UpgradeStatus_Func007C()) then
            SetPlayerStateBJ(udg_Parasite, PLAYER_STATE_RESOURCE_FOOD_USED,
                R2I(((udg_UpgradePointsAlien - 0.00) / (660.00 / 100.00))))
        else
            if (Trig_UpgradeStatus_Func007Func002C()) then
                SetPlayerStateBJ(udg_Parasite, PLAYER_STATE_RESOURCE_FOOD_USED,
                    R2I(((udg_UpgradePointsAlien - 660.00) / (710.00 / 100.00))))
            else
            end
        end
        if (Trig_UpgradeStatus_Func008C()) then
            udg_UpgradePointsMutant = (udg_UpgradePointsMutant + 0.40)
            if (Trig_UpgradeStatus_Func008Func004C()) then
                SetPlayerStateBJ(udg_Mutant, PLAYER_STATE_RESOURCE_FOOD_USED,
                    R2I(((udg_UpgradePointsMutant - 0.00) / (300.00 / 100.00))))
            else
                if (Trig_UpgradeStatus_Func008Func004Func001C()) then
                    SetPlayerStateBJ(udg_Mutant, PLAYER_STATE_RESOURCE_FOOD_USED,
                        R2I(((udg_UpgradePointsMutant - 300.00) / (600.00 / 100.00))))
                else
                    if (Trig_UpgradeStatus_Func008Func004Func001Func001C()) then
                        SetPlayerStateBJ(udg_Mutant, PLAYER_STATE_RESOURCE_FOOD_USED,
                            R2I(((udg_UpgradePointsMutant - 900.00) / (900.00 / 100.00))))
                    else
                    end
                end
            end
            SetPlayerStateBJ(udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER, R2I(udg_UpgradePointsMutant))
        else
            AdjustPlayerStateBJ(1, udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER)
        end
        SetPlayerStateBJ(udg_Parasite, PLAYER_STATE_RESOURCE_LUMBER, R2I(udg_UpgradePointsAlien))
        SetPlayerStateBJ(udg_HiddenAndroid, PLAYER_STATE_RESOURCE_LUMBER, R2I(udg_UpgradePointsAndroid))
        SetPlayerStateBJ(udg_HiddenAndroid, PLAYER_STATE_RESOURCE_FOOD_USED,
            R2I(((udg_UpgradePointsAndroid - 0.00) / (2000.00 / 100.00))))
        if (Trig_UpgradeStatus_Func012C()) then
            udg_MutantUpgrades[1] = true
            DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 30,
                "|cffFF8040You feel new power coursing through you. It is time to evolve...Press ESC when you are ready.")
            CinematicFilterGenericForPlayer(udg_Mutant, 6.0, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 100, 0, 0, 25, 0, 0, 0, 100)
        else
        end
        if (Trig_UpgradeStatus_Func013C()) then
            udg_MutantUpgrades[2] = true
            DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 30,
                "|cffFF8040You feel new power coursing through you. It is time to evolve...Press ESC when you are ready.")
            CinematicFilterGenericForPlayer(udg_Mutant, 6.0, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 100, 0, 0, 25, 0, 0, 0, 100)
        else
        end
        if (Trig_UpgradeStatus_Func014C()) then
            udg_MutantUpgrades[3] = true
            DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 30,
                "|cffFF8040You feel new power coursing through you. It is time to evolve...Press ESC when you are ready.")
            CinematicFilterGenericForPlayer(udg_Mutant, 6.0, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 100, 0, 0, 25, 0, 0, 0, 100)
        else
        end
        if (Trig_UpgradeStatus_Func015C()) then
            udg_ParasiteUpgrades[1] = true
            DisplayTimedTextToPlayer(udg_Parasite, 0, 0, 30,
                "|cffFF8040You feel new power coursing through you. It is time to transform...Press ESC when you are ready.")
            CinematicFilterGenericForPlayer(udg_Parasite, 6.0, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0, 100, 100, 25, 0, 0, 0, 100)
        else
        end
        if (Trig_UpgradeStatus_Func016C()) then
            udg_ParasiteUpgrades[2] = true
            DisplayTimedTextToPlayer(udg_Parasite, 0, 0, 30,
                "|cffFF8040You feel new power coursing through you. It is time to transform...Press ESC when you are ready.")
            CinematicFilterGenericForPlayer(udg_Parasite, 6.0, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0, 100, 100, 25, 0, 0, 0, 100)
        else
        end
        if (Trig_UpgradeStatus_Func017C()) then
            udg_AndroidUpgrades[1] = true
            EnableTrigger(gg_trg_AndroidUpgrade)
            DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 25.00,
                "|cff00FFFFThe metallic fabricator is ready to build you a new chassis, if necessary. Proceed to the Arbitress.|r")
            CinematicFilterGenericForPlayer(udg_HiddenAndroid, 6.0, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0, 100, 100, 0, 0, 0, 0, 100)
        else
        end
    end

    --===========================================================================
    gg_trg_UpgradeStatus = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_UpgradeStatus, 1.00)
    TriggerAddAction(gg_trg_UpgradeStatus, Trig_UpgradeStatus_Actions)
end)
if Debug then Debug.endFile() end
