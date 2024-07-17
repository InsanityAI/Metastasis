if Debug then Debug.beginFile "Game/Abilities/Suits/HalberdRocket" end
OnInit.map("HalberdRocket", function(require)
    ---@return boolean
    function Trig_HalberdRocket_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03S'))) then
            return false
        end
        return true
    end

    function HalberdRocket_Slide()
        local k = GetExpiredTimer() ---@type timer
        local l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a = GetUnitLoc(l) ---@type location
        local b = PolarProjectionBJ(a, 20.0, GetUnitFacing(l)) ---@type location
        local c = LoadReal(LS(), GetHandleId(l), StringHash("angle")) ---@type real

        if GetLocationZ(b) > GetLocationZ(a) + 60.0 then
            KillUnit(l)
        end
        if IsPointPathable(GetLocationX(b), GetLocationY(b), false) == false then
            KillUnit(l)
        end
        SetUnitPositionLoc(l, b)
        SetUnitFacing(l, c)
        RemoveLocation(b)
        RemoveLocation(a)
        if IsUnitDeadBJ(l) then
            PauseTimer(k)
            DestroyTimer(k)
        end
    end

    function HalberdRocket_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() then
            KillUnit(a)
            DestroyTrigger(t)
        end
    end

    function HalberdRocket_OrderAngle()
        local rocket = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("unit")) ---@type unit
        local a      = GetUnitLoc(rocket) ---@type location
        local b      = GetOrderPointLoc() ---@type location
        local c      = AngleBetweenPoints(a, b) ---@type real
        RemoveLocation(a)
        RemoveLocation(b)
        SaveReal(LS(), GetHandleId(rocket), StringHash("angle"), c)
    end

    function HalberdRocket_Dies()
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

    function Trig_HalberdRocket_Actions()
        local k        = CreateTimer() ---@type timer
        local t        = CreateTrigger() ---@type trigger
        local o        = CreateTrigger() ---@type trigger
        local q        = CreateTrigger() ---@type trigger

        udg_TempPoint  = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetSpellTargetLoc()
        udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint, 10.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        udg_TempBool   = false
        CreateNUnitsAtLoc(1, FourCC('e00C'), GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint3,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"),
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        TriggerRegisterUnitEvent(q, GetLastCreatedUnit(), EVENT_UNIT_DEATH)
        TriggerAddAction(q, HalberdRocket_Dies)
        SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t)
        SaveTriggerHandle(LS(), GetHandleId(q), StringHash("o"), o)
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        TriggerRegisterUnitEvent(o, GetLastCreatedUnit(), EVENT_UNIT_ISSUED_POINT_ORDER)
        SaveUnitHandle(LS(), GetHandleId(o), StringHash("unit"), GetLastCreatedUnit())
        TriggerAddAction(o, HalberdRocket_OrderAngle)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, HalberdRocket_Slide)
        TriggerRegisterUnitInRangeSimple(t, 50.0, GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())
        TriggerAddAction(t, HalberdRocket_Damage)
        SelectUnitForPlayerSingle(GetLastCreatedUnit(), GetOwningPlayer(GetSpellAbilityUnit()))
        SetUnitPathing(GetLastCreatedUnit(), false)
    end

    --===========================================================================
    gg_trg_HalberdRocket = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_HalberdRocket, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_HalberdRocket, Condition(Trig_HalberdRocket_Conditions))
    TriggerAddAction(gg_trg_HalberdRocket, Trig_HalberdRocket_Actions)
end)
if Debug then Debug.endFile() end
