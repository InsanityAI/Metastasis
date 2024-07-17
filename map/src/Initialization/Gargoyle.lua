if Debug then Debug.beginFile "Initialization/Gargoyle" end
OnInit.map("Gargoyle", function(require)
    function Trig_Gargoyle_Actions()
        PauseUnitBJ(true, gg_unit_u000_0150)
    end

    --===========================================================================
    gg_trg_Gargoyle = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Gargoyle, 0.00)
    TriggerAddAction(gg_trg_Gargoyle, Trig_Gargoyle_Actions)
end)
if Debug then Debug.endFile() end
