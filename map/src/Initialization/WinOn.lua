if Debug then Debug.beginFile "System/HeroSelectSys/Selection" end
OnInit.map("Selection", function(require)
    function Trig_WinOn_Actions()
        -- If a person leaves before game really start, buggy things can cause instant victory. Tis terrible.
        EnableTrigger(gg_trg_WinCheck)
        DestroyTrigger(GetTriggeringTrigger())
    end

    --===========================================================================
    gg_trg_WinOn = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_WinOn, 10.00)
    TriggerAddAction(gg_trg_WinOn, Trig_WinOn_Actions)
end)
if Debug then Debug.endFile() end
