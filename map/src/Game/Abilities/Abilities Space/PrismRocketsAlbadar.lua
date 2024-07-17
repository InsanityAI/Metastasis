if Debug then Debug.beginFile "Game/Abilities/Space/PrismRocketsAlbadar" end
OnInit.trigggggg("PrismRocketsAlbadar", function(require)
    ---@return boolean
    function Trig_PrismRocketsAlbadar_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07L'))) then
            return false
        end
        return true
    end

    function PrismRocketAlbadar_Slide()
        local k = GetExpiredTimer() ---@type timer
        local l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a = GetUnitLoc(l) ---@type location
        local b = PolarProjectionBJ(a, 80.0, GetUnitFacing(l)) ---@type location
        local c = LoadReal(LS(), GetHandleId(l), StringHash("angle")) ---@type real
        if GetLocationZ(b) > GetLocationZ(a) + GetUnitFlyHeight(l) then
            KillUnit(l)
        end
        --if IsTerrainWalkable(GetLocationX(b), GetLocationY(b)) == false then
        --call KillUnit(l)
        --endif
        SetUnitPositionLoc(l, b)
        SetUnitFacing(l, c)
        RemoveLocation(b)
        RemoveLocation(a)
        if IsUnitDeadBJ(l) then
            PauseTimer(k)
            DestroyTimer(k)
        end
    end

    function PrismRocketAlbadar_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() then
            UnitDamageTarget(a, GetTriggerUnit(), 450, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
            KillUnit(a)
            DestroyTrigger(t)
        end
    end

    function PrismRocketAlbadar_Dies()
        local q = GetTriggeringTrigger() ---@type trigger
        local t = LoadTriggerHandle(LS(), GetHandleId(q), StringHash("t")) ---@type trigger
        local o = LoadTriggerHandle(LS(), GetHandleId(q), StringHash("o")) ---@type trigger
        FlushChildHashtable(LS(), GetHandleId(GetTriggerUnit()))
        FlushChildHashtable(LS(), GetHandleId(q))
        FlushChildHashtable(LS(), GetHandleId(t))
        FlushChildHashtable(LS(), GetHandleId(o))
        DestroyTrigger(q)
        DestroyTrigger(t)
        DestroyTrigger(o)
    end

    ---@param x1 real
    ---@param y2 real
    ---@param z1 real
    ---@param angle real
    function FirePrismRocketAlbadar(x1, y2, z1, angle)
        local k        = CreateTimer() ---@type timer
        local t        = CreateTrigger() ---@type trigger
        local q        = CreateTrigger() ---@type trigger
        udg_TempPoint  = Location(x1, y2)
        udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint, 160.0, angle)
        udg_TempBool   = false
        CreateNUnitsAtLoc(1, FourCC('e02J'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, angle)
        SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"), angle)
        TriggerRegisterUnitEvent(q, GetLastCreatedUnit(), EVENT_UNIT_DEATH)
        TriggerAddAction(q, PrismRocketAlbadar_Dies)
        SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        RemoveLocation(udg_TempPoint)
        TimerStart(k, 0.04, true, PrismRocketAlbadar_Slide)
        TriggerRegisterUnitInRangeSimple(t, 150.0, GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())
        TriggerAddAction(t, PrismRocketAlbadar_Damage)
        SetUnitPathing(GetLastCreatedUnit(), false)
    end

    function PrismRocketsAlbadar_Fire()
        local t        = GetExpiredTimer() ---@type timer
        local b        = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local x        = LoadReal(LS(), GetHandleId(t), StringHash("x")) ---@type real
        local y        = LoadReal(LS(), GetHandleId(t), StringHash("y")) ---@type real
        local o        = Location(x, y) ---@type location
        local c        = PolarProjectionBJ(o, GetRandomReal(0, 300.0), GetRandomDirectionDeg()) ---@type location
        local n        = GetUnitLoc(b) ---@type location
        local m        = PolarProjectionBJ(n, 80.0, AngleBetweenPoints(c, n)) ---@type location
        local omnomnom = AngleBetweenPoints(m, c) ---@type real
        RemoveLocation(n)
        n = nil
        FirePrismRocketAlbadar(GetLocationX(m), GetLocationY(m), GetLocationZ(o) + 130.0, omnomnom)
        RemoveLocation(o)
        o = nil
        RemoveLocation(m)
        m = nil
        RemoveLocation(c)
        c = nil
    end

    function Trig_PrismRocketsAlbadar_Actions()
        local t = CreateTimer() ---@type timer
        local b = GetSpellAbilityUnit() ---@type unit
        local d = GetSpellTargetLoc() ---@type location
        local x = GetLocationX(d) ---@type real
        local y = GetLocationY(d) ---@type real
        RemoveLocation(d)
        d = nil
        SaveTimerHandle(LS(), GetHandleId(b), StringHash("PrismRocket_Timer"), t)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), b)
        SaveReal(LS(), GetHandleId(t), StringHash("x"), x)
        SaveReal(LS(), GetHandleId(t), StringHash("y"), y)
        TimerStart(t, 0.1, true, PrismRocketsAlbadar_Fire)
    end

    --===========================================================================
    gg_trg_PrismRocketsAlbadar = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PrismRocketsAlbadar, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    TriggerAddCondition(gg_trg_PrismRocketsAlbadar, Condition(Trig_PrismRocketsAlbadar_Conditions))
    TriggerAddAction(gg_trg_PrismRocketsAlbadar, Trig_PrismRocketsAlbadar_Actions)
end)
if Debug then Debug.endFile() end
