if Debug then Debug.beginFile "System/AntiTKSys" end
OnInit.map("AntiTKSys", function(require)
    require "LS"
    LIBRARY_AntiTK = true

    ---@param hash hashtable
    ---@param l1 integer
    ---@param l2 integer
    ---@return real
    function LoadReal2(hash, l1, l2)
        if HaveSavedReal(hash, l1, l2) then
            return LoadReal(hash, l1, l2)
        else
            return 0.0
        end
    end

    ---@param TKer player
    ---@param TKee player
    ---@param points real
    function LogTKPoints(TKer, TKee, points)
        local s  = StringHash("TKPointsOf_" + I2S(GetConvertedPlayerId(TKer)) + "_Towards_" +
            I2S(GetConvertedPlayerId(TKee))) ---@type integer
        local sd = StringHash("LastDamageTimeOf_" + I2S(GetConvertedPlayerId(TKer)) + "_Towards_" +
            I2S(GetConvertedPlayerId(TKee))) ---@type integer
        local r ---@type real

        if HaveSavedReal(LS(), 9449, s) then
            r = LoadReal2(LS(), 9449, s)
        else
            r = 0
        end

        SaveReal(LS(), 9449, sd, TimerGetElapsed(udg_GameTimer))
        SaveReal(LS(), 9449, s,
            r + points / GetUnitState(udg_Playerhero[GetConvertedPlayerId(TKee)], UNIT_STATE_MAX_LIFE))
    end

    ---@param TKer player
    ---@param TKee player
    ---@return real
    function GetPlayerLastDamageTime(TKer, TKee)
        local s = StringHash("LastDamageTimeOf_" + I2S(GetConvertedPlayerId(TKer)) + "_Towards_" +
            I2S(GetConvertedPlayerId(TKee))) ---@type integer
        local r = LoadReal2(LS(), 9449, s) ---@type real
        return r
    end

    ---@param TKer player
    ---@param TKee player
    ---@return real
    function GetPlayerWeightedTKToPlayer(TKer, TKee)
        local s  = StringHash("TKPointsOf_" + I2S(GetConvertedPlayerId(TKer)) + "_Towards_" +
            I2S(GetConvertedPlayerId(TKee))) ---@type integer
        local r  = LoadReal2(LS(), 9449, s) ---@type real
        local s2 = StringHash("TKPointsOf_" + I2S(GetConvertedPlayerId(TKee)) + "_Towards_" +
            I2S(GetConvertedPlayerId(TKer))) ---@type integer
        local r2 = LoadReal2(LS(), 9449, s2) ---@type real

        --Disregard TK scores for players that are EVIL. A TK is between two humans, or an android hitting a human.
        if udg_Mutant == TKer or udg_Mutant == TKee or udg_Parasite == TKer or udg_Parasite == TKee or udg_Player_IsMutantSpawn[GetConvertedPlayerId(TKer)] or udg_Player_IsMutantSpawn[GetConvertedPlayerId(TKee)] or udg_Player_IsParasiteSpawn[GetConvertedPlayerId(TKer)] or udg_Player_IsParasiteSpawn[GetConvertedPlayerId(TKee)] then
            return 0.0
        end

        if GetPlayerLastDamageTime(TKer, TKee) + 300.0 < TimerGetElapsed(udg_GameTimer) then
            return 0.0
        else
            return r - r2
        end
    end

    ---@param killed player
    function AndroidKillCheck(killed)
        local m ---@type real

        if not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] and udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)]) then
            m = GetPlayerWeightedTKToPlayer(udg_HiddenAndroid, killed)
            udg_HiddenAndroid_TKDamageDone = udg_HiddenAndroid_TKDamageDone + m
            if udg_HiddenAndroid_TKDamageDone > 2.7 then
                KillUnit(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)])
                udg_HiddenAndroid_TKDamageDone = 0
            end
        end
    end
end)
if Debug then Debug.endFile() end
