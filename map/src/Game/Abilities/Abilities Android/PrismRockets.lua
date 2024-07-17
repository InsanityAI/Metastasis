if Debug then Debug.beginFile "Game/Abilities/Android/PrismRockets" end
OnInit.trig("PrismRockets", function(require)
    ---@return boolean
    function Trig_PrismRockets_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A05U'))) then
            return false
        end
        return true
    end

    function PrismRocket_Slide()
        local k      = GetExpiredTimer() ---@type timer
        local l      = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a      = GetUnitLoc(l) ---@type location
        local b      = PolarProjectionBJ(a, 40.0, GetUnitFacing(l)) ---@type location
        local c      = LoadReal(LS(), GetHandleId(l), StringHash("angle")) ---@type real
        local height = LoadReal(LS(), GetHandleId(l), StringHash("height")) ---@type real
        local d      = LoadReal(LS(), GetHandleId(l), StringHash("zdecay")) ---@type real
        SetUnitFlyHeight(l, height + d - GetLocationZ(b), 0.0)
        SaveReal(LS(), GetHandleId(l), StringHash("height"), height + d)
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

    function PrismRocket_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() then
            KillUnit(a)
            DestroyTrigger(t)
        end
    end

    function PrismRocket_Dies()
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
    ---@param zdecay real
    ---@param angle real
    function FirePrismRocket(x1, y2, z1, zdecay, angle)
        local k        = CreateTimer() ---@type timer
        local t        = CreateTrigger() ---@type trigger
        local q        = CreateTrigger() ---@type trigger
        udg_TempPoint  = Location(x1, y2)
        udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint, 160.0, angle)
        udg_TempBool   = false
        CreateNUnitsAtLoc(1, FourCC('e01M'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, angle)
        SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"), angle)
        SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("height"), z1)
        SetUnitFlyHeight(GetLastCreatedUnit(), z1 - GetLocationZ(udg_TempPoint), 0.0)
        SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("zdecay"), zdecay)
        TriggerRegisterUnitEvent(q, GetLastCreatedUnit(), EVENT_UNIT_DEATH)
        TriggerAddAction(q, PrismRocket_Dies)
        SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        RemoveLocation(udg_TempPoint)
        TimerStart(k, 0.04, true, PrismRocket_Slide)
        TriggerRegisterUnitInRangeSimple(t, 50.0, GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())
        TriggerAddAction(t, PrismRocket_Damage)
        SetUnitPathing(GetLastCreatedUnit(), false)
    end

    function PrismRockets_Fire()
        local t        = GetExpiredTimer() ---@type timer
        local b        = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local port     = LoadInteger(LS(), GetHandleId(t), StringHash("PrismRocket_Port")) + 1 ---@type integer
        local x        = LoadReal(LS(), GetHandleId(t), StringHash("x")) ---@type real
        local y        = LoadReal(LS(), GetHandleId(t), StringHash("y")) ---@type real
        local o        = Location(x, y) ---@type location
        local c        = PolarProjectionBJ(o, GetRandomReal(0, 200.0), GetRandomDirectionDeg()) ---@type location
        local m        = GetUnitLoc(b) ---@type location
        local omnomnom = AngleBetweenPoints(m, c) ---@type real
        if port > 4 then
            port = 1
            SaveInteger(LS(), GetHandleId(t), StringHash("PrismRocket_Port"), 1)
        else
            SaveInteger(LS(), GetHandleId(t), StringHash("PrismRocket_Port"), port)
        end
        if port > 2 then
            port = port + 1
        end
        FirePrismRocket(GetUnitX(b) + (-128 + 64 * (port - 1)) * CosBJ(omnomnom + 90) + 110.8 * CosBJ(omnomnom),
            GetUnitY(b) + (-128 + 64 * (port - 1)) * SinBJ(omnomnom + 90) + 110.8 * SinBJ(omnomnom),
            GetLocationZ(o) + 200.0, -10.0, omnomnom)
        RemoveLocation(o)
        o = nil
        RemoveLocation(m)
        m = nil
        RemoveLocation(c)
        c = nil
    end

    function Trig_PrismRockets_Actions()
        local t = CreateTimer() ---@type timer
        local b = GetSpellAbilityUnit() ---@type unit
        local d = GetSpellTargetLoc() ---@type location
        local x = GetLocationX(d) ---@type real
        local y = GetLocationY(d) ---@type real
        RemoveLocation(d)
        d = nil
        SaveTimerHandle(LS(), GetHandleId(b), StringHash("PrismRocket_Timer"), t)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), b)
        SaveInteger(LS(), GetHandleId(t), StringHash("PrismRocket_Port"), 0)
        SaveReal(LS(), GetHandleId(t), StringHash("x"), x)
        SaveReal(LS(), GetHandleId(t), StringHash("y"), y)
        TimerStart(t, 0.25, true, PrismRockets_Fire)
    end

    --===========================================================================
    gg_trg_PrismRockets = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PrismRockets, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    TriggerAddCondition(gg_trg_PrismRockets, Condition(Trig_PrismRockets_Conditions))
    TriggerAddAction(gg_trg_PrismRockets, Trig_PrismRockets_Actions)
end)
if Debug then Debug.endFile() end
