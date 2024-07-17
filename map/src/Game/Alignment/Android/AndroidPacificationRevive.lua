if Debug then Debug.beginFile "Game/Allignment/Android/AndroidPaacificationRevive" end
OnInit.map("AndroidPaacificationRevive", function(require)
    require "StateTable"
    hasRevivedAsPacificationBot = false ---@type boolean


    ---@return boolean
    function Trig_AndroidPacificationRevive_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A094'))) then
            return false
        end
        if GetSpellTargetUnit() ~= gg_unit_h04A_0144 then
            return false
        end
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) == false)) then
            return false
        end
        return true
    end

    function Trig_AndroidPacificationRevive_Actions()
        local z ---@type item
        local q = GetSpellAbilityUnit() ---@type unit
        local i = 0 ---@type integer
        while i <= 5 do
            if GetItemTypeId(UnitItemInSlot(q, i)) == FourCC('I01H') then --Android Card
                RemoveItem(UnitItemInSlot(q, i))
                i = 10                                                    --endloop ;)
            end
            i = i + 1
        end

        udg_TempPlayer = udg_HiddenAndroid
        udg_TempPoint = GetUnitLoc(gg_unit_h04A_0144)
        --set udg_TempPoint2=PolarProjectionBJ(udg_TempPoint,45.0,GetRandomDirectionDeg())
        --set udg_TempUnit=ReplaceUnitBJ(gg_unit_h04A_0144,GetUnitTypeId(gg_unit_h04A_0144),bj_UNIT_STATE_METHOD_RELATIVE)
        UnitAddAbility(gg_unit_h04A_0144, FourCC('AInv')) --Inventory(Hero)
        --set z=CreateItemLoc(FourCC('I01I'),udg_TempPoint2)
        z = UnitAddItemById(q, FourCC('I01I'))            --Remote Control

        --Make the remote control unique/final
        udg_AndroidRemoteID = GetRandomInt(1, 999999999)
        SetItemUserData(z, udg_AndroidRemoteID)

        --Change ownership of the pacification bot, to the android
        SetUnitOwner(gg_unit_h04A_0144, udg_TempPlayer, true)
        ShowInterfaceForceOn(GetForceOfPlayer(udg_HiddenAndroid), 0.01)

        --Set pacification bot as the playerhero of the android
        udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = gg_unit_h04A_0144

        --Rename the player to his name before death
        SetPlayerName(udg_TempPlayer, udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)])
        StateTable.SetPlayerState(udg_TempPlayer, State.Alive)

        --Set the boolean so we know he died as pacification bot
        hasRevivedAsPacificationBot = true

        DisableTrigger(gg_trg_AndroidUpgradeDialogClick)
        DisableTrigger(GetTriggeringTrigger())
        DisableTrigger(gg_trg_AndroidCardVision)
        DisableTrigger(gg_trg_AndroidChat)

        PanCameraToTimedLocForPlayer(udg_TempPlayer, udg_TempPoint, 0)
        SelectUnitForPlayerSingle(gg_unit_h04A_0144, udg_TempPlayer)
        ForceRemovePlayerSimple(udg_TempPlayer, udg_DeadGroup)
        ForForce(GetPlayersAll(), Trig_AndroidRevive_Func001Func014A)
        SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPlayer, bj_ALLIANCE_ALLIED)
        SetPlayerAllianceStateBJ(udg_TempPlayer, Player(bj_PLAYER_NEUTRAL_EXTRA), bj_ALLIANCE_ALLIED)
        ForForce(udg_DeadGroup, Trig_AndroidRevive_Func001Func017A)

        --Clean Memory Leaks
        RemoveLocation(udg_TempPoint)
        --call PauseUnitForPeriod(udg_TempUnit,4.0)
        RemoveLocation(udg_TempPoint2)

        --If CEO -> Create Robo-Butler unit
        if udg_PlayerRole[GetConvertedPlayerId(udg_HiddenAndroid)] == 7 then --If Android == CEO
            udg_TempPlayer = udg_HiddenAndroid
            CreateNUnitsAtLoc(1, FourCC('H046'), udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING)
            udg_TempUnit = GetLastCreatedUnit()
            udg_TempUnit2 = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]
            ExecuteFunc("RoboButler")
        end
    end

    --===========================================================================
    gg_trg_AndroidPacificationRevive = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AndroidPacificationRevive, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    --call TriggerRegisterUnitEvent( gg_trg_AndroidPacificationRevive, gg_unit_h04A_0144, EVENT_UNIT_PICKUP_ITEM )
    TriggerAddCondition(gg_trg_AndroidPacificationRevive, Condition(Trig_AndroidPacificationRevive_Conditions))
    TriggerAddAction(gg_trg_AndroidPacificationRevive, Trig_AndroidPacificationRevive_Actions)
end)
if Debug then Debug.endFile() end
