if Debug then Debug.beginFile "Game/PureBugfixes/IllusionTimer" end
OnInit.trig("IllusionTimer", function(require)
    function Trig_IllusionTimer_Actions()
        udg_IllusionSuitBoolean = false
    end

    --===========================================================================
    gg_trg_IllusionTimer = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_IllusionTimer, udg_IllusionSuitTimer)
    TriggerAddAction(gg_trg_IllusionTimer, Trig_IllusionTimer_Actions)
end)
if Debug then Debug.endFile() end
