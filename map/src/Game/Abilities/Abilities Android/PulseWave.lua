if Debug then Debug.beginFile "Game/Abilities/Android/PulseWave" end
OnInit.trig("PulseWave", function(require)
    ---@return boolean
    function Trig_PulseWave_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A068'))) then
            return false
        end
        return true
    end

    function PulseWave_Slide()
        local k = GetExpiredTimer() ---@type timer
        local l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a = GetUnitLoc(l) ---@type location
        local b = PolarProjectionBJ(a, 40.0, GetUnitFacing(l)) ---@type location
        RemoveLocation(a)
        SetUnitPositionLoc(l, b)
        RemoveLocation(b)
        if IsUnitDeadBJ(l) then
            DestroyTrigger(LoadTriggerHandle(LS(), GetHandleId(k), StringHash("trig")))
            PauseTimer(k)
            DestroyTimer(k)
        end
    end

    function PulseWave_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local b = GetTriggerUnit() ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() then
            UnitDamageTarget(a, GetTriggerUnit(), 75, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
            if IsUnitType(b, UNIT_TYPE_STRUCTURE) ~= true then
                SetUnitAnimation(b, "death")
            end
            PauseUnit(b, true)
            PolledWait(0.8)
            PauseUnit(b, false)
            if not (IsUnitSuit(b) or GetUnitTypeId(b) == FourCC('h00H')) then
                SetUnitAnimation(b, "stand")
            end
            --call KillUnit(a)
            --call DestroyTrigger(t)
        end
    end

    function Trig_PulseWave_Actions()
        local k        = CreateTimer() ---@type timer
        local t        = CreateTrigger() ---@type trigger
        udg_TempPoint  = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetSpellTargetLoc()
        udg_TempBool   = false
        CreateNUnitsAtLoc(1, FourCC('e01R'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, PulseWave_Slide)
        SaveTriggerHandle(LS(), GetHandleId(k), StringHash("trig"), t)
        TriggerRegisterUnitInRangeSimple(t, 100.0, GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())
        TriggerAddAction(t, PulseWave_Damage)
    end

    --===========================================================================
    gg_trg_PulseWave = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PulseWave, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_PulseWave, Condition(Trig_PulseWave_Conditions))
    TriggerAddAction(gg_trg_PulseWave, Trig_PulseWave_Actions)
end)
if Debug then Debug.endFile() end
