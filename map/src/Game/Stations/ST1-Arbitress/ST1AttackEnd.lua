if Debug then Debug.beginFile "Game/Stations/ST1/ST1AttackEnd" end
OnInit.map("ST1AttackEnd", function(require)
    function Trig_ST1AttackEnd_Actions()
        udg_ST1_TakingDamage = false
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST1)
    end

    --===========================================================================
    gg_trg_ST1AttackEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_ST1AttackEnd, udg_ST1_ResetAlarm)
    TriggerAddAction(gg_trg_ST1AttackEnd, Trig_ST1AttackEnd_Actions)
end)
if Debug then Debug.endFile() end
