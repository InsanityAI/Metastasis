if Debug then Debug.beginFile "Game/Abilities/Mutant/Vector" end
OnInit.trig("Vector", function(require)
    ---@return boolean
    function Trig_Vector_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A05J'))) then
            return false
        end
        return true
    end

    function Vector_Slide()
        local k = GetExpiredTimer() ---@type timer
        local l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a = GetUnitLoc(l) ---@type location
        local i = GetUnitLoc(LoadUnitHandle(LS(), GetHandleId(k), StringHash("target"))) ---@type location
        local q = AngleBetweenPoints(a, i) ---@type real
        local b = PolarProjectionBJ(a, 15.0, GetUnitFacing(l)) ---@type location
        if GetLocationZ(b) > GetLocationZ(a) + 60.0 then
            KillUnit(l)
        end
        if IsTerrainWalkable(GetLocationX(b), GetLocationY(b)) == false then
            KillUnit(l)
        end
        SetUnitPositionLoc(l, b)
        SetUnitFacingTimed(l, q, 0.75)
        RemoveLocation(b)
        RemoveLocation(a)
        RemoveLocation(i)
        if IsUnitDeadBJ(l) then
            PauseTimer(k)
            DestroyTimer(k)
        end
    end

    function Vector_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local i = 0 ---@type integer
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local b = GetTriggerUnit() ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() and udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == false then
            KillUnit(a)
            DestroyTrigger(t)
            while i <= 9 do
                PauseUnit(b, true)
                SetUnitAnimation(b, "death")
                PolledWait(0.3)
                PauseUnit(b, false)
                PolledWait((2 + i) / 2)
                i = i + 1
            end
        end
    end

    function Vector_Dies()
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

    function Trig_Vector_Actions()
        local k        = CreateTimer() ---@type timer
        local t        = CreateTrigger() ---@type trigger
        local q        = CreateTrigger() ---@type trigger

        udg_TempPoint  = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetUnitLoc(GetSpellTargetUnit())
        udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint, 160.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        udg_TempBool   = false
        CreateNUnitsAtLoc(1, FourCC('e01G'), Player(15), udg_TempPoint3,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"),
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        TriggerRegisterUnitEvent(q, GetLastCreatedUnit(), EVENT_UNIT_DEATH)
        TriggerAddAction(q, Vector_Dies)
        SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t)
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, Vector_Slide)
        TriggerRegisterUnitInRangeSimple(t, 50.0, GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("target"), GetSpellTargetUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())
        TriggerAddAction(t, Vector_Damage)
        SetUnitPathing(GetLastCreatedUnit(), false)
    end

    --===========================================================================
    gg_trg_Vector = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vector, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Vector, Condition(Trig_Vector_Conditions))
    TriggerAddAction(gg_trg_Vector, Trig_Vector_Actions)
end)
if Debug then Debug.endFile() end
