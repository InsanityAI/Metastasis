if Debug then Debug.beginFile "Game/Misc/RenameEnd" end
OnInit.trig("RenameEnd", function(require)
    function Trig_RenameEnd_Actions()
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1557")
        DestroyTrigger(GetTriggeringTrigger())
        DestroyTrigger(gg_trg_Rename)
        DestroyTrigger(gg_trg_DeathSysTwo)
    end

    --===========================================================================
    gg_trg_RenameEnd = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_RenameEnd, 180.00)
    TriggerAddAction(gg_trg_RenameEnd, Trig_RenameEnd_Actions)
end)
if Debug then Debug.endFile() end
