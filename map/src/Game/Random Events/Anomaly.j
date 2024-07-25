function Trig_Anomaly_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    set udg_RandomEvent_On[6] = true 
    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(ForcePickRandomPlayer(GetPlayersAll()))]) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 12 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call CreateNUnitsAtLoc(1, 'n00K', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg()) 
        call GroupAddUnitSimple(GetLastCreatedUnit(), udg_AnomalyUnitGroup) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call RemoveLocation(udg_TempPoint) 
    call EnableTrigger(gg_trg_AnomalyDeath) 
    call StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 1200.00)) 
endfunction 

//=========================================================================== 
function InitTrig_Anomaly takes nothing returns nothing 
    set gg_trg_Anomaly = CreateTrigger() 
    call DisableTrigger(gg_trg_Anomaly) 
    call TriggerAddAction(gg_trg_Anomaly, function Trig_Anomaly_Actions) 
endfunction 

