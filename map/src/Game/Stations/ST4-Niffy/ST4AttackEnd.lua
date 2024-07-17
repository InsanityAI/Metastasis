if Debug then Debug.beginFile "Game/Stations/ST4/ST4AttackEnd" end
OnInit.trig("ST4AttackEnd", function(require)
    function Trig_ST4AttackEnd_Actions()
        udg_ST4_TakingDamage = false
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST4S2)
    end

    --===========================================================================
    gg_trg_ST4AttackEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_ST4AttackEnd, udg_ST4_ResetAlarm)
    TriggerAddAction(gg_trg_ST4AttackEnd, Trig_ST4AttackEnd_Actions)
end)
if Debug then Debug.endFile() end
