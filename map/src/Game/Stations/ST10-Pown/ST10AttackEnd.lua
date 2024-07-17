if Debug then Debug.beginFile "Game/Stations/ST10/ST10AttackEnd" end
OnInit.trig("ST10AttackEnd", function(require)
    function Trig_ST10AttackEnd_Actions()
        udg_ST10_TakingDamage = false
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST10)
    end

    --===========================================================================
    gg_trg_ST10AttackEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_ST10AttackEnd, udg_ST10_ResetAlarm)
    TriggerAddAction(gg_trg_ST10AttackEnd, Trig_ST10AttackEnd_Actions)
end)
if Debug then Debug.endFile() end
