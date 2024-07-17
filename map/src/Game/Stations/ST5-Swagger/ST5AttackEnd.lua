if Debug then Debug.beginFile "Game/Stations/ST5/ST5AttackEnd" end
OnInit.map("ST5AttackEnd", function(require)
    function Trig_ST5AttackEnd_Actions()
        udg_ST5_TakingDamage = false
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST5)
    end

    --===========================================================================
    gg_trg_ST5AttackEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_ST5AttackEnd, udg_ST5_ResetAlarm)
    TriggerAddAction(gg_trg_ST5AttackEnd, Trig_ST5AttackEnd_Actions)
end)
if Debug then Debug.endFile() end
