if Debug then Debug.beginFile "Game/RandomEvents/PersonnelUpgradeDialog" end
OnInit.trig("PersonnelUpgradeDialog", function(require)
    ---@return boolean
    function Trig_PersonnelUpgradeDialog_Func002Func001C()
        if (not (GetClickedButtonBJ() == udg_PersonnelUpgradeDialog_Button[GetForLoopIndexA()])) then
            return false
        end
        return true
    end

    function Trig_PersonnelUpgradeDialog_Actions()
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 5
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_PersonnelUpgradeDialog_Func002Func001C()) then
                SetPlayerTechResearchedSwap(udg_PersonnelUpgrade_Research[GetForLoopIndexA()], 1, GetTriggerPlayer())
                return
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        DialogDisplayBJ(true, udg_PersonnelUpgradeDialog, GetTriggerPlayer())
    end

    --===========================================================================
    gg_trg_PersonnelUpgradeDialog = CreateTrigger()
    DisableTrigger(gg_trg_PersonnelUpgradeDialog)
    TriggerRegisterDialogEventBJ(gg_trg_PersonnelUpgradeDialog, udg_PersonnelUpgradeDialog)
    TriggerAddAction(gg_trg_PersonnelUpgradeDialog, Trig_PersonnelUpgradeDialog_Actions)
end)
if Debug then Debug.endFile() end
