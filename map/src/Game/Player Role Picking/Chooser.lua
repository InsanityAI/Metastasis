if Debug then Debug.beginFile "Game/PlayerRolePicking/Chooser" end
OnInit.map("Chooser", function(require)
    require "StateTable"
    function Trig_Chooser_Func004A()
        udg_Player_OriginalName[GetConvertedPlayerId(GetEnumPlayer())] = GetPlayerName(GetEnumPlayer())
        if GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING then
            ForceAddPlayerSimple(GetEnumPlayer(), udg_ChooseGroup)
            udg_TempInt = udg_TempInt + 1
        end
    end

    ---@return boolean
    function Trig_Chooser_Func005Func001Func001C()
        if (not (CountPlayersInForceBJ(udg_ChooseGroup) < 7)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func005Func001Func003C()
        if (not (GetRandomInt(1, 2) == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func005Func001C()
        if (not (CountPlayersInForceBJ(udg_ChooseGroup) <= 4)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func005C()
        if (not (CountPlayersInForceBJ(udg_ChooseGroup) <= 0)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func006Func001C()
        if (not (GetRandomInt(1, 1) == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func006C()
        if (not (udg_Allow_Android == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func007C()
        if (not (udg_Allow_Parasite == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func008C()
        if (not (udg_Allow_Mutant == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func009Func001Func003Func001C()
        if (not (GetEnumPlayer() == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func009Func001Func003C()
        if (not (GetEnumPlayer() == udg_Parasite)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func009Func001C()
        if (not (GetEnumPlayer() == udg_Mutant)) then
            return false
        end
        return true
    end

    function Trig_Chooser_Func009A()
        if (Trig_Chooser_Func009Func001C()) then
            DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "|cffFF00FFYOU ARE THE MUTANT|r")
            SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 100)
        else
            if (Trig_Chooser_Func009Func001Func003C()) then
                DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "|cffFF8000YOU ARE THE ALIEN|r")
                SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 100)
            else
                if (Trig_Chooser_Func009Func001Func003Func001C()) then
                    DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "|cffFF8000YOU ARE THE ANDROID|r")
                    SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 100)
                else
                    DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "|cff808000YOU ARE HUMAN|r")
                end
            end
        end
    end

    ---@return boolean
    function Trig_Chooser_Func012Func001C()
        if (not (GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING)) then
            return false
        end
        return true
    end

    function Trig_Chooser_Func012A()
        if (Trig_Chooser_Func012Func001C()) then
            ForceAddPlayerSimple(GetEnumPlayer(), udg_ChooseGroup)
        else
        end
    end

    ---@return boolean
    function Trig_Chooser_Func015Func001C()
        if (not (GetLocationX(udg_InitialSpawnPoint[GetConvertedPlayerId(GetEnumPlayer())]) == 0.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func015Func002Func003C()
        if ((udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] == 1)) then
            return true
        end
        if ((udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] == 2)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Chooser_Func015Func002C()
        if (not Trig_Chooser_Func015Func002Func003C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func015Func006C()
        if (not (udg_Parasite == GetEnumPlayer())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func015Func007C()
        if (not (udg_Mutant == GetEnumPlayer())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Chooser_Func015Func008C()
        if (not (udg_HiddenAndroid == GetEnumPlayer())) then
            return false
        end
        return true
    end

    function Trig_Chooser_Func015A()
        if (Trig_Chooser_Func015Func001C()) then
            udg_TempUnit = GroupPickRandomUnit(udg_ChooseRoles_SpawnGroup)
            udg_TempPoint = GetUnitLoc(udg_TempUnit)
            GroupRemoveUnitSimple(udg_TempUnit, udg_ChooseRoles_SpawnGroup)
            RemoveUnit(udg_TempUnit)
            udg_InitialSpawnPoint[GetConvertedPlayerId(GetEnumPlayer())] = udg_TempPoint
        end
        if (Trig_Chooser_Func015Func002C()) then
            UnitAddAbilityBJ(udg_Dr_RoleAbility[udg_Researcher_PhD[GetConvertedPlayerId(GetEnumPlayer())]],
                udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())])
        else
            UnitAddAbilityBJ(udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())]],
                udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())])
        end
        SetUnitPositionLoc(udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())],
            udg_InitialSpawnPoint[GetConvertedPlayerId(GetEnumPlayer())])
        PanCameraToTimedLocForPlayer(GetEnumPlayer(), udg_InitialSpawnPoint[GetConvertedPlayerId(GetEnumPlayer())], 0)
        SelectUnitForPlayerSingle(udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())], GetEnumPlayer())
        if (Trig_Chooser_Func015Func006C()) then
            UnitAddAbilityBJ(FourCC('A02O'), udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())])
        end
        if (Trig_Chooser_Func015Func007C()) then
            UnitAddAbilityBJ(FourCC('A05M'), udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())])
            CreateNUnitsAtLoc(1, FourCC('e031'), GetEnumPlayer(), udg_HoldZone, bj_UNIT_FACING)
        end
        if (Trig_Chooser_Func015Func008C()) then
            UnitAddAbilityBJ(FourCC('A05Z'), udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())])
        end
    end

    ---@return boolean
    function Trig_Chooser_Func026Func001C()
        if (not (udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] == 11)) then
            return false
        end
        return true
    end

    function Trig_Chooser_Func026A()
        if (Trig_Chooser_Func026Func001C()) then
            udg_TempBool = false
        end
    end

    ---@return boolean
    function Trig_Chooser_Func027C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    function Trig_Chooser_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        ForceClear(udg_ChooseGroup)
        udg_TempInt = 0
        ForForce(GetPlayersAll(), Trig_Chooser_Func004A)
        StateTable.InitializeForPlayers(udg_ChooseGroup)
        if (Trig_Chooser_Func005C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_520")
            return
        else
            if (Trig_Chooser_Func005Func001C()) then
                udg_Allow_Android = false
                if (Trig_Chooser_Func005Func001Func003C()) then
                    udg_Allow_Mutant = false
                else
                    udg_Allow_Parasite = false
                end
            else
                if (Trig_Chooser_Func005Func001Func001C()) then
                    udg_Allow_Android = false
                else
                    udg_ExtraStation = GetRandomInt(1, 3)
                end
            end
        end
        if (Trig_Chooser_Func006C()) then
            if (Trig_Chooser_Func006Func001C()) then
                udg_HiddenAndroid = ForcePickRandomPlayer(udg_ChooseGroup)
                StateTable.SetPlayerRole(udg_HiddenAndroid, Role.Android)
                ForceRemovePlayerSimple(udg_HiddenAndroid, udg_ChooseGroup)
            else
                udg_Allow_Android = false
            end
        end
        if (Trig_Chooser_Func007C()) then
            udg_Parasite = ForcePickRandomPlayer(udg_ChooseGroup)
            StateTable.SetPlayerRole(udg_Parasite, Role.Alien)
            SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), udg_Parasite, bj_ALLIANCE_ALLIED_ADVUNITS)
            ForceRemovePlayerSimple(udg_Parasite, udg_ChooseGroup)
        end
        if (Trig_Chooser_Func008C()) then
            udg_Mutant = ForcePickRandomPlayer(udg_ChooseGroup)
            StateTable.SetPlayerRole(udg_Mutant, Role.Mutant)
            ForceRemovePlayerSimple(udg_Mutant, udg_ChooseGroup)
        end
        ForForce(GetPlayersAll(), Trig_Chooser_Func009A)
        TriggerExecute(gg_trg_ChooseRoles)
        ForceClear(udg_ChooseGroup)
        ForForce(GetPlayersAll(), Trig_Chooser_Func012A)
        GroupClear(udg_ChooseRoles_SpawnGroup)
        udg_ChooseRoles_SpawnGroup = GetUnitsOfTypeIdAll(FourCC('e003'))
        ForForce(udg_ChooseGroup, Trig_Chooser_Func015A)
        DestroyTrigger(gg_trg_Researcher)
        DestroyTrigger(gg_trg_CEO)
        DestroyTrigger(gg_trg_Captain)
        DestroyTrigger(gg_trg_Commissar)
        DestroyTrigger(gg_trg_Janitor)
        DestroyTrigger(gg_trg_WarVeteran)
        DestroyTrigger(gg_trg_Engineer)
        DestroyTrigger(gg_trg_SecurityGuard)
        DestroyTrigger(gg_trg_Pilot)
        udg_TempBool = true
        ForForce(GetPlayersAll(), Trig_Chooser_Func026A)
        if (Trig_Chooser_Func027C()) then
            udg_ace_Existence = true
            ShowUnitHide(gg_unit_h02Q_0212)
        else
        end
        GroupClear(udg_ChooseRoles_SpawnGroup)
        ConditionalTriggerExecute(gg_trg_RepickAlien)
        ConditionalTriggerExecute(gg_trg_RepickMutant)
    end

    --===========================================================================
    gg_trg_Chooser = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Chooser, 0.00)
    TriggerAddAction(gg_trg_Chooser, Trig_Chooser_Actions)
end)
if Debug then Debug.endFile() end
