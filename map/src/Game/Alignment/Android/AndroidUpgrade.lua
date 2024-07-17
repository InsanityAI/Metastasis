if Debug then Debug.beginFile "Game/Allignment/Android/AndroidUpgrade" end
OnInit.trig("AndroidUpgrade", function(require)
    ---@return boolean
    function Trig_AndroidUpgrade_Conditions()
        if (not (IsUnitIdType(GetUnitTypeId(GetTriggerUnit()), UNIT_TYPE_MECHANICAL) == false)) then
            return false
        end
        if (not (udg_Android_DialogOn == false)) then
            return false
        end
        if (not (udg_UpgradePointsAndroid >= 2000.00)) then
            return false
        end
        if (not (GetTriggerUnit() == udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)])) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidUpgrade_Func017Func001C()
        if (not (GetItemTypeId(UnitItemInSlotBJ(GetTriggerUnit(), GetForLoopIndexA())) == FourCC('I013'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidUpgrade_Func020Func001C()
        if (not (GetItemTypeId(UnitItemInSlotBJ(GetTriggerUnit(), GetForLoopIndexA())) == FourCC('I018'))) then
            return false
        end
        if (not (udg_HiddenAndroid_TKDamageDone <= 0.50)) then
            return false
        end
        if (not (udg_AndroidRemoteID == 0)) then
            return false
        end
        return true
    end

    function Trig_AndroidUpgrade_Actions()
        udg_Android_DialogOn = true
        DialogClearBJ(udg_AndroidUpgradeDialog)
        DialogAddButtonBJ(udg_AndroidUpgradeDialog, "TRIGSTR_3073")
        udg_AndroidUpgradeDialogButtons[1] = GetLastCreatedButtonBJ()
        DialogAddButtonBJ(udg_AndroidUpgradeDialog, "TRIGSTR_3074")
        udg_AndroidUpgradeDialogButtons[2] = GetLastCreatedButtonBJ()
        udg_Android_UpgradingTo[2] = FourCC('h02F')
        DialogAddButtonBJ(udg_AndroidUpgradeDialog, "TRIGSTR_3235")
        udg_AndroidUpgradeDialogButtons[3] = GetLastCreatedButtonBJ()
        udg_Android_UpgradingTo[3] = FourCC('h047')
        -- Penguin Check Begin
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_AndroidUpgrade_Func017Func001C()) then
                DialogAddButtonBJ(udg_AndroidUpgradeDialog, "TRIGSTR_3976")
                udg_AndroidUpgradeDialogButtons[4] = GetLastCreatedButtonBJ()
                udg_Android_UpgradingTo[4] = FourCC('h02U')
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        -- Penguin Check End
        -- Phoenix Check Begin
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_AndroidUpgrade_Func020Func001C()) then
                DialogAddButtonBJ(udg_AndroidUpgradeDialog, "TRIGSTR_5288")
                udg_AndroidUpgradeDialogButtons[5] = GetLastCreatedButtonBJ()
                udg_Android_UpgradingTo[5] = FourCC('h052')
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        -- Phoenix Check End
        DialogDisplayBJ(true, udg_AndroidUpgradeDialog, udg_HiddenAndroid)
        IssuePointOrderLocBJ(GetTriggerUnit(), "move", GetRectCenter(gg_rct_AndroidUpgrade))
    end

    --===========================================================================
    gg_trg_AndroidUpgrade = CreateTrigger()
    DisableTrigger(gg_trg_AndroidUpgrade)
    TriggerRegisterEnterRectSimple(gg_trg_AndroidUpgrade, gg_rct_AndroidUpgrade)
    TriggerAddCondition(gg_trg_AndroidUpgrade, Condition(Trig_AndroidUpgrade_Conditions))
    TriggerAddAction(gg_trg_AndroidUpgrade, Trig_AndroidUpgrade_Actions)
end)
if Debug then Debug.endFile() end
