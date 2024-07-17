if Debug then Debug.beginFile "Game/Stations/ST3/ST3AttackEnd" end
OnInit.trig("ST3AttackEnd", function(require)
    function Trig_ST3AttackEnd_Actions()
        udg_ST3_TakingDamage = false
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST3)
    end

    --===========================================================================
    gg_trg_ST3AttackEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_ST3AttackEnd, udg_ST3_ResetAlarm)
    TriggerAddAction(gg_trg_ST3AttackEnd, Trig_ST3AttackEnd_Actions)
end)
if Debug then Debug.endFile() end
