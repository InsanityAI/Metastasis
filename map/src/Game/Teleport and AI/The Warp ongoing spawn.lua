if Debug then Debug.beginFile "Game/TeleportAndAI/TheWarpOngoingSpawn" end
OnInit.trig("TheWarpOngoingSpawn", function(require)
    function Trig_The_Warp_ongoing_spawn_Actions()
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 2
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            CreateNUnitsAtLocFacingLocBJ(1, FourCC('n00H'), Player(PLAYER_NEUTRAL_AGGRESSIVE),
                GetRandomLocInRect(gg_rct_Warp), GetRandomLocInRect(gg_rct_Warp))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    --===========================================================================
    gg_trg_The_Warp_ongoing_spawn = CreateTrigger()
    DisableTrigger(gg_trg_The_Warp_ongoing_spawn)
    TriggerRegisterTimerEventPeriodic(gg_trg_The_Warp_ongoing_spawn, 2.50)
    TriggerAddAction(gg_trg_The_Warp_ongoing_spawn, Trig_The_Warp_ongoing_spawn_Actions)
end)
if Debug then Debug.endFile() end
