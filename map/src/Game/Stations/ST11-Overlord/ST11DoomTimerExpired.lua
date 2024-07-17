if Debug then Debug.beginFile "Game/Stations/ST11/ST11DoomTimerExpired" end
OnInit.map("ST11DoomTimerExpired", function(require)



function Trig_ST11DoomTimerExpired_Actions()
    DestroyTrigger(GetTriggeringTrigger())
    DestroyTimerDialogBJ( udg_OverlordDeath_TimerWindow )
    TriggerExecute(gg_trg_ST11DieNatural)
end

--===========================================================================
    gg_trg_ST11DoomTimerExpired = CreateTrigger(  )
    TriggerRegisterTimerExpireEventBJ( gg_trg_ST11DoomTimerExpired, udg_OverlordDeath_DestructionTimer )
    TriggerAddAction( gg_trg_ST11DoomTimerExpired, Trig_ST11DoomTimerExpired_Actions )
end)
if Debug then Debug.endFile() end
