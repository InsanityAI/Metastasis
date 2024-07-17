if Debug then Debug.beginFile "Game/Misc/PlayerMurder" end
OnInit.map("PlayerMurder", function(require)
    ---@return boolean
    function Trig_PlayerMurder_Func002Func001C()
        if ((udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] ~= GetDyingUnit())) then
            return true
        end
        if ((GetOwningPlayer(GetDyingUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_PlayerMurder_Func002C()
        if (not Trig_PlayerMurder_Func002Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func005Func001Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == false)) then
            return false
        end
        if (not (GetOwningPlayer(GetDyingUnit()) ~= udg_Parasite)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func005Func001Func005C()
        if (not (udg_Parasite == GetOwningPlayer(GetDyingUnit()))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func005Func001Func019Func002C()
        if (not (GetOwningPlayer(GetDyingUnit()) ~= udg_Parasite)) then
            return false
        end
        if (not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func005Func001Func019C()
        if ((udg_Mutant_IsRapidGestation == true)) then
            return true
        end
        if (Trig_PlayerMurder_Func005Func001Func019Func002C()) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_PlayerMurder_Func005Func001C()
        if (not (udg_Unit_InfectionType[GetUnitUserData(GetDyingUnit())] == 1)) then
            return false
        end
        if (not (GetOwningPlayer(GetDyingUnit()) ~= udg_HiddenAndroid)) then
            return false
        end
        if (not Trig_PlayerMurder_Func005Func001Func019C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func005C()
        if (not (udg_Unit_IsInfected[GetUnitUserData(GetDyingUnit())] == true)) then
            return false
        end
        if (not (GetOwningPlayer(GetDyingUnit()) ~= udg_HiddenAndroid)) then
            return false
        end
        if (not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == false)) then
            return false
        end
        if (not (GetOwningPlayer(GetDyingUnit()) ~= udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func006Func002Func002Func001Func001Func005Func003C()
        if ((GetOwningPlayer(GetKillingUnitBJ()) == udg_Parasite)) then
            return true
        end
        if ((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))] == true)) then
            return true
        end
        if ((GetOwningPlayer(GetKillingUnitBJ()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_PlayerMurder_Func006Func002Func002Func001Func001Func005C()
        if (not Trig_PlayerMurder_Func006Func002Func002Func001Func001Func005Func003C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func006Func002Func002Func001Func001C()
        if (not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func006Func002Func002Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func006Func002Func002C()
        if (not (udg_HiddenAndroid == GetOwningPlayer(GetDyingUnit()))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func006Func002C()
        if (not (udg_Parasite == GetOwningPlayer(GetDyingUnit()))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func006Func007C()
        if (not (udg_Unit_IsInfected[GetUnitUserData(GetDyingUnit())] == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func006C()
        if (not (udg_Mutant == GetOwningPlayer(GetDyingUnit()))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerMurder_Func010C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    function Trig_PlayerMurder_Actions()
        local victimPlayer = GetOwningPlayer(GetDyingUnit()) ---@type player
        local index        = 1 ---@type integer
        local maxIndex     = 12 ---@type integer
        if (Trig_PlayerMurder_Func002C()) then
            return
        else
        end
        udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
        udg_TempUnit = GetDyingUnit()
        if (Trig_PlayerMurder_Func005C()) then
            if (Trig_PlayerMurder_Func005Func001C()) then
                udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
                udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = true
                udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = false
                if (Trig_PlayerMurder_Func005Func001Func005C()) then
                    udg_Parasite = nil
                else
                end
                udg_TempPoint = GetUnitLoc(GetDyingUnit())
                CreateNUnitsAtLoc(1, udg_MutantChildInfectee, GetOwningPlayer(GetDyingUnit()), udg_TempPoint,
                    bj_UNIT_FACING)
                SetUnitLifePercentBJ(GetLastCreatedUnit(), 33.00)
                SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_TempPlayer)
                PanCameraToTimedLocForPlayer(udg_TempPlayer, udg_TempPoint, 0)
                RemoveLocation(udg_TempPoint)
                udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit()
                DisplayTextToPlayer(GetOwningPlayer(GetDyingUnit()), 0, 0,
                    "|cffFF0000You have been turned into the mutant's spawn! Work with the mutant to ensure victory.|r")
                DisplayTextToPlayer(udg_Mutant, 0, 0, "|cffFF0000You have acquired a spawn!|r")
                StateGrid_SetPlayerRole(victimPlayer, StateGrid_ROLE_MUTANT_SPAWN)
                StateGrid_RevealPlayerRole(udg_Mutant, victimPlayer)
                StateGrid_RevealPlayerRole(victimPlayer, udg_Mutant)
                while index < maxIndex do
                    if udg_Player_IsMutantSpawn[index] then
                        StateGrid_RevealPlayerRole(victimPlayer, ConvertedPlayer(index))
                        StateGrid_RevealPlayerRole(ConvertedPlayer(index), victimPlayer)
                    end
                    index = index + 1
                end
                TriggerExecute(gg_trg_WinCheck)
                return
            else
                if (Trig_PlayerMurder_Func005Func001Func001C()) then
                    udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = true
                    udg_TempPoint = GetUnitLoc(GetDyingUnit())
                    udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
                    CreateNUnitsAtLoc(1, udg_ParasiteChildInfectee, GetOwningPlayer(GetDyingUnit()), udg_TempPoint,
                        bj_UNIT_FACING)
                    SetUnitLifePercentBJ(GetLastCreatedUnit(), 33.00)
                    SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_TempPlayer)
                    PanCameraToTimedLocForPlayer(udg_TempPlayer, udg_TempPoint, 0)
                    RemoveLocation(udg_TempPoint)
                    udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit()
                    DisplayTextToPlayer(GetOwningPlayer(GetDyingUnit()), 0, 0,
                        "|cffFF0000You have been turned into the alien's spawn! Work with the alien to ensure victory.|r")
                    DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffFF0000You have acquired a spawn!|r")
                    DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffffcc00+175 evolution points for successful kill!")
                    udg_UpgradePointsAlien = (udg_UpgradePointsAlien + 175.00)
                    udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
                    StateGrid_SetPlayerRole(victimPlayer, StateGrid_ROLE_ALIEN_SPAWN)
                    StateGrid_RevealPlayerRole(udg_Parasite, victimPlayer)
                    StateGrid_RevealPlayerRole(victimPlayer, udg_Parasite)
                    while index < maxIndex do
                        if udg_Player_IsParasiteSpawn[index] then
                            StateGrid_RevealPlayerRole(victimPlayer, ConvertedPlayer(index))
                            StateGrid_RevealPlayerRole(ConvertedPlayer(index), victimPlayer)
                        end
                        index = index + 1
                    end
                    TriggerExecute(gg_trg_ParasiteSpawnCreateSpell)
                    TriggerExecute(gg_trg_WinCheck)
                    return
                    -- Commented out!
                    --call FadeUnitOverTime(GetDyingUnit(),5.0,true)
                else
                end
            end
        else
        end
        if (Trig_PlayerMurder_Func006C()) then
            DisplayTextToForce(GetPlayersAll(),
                (GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r"))
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3989")
            CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0.00,
                100.00, 0, 50.00)
            PlaySoundBJ(gg_snd_AbominationAlternateDeath1)
            -- New Code here - If alien killed mutant
            if (Trig_PlayerMurder_Func006Func007C()) then
                udg_UpgradePointsAlien = (udg_UpgradePointsAlien + 3000.00)
            else
            end
            -- New Code above - If alien killed mutant
            StateGrid_RevealPlayerRole(victimPlayer, nil)
            StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
        else
            if (Trig_PlayerMurder_Func006Func002C()) then
                DisplayTextToForce(GetPlayersAll(),
                    (GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r"))
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3988")
                CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0.00,
                    0.00, 100.00, 50.00)
                PlaySoundBJ(gg_snd_WarlockDeath1)
                StateGrid_RevealPlayerRole(victimPlayer, nil)
                StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
            else
                if (Trig_PlayerMurder_Func006Func002Func002C()) then
                    DisplayTextToForce(GetPlayersAll(),
                        (GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r"))
                    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3987")
                    CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp",
                        100.00, 100.00, 100.00, 50.00)
                    PlaySoundBJ(gg_snd_RockGolemDeath1)
                    StateGrid_RevealPlayerRole(victimPlayer, nil)
                    StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
                else
                    if (Trig_PlayerMurder_Func006Func002Func002Func001C()) then
                        DisplayTextToForce(GetPlayersAll(),
                            (GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r"))
                        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3986")
                        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 4.00,
                            "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0.00, 0.00, 100.00, 50.00)
                        PlaySoundBJ(gg_snd_PitFiendDeath1)
                        StateGrid_RevealPlayerRole(victimPlayer, nil)
                        StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
                    else
                        if (Trig_PlayerMurder_Func006Func002Func002Func001Func001C()) then
                            DisplayTextToForce(GetPlayersAll(),
                                (GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r"))
                            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3985")
                            CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 4.00,
                                "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0.00, 100.00, 100.00, 50.00)
                            PlaySoundBJ(gg_snd_BansheeDeath)
                            StateGrid_RevealPlayerRole(victimPlayer, nil)
                            StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
                        else
                            DisplayTextToForce(GetPlayersAll(),
                                (GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r"))
                            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3983")
                            CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 4.00,
                                "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 0.00, 0.00, 50.00)
                            PlaySoundBJ(gg_snd_PeasantDeath)
                            if (Trig_PlayerMurder_Func006Func002Func002Func001Func001Func005C()) then
                                DisplayTextToPlayer(udg_Parasite, 0, 0,
                                    "|cffffcc00+175 evolution points for successful kill!")
                                udg_UpgradePointsAlien = (udg_UpgradePointsAlien + 175.00)
                            else
                            end
                            StateGrid_RevealPlayerRole(victimPlayer, nil)
                            StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
                        end
                    end
                end
            end
        end
        AndroidKillCheck(GetOwningPlayer(GetDyingUnit()))
        udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
        udg_TempUnit = GetDyingUnit()
        if (Trig_PlayerMurder_Func010C()) then
            udg_TempPoint = GetUnitLoc(udg_TempUnit)
            CreateItemLoc(FourCC('I01H'), udg_TempPoint)
            RemoveLocation(udg_TempPoint)
            udg_Android_MemoryCard = GetLastCreatedItem()
        else
        end
        MurderPart2()
    end

    --===========================================================================
    gg_trg_PlayerMurder = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PlayerMurder, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(gg_trg_PlayerMurder, Trig_PlayerMurder_Actions)
end)
if Debug then Debug.endFile() end
