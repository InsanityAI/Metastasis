if Debug then Debug.beginFile "Game/Allignment/Android/AndroidRevive" end
OnInit.trig("AndroidRevive", function(require)
    require "StateTable"
    function Trig_AndroidRevive_Func001Func014A()
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED)
        SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED)
    end

    function Trig_AndroidRevive_Func001Func017A()
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_UNALLIED)
        SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
    end

    ---@return boolean
    function Trig_AndroidRevive_Func001C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I01H'))) then --android card
            return false
        end
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) == false)) then
            return false
        end
        return true
    end

    function Trig_AndroidRevive_Actions()
        local a ---@type location
        local r ---@type effect
        local i = 1 ---@type integer
        local b = GetInventoryIndexOfItemTypeBJ(GetTriggerUnit(), FourCC('I01H')) ---@type integer --android card
        local k = UnitItemInSlot(GetTriggerUnit(), b - 1) ---@type item
        local l = GetTriggerUnit() ---@type unit
        local z ---@type item

        if IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) then
            if b > 0 then
                -- call UnitDropItem(l,FourCC('I01H'))
                RemoveItem(k)
                DisableTrigger(gg_trg_AndroidUpgradeDialogClick)
                DisableTrigger(GetTriggeringTrigger())
                DisableTrigger(gg_trg_AndroidCardVision)
                DisableTrigger(gg_trg_AndroidChat)
                ChangeElevatorWalls(false, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642)
                ChangeElevatorHeight(gg_dest_DTrx_0642, 1)
                a = GetUnitLoc(gg_unit_h03Z_0188)
                z = UnitAddItemById(l, FourCC('I01I'))
                udg_AndroidRemoteID = GetRandomInt(1, 999999999)
                SetItemUserData(z, udg_AndroidRemoteID)
                RemoveLocation(a)
                a = GetRectCenter(gg_rct_AndroidUpgrade)
                while i <= 60 do
                    r = AddSpecialEffectLocBJ(a, "war3mapImported\\AncientExplode.mdx")
                    PolledWait(0.50)
                    DestroyEffectBJ(r)
                    i = i + 1
                end
                udg_TempPoint = a
                udg_TempPlayer = udg_HiddenAndroid
                if udg_UpgradePointsAndroid >= 2000.00 then
                    CreateNUnitsAtLoc(1, udg_Android_Preference, udg_TempPlayer, udg_TempPoint, bj_UNIT_FACING)
                else
                    CreateNUnitsAtLoc(1, FourCC('h00H'), udg_TempPlayer, udg_TempPoint, bj_UNIT_FACING)
                end
                ShowInterfaceForceOn(GetForceOfPlayer(udg_HiddenAndroid), 0.01)
                udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit()
                SetPlayerName(udg_TempPlayer, udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)])
                StateTable.SetPlayerState(udg_TempPlayer, State.Alive)
                PanCameraToTimedLocForPlayer(udg_TempPlayer, udg_TempPoint, 0)
                SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_TempPlayer)
                ForceRemovePlayerSimple(udg_TempPlayer, udg_DeadGroup)
                ForForce(GetPlayersAll(), Trig_AndroidRevive_Func001Func014A)
                SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPlayer, bj_ALLIANCE_ALLIED)
                SetPlayerAllianceStateBJ(udg_TempPlayer, Player(bj_PLAYER_NEUTRAL_EXTRA), bj_ALLIANCE_ALLIED)
                ForForce(udg_DeadGroup, Trig_AndroidRevive_Func001Func017A)
                RemoveLocation(udg_TempPoint)
                EnableTrigger(gg_trg_AndroidUpgradeDialogClick)
                RemoveLocation(udg_TempPoint)
                ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642)
                ChangeElevatorHeight(gg_dest_DTrx_0642, 1)
                EnableTrigger(gg_trg_AndroidRevive)

                if udg_PlayerRole[GetConvertedPlayerId(udg_HiddenAndroid)] == 7 then
                    udg_TempPlayer = udg_HiddenAndroid
                    CreateNUnitsAtLoc(1, FourCC('H046'), udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING)
                    udg_TempUnit = GetLastCreatedUnit()
                    udg_TempUnit2 = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]
                    ExecuteFunc("RoboButler")
                end
            end
        end
    end

    --===========================================================================
    gg_trg_AndroidRevive = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_AndroidRevive, gg_rct_Fabricate)
    TriggerAddAction(gg_trg_AndroidRevive, Trig_AndroidRevive_Actions)
end)
if Debug then Debug.endFile() end
