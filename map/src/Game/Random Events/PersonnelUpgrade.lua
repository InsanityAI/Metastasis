if Debug then Debug.beginFile "Game/RandomEvents/PersonnelUpgrade" end
OnInit.map("PersonnelUpgrade", function(require)
    ---@return boolean
    function Trig_PersonnelUpgrade_Func003C()
        if (not (IsUnitAliveBJ(gg_unit_h009_0029) == true)) then
            return false
        end
        return true
    end

    function Trig_PersonnelUpgrade_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[8] = true
        if (Trig_PersonnelUpgrade_Func003C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4205")
            StartTimerBJ(udg_RandomEvent, false, GetRandomReal(10.00, 1200.00))
            EnableTrigger(gg_trg_PersonnelUpgradeEnter)
            EnableTrigger(gg_trg_PersonnelUpgradeDialog)
            udg_TempPoint = GetRectCenter(gg_rct_PersonnelUpgrade)
            PingMinimapLocForForce(GetPlayersAll(), udg_TempPoint, 12.00)
            RemoveLocation(udg_TempPoint)
        else
            StartTimerBJ(udg_RandomEvent, false, GetRandomReal(10.00, 120.00))
        end
    end

    --===========================================================================
    gg_trg_PersonnelUpgrade = CreateTrigger()
    DisableTrigger(gg_trg_PersonnelUpgrade)
    TriggerAddAction(gg_trg_PersonnelUpgrade, Trig_PersonnelUpgrade_Actions)
end)
if Debug then Debug.endFile() end
