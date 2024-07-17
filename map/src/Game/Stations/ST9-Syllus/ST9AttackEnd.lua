if Debug then Debug.beginFile "Game/Stations/ST9/ST9AttackEnd" end
OnInit.trig("ST9AttackEnd", function(require)
    function Trig_ST9AttackEnd_Actions()
        udg_ST9_TakingDamage = false
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST9)
    end

    --===========================================================================
    gg_trg_ST9AttackEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_ST9AttackEnd, udg_ST9_ResetAlarm)
    TriggerAddAction(gg_trg_ST9AttackEnd, Trig_ST9AttackEnd_Actions)
end)
if Debug then Debug.endFile() end
