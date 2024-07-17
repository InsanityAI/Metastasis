if Debug then Debug.beginFile "Game/RandomEvents/LostStationDisappear" end
OnInit.trig("LostStationDisappear", function(require)
    function Trig_LostStationDisappear_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        ShowUnitHide(gg_unit_h029_0114)
        DestroyTimerDialogBJ(udg_LostStation_TimerWindow)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1334")
        TriggerExecute(gg_trg_ST6Death)
    end

    --===========================================================================
    gg_trg_LostStationDisappear = CreateTrigger()
    DisableTrigger(gg_trg_LostStationDisappear)
    TriggerRegisterTimerExpireEventBJ(gg_trg_LostStationDisappear, udg_LostStation_Disappear)
    TriggerAddAction(gg_trg_LostStationDisappear, Trig_LostStationDisappear_Actions)
end)
if Debug then Debug.endFile() end
