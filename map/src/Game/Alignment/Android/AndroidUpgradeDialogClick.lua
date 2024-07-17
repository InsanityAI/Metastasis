if Debug then Debug.beginFile "Game/Allignment/Android/AndroidUpgradeDialogClick" end
OnInit.map("AndroidUpgradeDialogClick", function(require)
    function Trig_AndroidUpgradeDialogClick_Actions()
        local c = udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)] ---@type unit
        local b = GetRectCenter(gg_rct_AndroidUpgrade) ---@type location
        local r ---@type effect
        local i = 0 ---@type integer
        local m ---@type integer
        local i1 ---@type item
        local i2 ---@type item
        local i3 ---@type item
        local i4 ---@type item
        local i5 ---@type item
        local i6 ---@type item

        --[1] is Cancel option
        if (GetClickedButtonBJ() == udg_AndroidUpgradeDialogButtons[1]) then
            RemoveLocation(b)
            udg_Android_DialogOn = false
            return
        end

        --Loop, iterating through android evolution choices
        bj_forLoopAIndex = 2
        bj_forLoopAIndexEnd = 10
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (GetClickedButtonBJ() == udg_AndroidUpgradeDialogButtons[GetForLoopIndexA()]) then
                m = udg_Android_UpgradingTo[GetForLoopIndexA()]
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end

        ChangeElevatorWalls(false, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642)
        ChangeElevatorHeight(gg_dest_DTrx_0642, 3)
        UnitAddAbilityBJ(FourCC('Avul'), c) --Invulnerable
        PauseUnit(c, true)
        SetUnitTimeScalePercent(c, 0.0)
        SetUnitPositionLoc(c, b)

        while not (i > 60.0) do
            r = AddSpecialEffectLocBJ(b, "war3mapImported\\AncientExplode.mdl")
            i = i + 1
            PolledWait(0.5) --Emphasis here! This is where the delay of evolution happens!
            DestroyEffect(r)
        end

        RemoveLocation(b)
        i1 = UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], 1)
        i2 = UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], 2)
        i3 = UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], 3)
        i4 = UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], 4)
        i5 = UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], 5)
        i6 = UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], 6)
        i = 1

        while i <= 6 do
            UnitDropItem(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], i)
            i = i + 1
        end

        ReplaceUnitBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], m, bj_UNIT_STATE_METHOD_RELATIVE)

        udg_Android_Preference = m
        udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)] = GetLastReplacedUnitBJ()
        UnitAddItem(GetLastReplacedUnitBJ(), i1)
        UnitAddItem(GetLastReplacedUnitBJ(), i2)
        UnitAddItem(GetLastReplacedUnitBJ(), i3)
        UnitAddItem(GetLastReplacedUnitBJ(), i4)
        UnitAddItem(GetLastReplacedUnitBJ(), i5)
        UnitAddItem(GetLastReplacedUnitBJ(), i6)
        ChangeElevatorHeight(gg_dest_DTrx_0642, 1)
        ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642)
        UnitAddAbilityForPeriod(GetLastReplacedUnitBJ(), FourCC('Avul'), 6.0) --Invulnerable

        --Below makes the color be neutral
        --if GetUnitTypeId(GetLastReplacedUnitBJ())==FourCC('h047') then
        --call SetUnitColor(GetLastReplacedUnitBJ(),ConvertPlayerColor(12))
        --endif
    end

    --===========================================================================
    gg_trg_AndroidUpgradeDialogClick = CreateTrigger()
    TriggerRegisterDialogEventBJ(gg_trg_AndroidUpgradeDialogClick, udg_AndroidUpgradeDialog)
    TriggerAddAction(gg_trg_AndroidUpgradeDialogClick, Trig_AndroidUpgradeDialogClick_Actions)
end)
if Debug then Debug.endFile() end
