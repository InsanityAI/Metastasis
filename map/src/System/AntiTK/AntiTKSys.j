//TESH.scrollpos=34 
//TESH.alwaysfold=0 
library AntiTK requires LS 

    function LoadReal2 takes hashtable hash, integer l1, integer l2 returns real 
        if HaveSavedReal(hash, l1, l2) then 
            return LoadReal(hash, l1, l2) 
        else 
            return 0.0 
        endif 
    endfunction 

    function LogTKPoints takes player TKer, player TKee, real points returns nothing 
        local integer s = StringHash("TKPointsOf_" + I2S(GetConvertedPlayerId(TKer)) + "_Towards_" + I2S(GetConvertedPlayerId(TKee))) 
        local integer sd = StringHash("LastDamageTimeOf_" + I2S(GetConvertedPlayerId(TKer)) + "_Towards_" + I2S(GetConvertedPlayerId(TKee))) 
        local real r 
    
        if HaveSavedReal(LS(), 9449, s) then 
            set r = LoadReal2(LS(), 9449, s) 
        else 
            set r = 0 
        endif 
    
        call SaveReal(LS(), 9449, sd, TimerGetElapsed(udg_GameTimer)) 
        call SaveReal(LS(), 9449, s, r + points / GetUnitState(udg_Playerhero[GetConvertedPlayerId(TKee)], UNIT_STATE_MAX_LIFE)) 
    endfunction 

    function GetPlayerLastDamageTime takes player TKer, player TKee returns real 
        local integer s = StringHash("LastDamageTimeOf_" + I2S(GetConvertedPlayerId(TKer)) + "_Towards_" + I2S(GetConvertedPlayerId(TKee))) 
        local real r = LoadReal2(LS(), 9449, s) 
        return r 
    endfunction 

    function GetPlayerWeightedTKToPlayer takes player TKer, player TKee returns real 
        local integer s = StringHash("TKPointsOf_" + I2S(GetConvertedPlayerId(TKer)) + "_Towards_" + I2S(GetConvertedPlayerId(TKee))) 
        local real r = LoadReal2(LS(), 9449, s) 
        local integer s2 = StringHash("TKPointsOf_" + I2S(GetConvertedPlayerId(TKee)) + "_Towards_" + I2S(GetConvertedPlayerId(TKer))) 
        local real r2 = LoadReal2(LS(), 9449, s2) 
    
        //Disregard TK scores for players that are EVIL. A TK is between two humans, or an android hitting a human. 
        if udg_Mutant == TKer or udg_Mutant == TKee or udg_Parasite == TKer or udg_Parasite == TKee or udg_Player_IsMutantSpawn[GetConvertedPlayerId(TKer)] or udg_Player_IsMutantSpawn[GetConvertedPlayerId(TKee)] or udg_Player_IsParasiteSpawn[GetConvertedPlayerId(TKer)] or udg_Player_IsParasiteSpawn[GetConvertedPlayerId(TKee)] then 
            return 0.0 
        endif 
    
        if GetPlayerLastDamageTime(TKer, TKee) + 300.0 < TimerGetElapsed(udg_GameTimer) then 
            return 0.0 
        else 
            return r - r2 
        endif 
    endfunction 


    function AndroidKillCheck takes player killed returns nothing 
        local real m 
    
        if not(udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] and udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)]) then 
            set m = GetPlayerWeightedTKToPlayer(udg_HiddenAndroid, killed) 
            set udg_HiddenAndroid_TKDamageDone = udg_HiddenAndroid_TKDamageDone + m 
            if udg_HiddenAndroid_TKDamageDone > 2.7 then 
                call KillUnit(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) 
                set udg_HiddenAndroid_TKDamageDone = 0 
            endif 
        endif 
    endfunction 

endlibrary 

//=========================================================================== 
function InitTrig_AntiTKSys takes nothing returns nothing 
endfunction 

