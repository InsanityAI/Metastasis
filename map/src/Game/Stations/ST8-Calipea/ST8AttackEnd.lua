if Debug then Debug.beginFile "Game/Stations/ST8/ST8AttackEnd" end
OnInit.trig("ST8AttackEnd", function(require)
    function Trig_ST8AttackEnd_Actions()
        udg_ST8_TakingDamage = false
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST8)
    end

    --===========================================================================
    gg_trg_ST8AttackEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_ST8AttackEnd, udg_ST8_ResetAlarm)
    TriggerAddAction(gg_trg_ST8AttackEnd, Trig_ST8AttackEnd_Actions)
end)
if Debug then Debug.endFile() end
