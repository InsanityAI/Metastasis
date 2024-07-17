if Debug then Debug.beginFile "Game/RandomEvents/PersonnelUpgradeEnter" end
OnInit.map("PersonnelUpgradeEnter", function(require)
    ---@return boolean
    function Trig_PersonnelUpgradeEnter_Conditions()
        if (not (udg_Personnel_HasUpgrade[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PersonnelUpgradeEnter_Func003C()
        if (not (SubStringBJ(I2S(GetUnitPointValue(GetTriggerUnit())), 2, 2) ~= "2")) then
            return false
        end
        if (not (udg_TempInt ~= 0)) then
            return false
        end
        return true
    end

    function Trig_PersonnelUpgradeEnter_Actions()
        if (Trig_PersonnelUpgradeEnter_Func003C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0,
                "|cffffcc00We're sorry, but we don't recognize you in our databanks.|r")
            return
        else
        end
        DialogDisplayBJ(true, udg_PersonnelUpgradeDialog, GetOwningPlayer(GetTriggerUnit()))
        udg_Personnel_HasUpgrade[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] = true
    end

    --===========================================================================
    gg_trg_PersonnelUpgradeEnter = CreateTrigger()
    DisableTrigger(gg_trg_PersonnelUpgradeEnter)
    TriggerRegisterEnterRectSimple(gg_trg_PersonnelUpgradeEnter, gg_rct_PersonnelUpgrade)
    TriggerAddCondition(gg_trg_PersonnelUpgradeEnter, Condition(Trig_PersonnelUpgradeEnter_Conditions))
    TriggerAddAction(gg_trg_PersonnelUpgradeEnter, Trig_PersonnelUpgradeEnter_Actions)
end)
if Debug then Debug.endFile() end
