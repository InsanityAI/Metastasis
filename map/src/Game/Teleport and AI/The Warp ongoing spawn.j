function Trig_The_Warp_ongoing_spawn_Actions takes nothing returns nothing
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 2
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call CreateNUnitsAtLocFacingLocBJ( 1, 'n00H', Player(PLAYER_NEUTRAL_AGGRESSIVE), GetRandomLocInRect(gg_rct_Warp), GetRandomLocInRect(gg_rct_Warp) )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_The_Warp_ongoing_spawn takes nothing returns nothing
    set gg_trg_The_Warp_ongoing_spawn = CreateTrigger(  )
    call DisableTrigger( gg_trg_The_Warp_ongoing_spawn )
    call TriggerRegisterTimerEventPeriodic( gg_trg_The_Warp_ongoing_spawn, 2.50 )
    call TriggerAddAction( gg_trg_The_Warp_ongoing_spawn, function Trig_The_Warp_ongoing_spawn_Actions )
endfunction

