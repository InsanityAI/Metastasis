if Debug then Debug.beginFile "Initialization/FixHP" end
OnInit.trig("FixHP", function(require)
    function Trig_FixHP_Actions()
        EnableUserUI(true)
    end

    --===========================================================================
    gg_trg_FixHP = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_FixHP, 2)
    TriggerAddAction(gg_trg_FixHP, Trig_FixHP_Actions)
end)
if Debug then Debug.endFile() end
