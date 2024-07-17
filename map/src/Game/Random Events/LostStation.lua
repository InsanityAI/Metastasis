if Debug then Debug.beginFile "Game/RandomEvents/LostStation" end
OnInit.trig("LostStation", function(require)
    function Trig_LostStation_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[2] = true
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1332")
        udg_TempPoint = GetRandomLocInRect(gg_rct_SpaceSound)
        PingMinimapLocForForce(GetPlayersAll(), udg_TempPoint, 15.00)
        SetUnitPositionLoc(gg_unit_h029_0114, udg_TempPoint)
        RemoveLocation(udg_TempPoint)
        StartTimerBJ(udg_LostStation_Disappear, false, 397.00)
        CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_1333")
        udg_LostStation_TimerWindow = GetLastCreatedTimerDialogBJ()
        EnableTrigger(gg_trg_LostStationDisappear)
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 900.00))
    end

    --===========================================================================
    gg_trg_LostStation = CreateTrigger()
    DisableTrigger(gg_trg_LostStation)
    TriggerAddAction(gg_trg_LostStation, Trig_LostStation_Actions)
end)
if Debug then Debug.endFile() end
