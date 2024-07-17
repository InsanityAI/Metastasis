if Debug then Debug.beginFile "Game/RandomEvents/Anomaly" end
OnInit.map("Anomaly", function(require)
    function Trig_Anomaly_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[6] = true
        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(ForcePickRandomPlayer(GetPlayersAll()))])
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            CreateNUnitsAtLoc(1, FourCC('n00K'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
            GroupAddUnitSimple(GetLastCreatedUnit(), udg_AnomalyUnitGroup)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        RemoveLocation(udg_TempPoint)
        EnableTrigger(gg_trg_AnomalyDeath)
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 1200.00))
    end

    --===========================================================================
    gg_trg_Anomaly = CreateTrigger()
    DisableTrigger(gg_trg_Anomaly)
    TriggerAddAction(gg_trg_Anomaly, Trig_Anomaly_Actions)
end)
if Debug then Debug.endFile() end
