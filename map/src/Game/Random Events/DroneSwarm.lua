if Debug then Debug.beginFile "Game/RandomEvents/DroneSwarm" end
OnInit.trig("DroneSwarm", function(require)
    dronesSpawned = 1 ---@type integer


    ---@return boolean
    function HostileSpaceAIDrone_Cond()
        if GetOwningPlayer(GetFilterUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE) and GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) > 0 then
            return true
        end

        return false
    end

    function HostileSpaceAIDroneExpTimer()
        local g = CreateGroup() ---@type group
        local o ---@type location
        local f = Condition(HostileSpaceAIDrone_Cond) ---@type boolexpr
        local t = GetExpiredTimer() ---@type timer
        local h = GetHandleId(t) ---@type integer
        local a = LoadUnitHandle(LS(), h, StringHash("a")) ---@type unit

        GroupEnumUnitsInRect(g, gg_rct_Space, f)
        if FirstOfGroup(g) == gg_unit_h008_0196 then
            if BlzGroupGetSize(g) == 1 then
                UnitRemoveTypeBJ(UNIT_TYPE_SAPPER, gg_unit_h008_0196)
            else
                GroupRemoveUnit(g, gg_unit_h008_0196)
            end
        end

        o = GetUnitLoc(FirstOfGroup(g))
        IssuePointOrderLoc(a, "attack", o)

        DestroyTimer(t)
        RemoveLocation(o)
        DestroyGroup(g)
        DestroyBoolExpr(f)
        o = nil
        g = nil
        f = nil
        a = nil
        t = nil
    end

    ---@param a unit
    function HostileSpaceAIDrone(a)
        local g = CreateGroup() ---@type group
        local o ---@type location
        local f = Condition(HostileSpaceAIDrone_Cond) ---@type boolexpr
        local t = CreateTimer() ---@type timer
        local h = GetHandleId(t) ---@type integer

        GroupEnumUnitsInRect(g, gg_rct_Space, f)
        if FirstOfGroup(g) == gg_unit_h008_0196 then
            if BlzGroupGetSize(g) == 1 then
                UnitRemoveTypeBJ(UNIT_TYPE_SAPPER, gg_unit_h008_0196)
            else
                GroupRemoveUnit(g, gg_unit_h008_0196)
            end
        end

        o = GetUnitLoc(FirstOfGroup(g))
        IssuePointOrderLoc(a, "attack", o)

        SaveUnitHandle(LS(), h, StringHash("a"), a)
        TimerStart(t, 10.00, true, HostileSpaceAIDroneExpTimer)

        RemoveLocation(o)
        DestroyGroup(g)
        DestroyBoolExpr(f)
        o = nil
        g = nil
        f = nil
        t = nil
    end

    function SpawnDrone()
        if dronesSpawned >= 50 then
            PauseTimer(GetExpiredTimer())
            DestroyTimer(GetExpiredTimer())
            TimerStart(udg_RandomEvent, GetRandomReal(90.00, 1200.00), false, nil)
            return
        end

        dronesSpawned = dronesSpawned + 1

        udg_TempPoint = GetRandomLocInRect(gg_rct_Space)
        PingMinimapLocForForce(GetPlayersAll(), udg_TempPoint, 1.00)
        udg_TempUnit = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_AGGRESSIVE), FourCC('h02T'), udg_TempPoint, bj_UNIT_FACING)
        DestroyEffect(AddSpecialEffectLoc("Objects\\Spawnmodels\\NightElf\\NEDeathSmall\\NEDeathSmall.mdl", udg_TempPoint))
        HostileSpaceAIDrone(udg_TempUnit)
        RemoveLocation(udg_TempPoint)
    end

    function Trig_DroneSwarm_Actions()
        local a ---@type integer
        local b ---@type integer

        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[9] = true

        --Code becomes 9999999999 when it is used.
        --In short, this is the boolean flag of BHD having spawned -> doesn't care about syllus -_-
        if udg_Secret_ControlCode == 9999999999 then --GTFO because it will lag the map to infinite!
            TimerStart(udg_RandomEvent, GetRandomReal(1.00, 2.00), false, nil)
            return
        end

        DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "TRIGSTR_1742")
        StartSound(gg_snd_PursuitTheme)
        RemoveAllGuardPositions(Player(PLAYER_NEUTRAL_AGGRESSIVE))

        TimerStart(CreateTimer(), 1.00, true, SpawnDrone)
    end

    --===========================================================================
    gg_trg_DroneSwarm = CreateTrigger()
    DisableTrigger(gg_trg_DroneSwarm)
    TriggerAddAction(gg_trg_DroneSwarm, Trig_DroneSwarm_Actions)
end)
if Debug then Debug.endFile() end
