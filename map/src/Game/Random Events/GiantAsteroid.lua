if Debug then Debug.beginFile "Game/RandomEvents/GiantAsteroid" end
OnInit.trig("GiantAsteroid", function(require)
    function Trig_GiantAsteroid_Actions()
        local i = 7 ---@type integer
        local b = 0 ---@type integer
        local g = GetUnitsInRectAll(gg_rct_Space) ---@type group
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[12] = true
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Space)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3443")
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 1200.00))
        PlaySoundBJ(gg_snd_Warning01)
        while i <= 11 do
            b = 0
            while b <= i do
                udg_TempPoint = GetRandomLocInRect(gg_rct_GiantAsteroidSpawn)
                CreateNUnitsAtLoc(1, FourCC('h04D'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint,
                    GetRandomDirectionDeg())
                SetUnitTimeScalePercent(GetLastCreatedUnit(), GetRandomReal(0.00, 50.00))
                udg_TempReal = GetRandomReal(0, 1)
                udg_TempReal2 = ((udg_TempReal * 200.00) + 50.00)
                SetUnitScalePercent(GetLastCreatedUnit(), udg_TempReal2, udg_TempReal2, udg_TempReal2)
                SetUnitLifePercentBJ(GetLastCreatedUnit(), (udg_TempReal * 100.00))
                RemoveLocation(udg_TempPoint)
                udg_TempUnit = GetLastCreatedUnit()
                if GetRandomInt(1, 2) == 1 then
                    GiantAsteroid(udg_TempUnit, AngleBetweenUnits(udg_TempUnit, GroupPickRandomUnit(g)))
                else
                    GiantAsteroid(udg_TempUnit, 90 + GetRandomReal(-20.0, 20.0))
                end
                DestroyGroup(udg_TempUnitGroup)
                b = b + 1
            end
            PolledWait(GetRandomReal(0.1, 5))
            i = i + 1
        end
        DestroyGroup(g)
        g = nil
    end

    --===========================================================================
    gg_trg_GiantAsteroid = CreateTrigger()
    DisableTrigger(gg_trg_GiantAsteroid)
    TriggerAddAction(gg_trg_GiantAsteroid, Trig_GiantAsteroid_Actions)
end)
if Debug then Debug.endFile() end
