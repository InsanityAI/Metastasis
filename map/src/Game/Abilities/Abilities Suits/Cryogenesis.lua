if Debug then Debug.beginFile "Game/Abilities/Suits/Cryogenesis" end
OnInit.trigg("Cryogenesis", function(require)
    ---@return boolean
    function Trig_Cryogenesis_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07M'))) then
            return false
        end
        return true
    end

    function Cryogenesis_Slide()
        local k      = GetExpiredTimer() ---@type timer
        local l      = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a      = GetUnitLoc(l) ---@type location
        local b      = PolarProjectionBJ(a, 40.0, GetUnitFacing(l)) ---@type location
        local c      = LoadReal(LS(), GetHandleId(l), StringHash("angle")) ---@type real
        local x      = GetUnitX(l) ---@type real
        local y      = GetUnitY(l) ---@type real
        local height = LoadReal(LS(), GetHandleId(k), StringHash("height")) ---@type real

        if height <= GetLocationZ(b) then
            KillUnit(l)
        end
        SetUnitFlyHeight(l, height - GetLocationZ(b), 0)
        SetUnitX(l, GetLocationX(b))
        SetUnitY(l, GetLocationY(b))
        SetUnitFacing(l, c)
        RemoveLocation(b)
        RemoveLocation(a)
        if IsUnitDeadBJ(l) then
            PauseTimer(k)
            DestroyTimer(k)
        end
    end

    function Cryogenesis_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local m ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() then
            KillUnit(a)
            m = CreateUnit(GetOwningPlayer(a), FourCC('e01Q'), GetUnitX(a), GetUnitY(a), 0)
            UnitAddAbility(m, FourCC('A07N'))
            IssueTargetOrderBJ(m, "slow", GetTriggerUnit())
            DestroyTrigger(t)
        end
    end

    function Cryogenesis_Dies()
        local a = GetTriggerUnit() ---@type unit
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

    function Trig_Cryogenesis_Actions()
        local k        = CreateTimer() ---@type timer
        local t        = CreateTrigger() ---@type trigger
        local q        = CreateTrigger() ---@type trigger

        udg_TempPoint  = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetSpellTargetLoc()
        udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint, 10.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        udg_TempBool   = false
        CreateNUnitsAtLoc(1, FourCC('e02K'), GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint3,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"),
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        TriggerRegisterUnitEvent(q, GetLastCreatedUnit(), EVENT_UNIT_DEATH)
        SetUnitPathing(GetLastCreatedUnit(), false)
        TriggerAddAction(q, Cryogenesis_Dies)
        SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t)
        SaveReal(LS(), GetHandleId(k), StringHash("height"),
            GetUnitFlyHeight(GetLastCreatedUnit()) + GetLocationZ(udg_TempPoint3))
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, Cryogenesis_Slide)
        TriggerRegisterUnitInRangeSimple(t, 100.0, GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())
        TriggerAddAction(t, Cryogenesis_Damage)
        SetUnitPathing(GetLastCreatedUnit(), false)
    end

    --===========================================================================
    gg_trg_Cryogenesis = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cryogenesis, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Cryogenesis, Condition(Trig_Cryogenesis_Conditions))
    TriggerAddAction(gg_trg_Cryogenesis, Trig_Cryogenesis_Actions)
end)
if Debug then Debug.endFile() end
