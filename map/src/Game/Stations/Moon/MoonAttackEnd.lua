if Debug then Debug.beginFile "Game/Stations/Moon/MoonAttackEnd" end
OnInit.trig("MoonAttackEnd", function(require)
    function Trig_MoonAttackEnd_Actions()
        udg_Moon_TakingDamage = false
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_MoonRect)
    end

    --===========================================================================
    gg_trg_MoonAttackEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_MoonAttackEnd, udg_Moon_ResetAlarm)
    TriggerAddAction(gg_trg_MoonAttackEnd, Trig_MoonAttackEnd_Actions)
end)
if Debug then Debug.endFile() end
