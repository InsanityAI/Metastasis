if Debug then Debug.beginFile "Game/Stations/ST2/ST2AttackEnd" end
OnInit.trig("ST2AttackEnd", function(require)
    function Trig_ST2AttackEnd_Actions()
        udg_ST2_TakingDamage = false
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST2)
    end

    --===========================================================================
    gg_trg_ST2AttackEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_ST2AttackEnd, udg_ST2_ResetAlarm)
    TriggerAddAction(gg_trg_ST2AttackEnd, Trig_ST2AttackEnd_Actions)
end)
if Debug then Debug.endFile() end
