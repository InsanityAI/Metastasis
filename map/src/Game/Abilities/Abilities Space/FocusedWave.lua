if Debug then Debug.beginFile "Game/Abilities/Space/FocusedWave" end
OnInit.map("FocusedWave", function(require)
    ---@return boolean
    function Trig_FocusedWave_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A05D'))) then
            return false
        end
        return true
    end

    function FocusedWave_Slide()
        local k = GetExpiredTimer() ---@type timer
        local l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a = GetUnitLoc(l) ---@type location
        local b = PolarProjectionBJ(a, 20.0, GetUnitFacing(l)) ---@type location
        RemoveLocation(a)
        SetUnitPositionLoc(l, b)
        RemoveLocation(b)
        if IsUnitDeadBJ(l) then
            DestroyTrigger(LoadTriggerHandle(LS(), GetHandleId(k), StringHash("trig")))
            PauseTimer(k)
            DestroyTimer(k)
        end
    end

    function FocusedWave_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() then
            if IsUnitExplorer(GetTriggerUnit()) then
                UnitDamageTarget(a, GetTriggerUnit(), 15000, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC,
                    WEAPON_TYPE_WHOKNOWS)
            else
                UnitDamageTarget(a, GetTriggerUnit(), 60000, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC,
                    WEAPON_TYPE_WHOKNOWS)
            end
            KillUnit(a)
            DestroyTrigger(t)
            CreateUnit(Player(15), FourCC('e01E'), GetUnitX(a), GetUnitY(a), GetRandomDirectionDeg())
        end
    end

    function Trig_FocusedWave_Actions()
        local k        = CreateTimer() ---@type timer
        local t        = CreateTrigger() ---@type trigger
        udg_TempPoint  = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetSpellTargetLoc()
        udg_TempBool   = false
        CreateNUnitsAtLoc(1, FourCC('e01D'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, FocusedWave_Slide)
        SaveTriggerHandle(LS(), GetHandleId(k), StringHash("trig"), t)
        TriggerRegisterUnitInRangeSimple(t, 100.0, GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())
        TriggerAddAction(t, FocusedWave_Damage)
    end

    --===========================================================================
    gg_trg_FocusedWave = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_FocusedWave, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_FocusedWave, Condition(Trig_FocusedWave_Conditions))
    TriggerAddAction(gg_trg_FocusedWave, Trig_FocusedWave_Actions)
end)
if Debug then Debug.endFile() end
