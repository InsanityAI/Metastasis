if Debug then Debug.beginFile "Game/Abilities/Mutant/Shockwave" end
OnInit.trig("Shockwave", function(require)
    require "IsTerrainWalkable"
    ---@return boolean
    function Trig_Shockwave_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A08U'))) then
            return false
        end
        return true
    end

    function Shockwave_Slide()
        local k = GetExpiredTimer() ---@type timer
        local l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a = GetUnitLoc(l) ---@type location
        local b = PolarProjectionBJ(a, 35.0, GetUnitFacing(l)) ---@type location
        RemoveLocation(a)
        if IsTerrainWalkable(GetLocationX(b), GetLocationY(b)) then
            SetUnitPositionLoc(l, b)
        else
            KillUnit(l)
        end
        RemoveLocation(b)
        if IsUnitDeadBJ(l) then
            DestroyTrigger(LoadTriggerHandle(LS(), GetHandleId(k), StringHash("trig")))
            PauseTimer(k)
            DestroyTimer(k)
        end
    end

    function Shockwave_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local b = GetTriggerUnit() ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() then
            UnitDamageTarget(a, GetTriggerUnit(), 75, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
            Push2(b, 300.0, 200.0, GetUnitFacing(a))
            bj_lastCreatedEffect = AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl",
                b, "origin")
            SFXThreadClean()
        end
    end

    function Trig_Shockwave_Actions()
        local k = CreateTimer() ---@type timer
        local t = CreateTrigger() ---@type trigger
        local b = GetUnitLoc(GetSpellAbilityUnit()) ---@type location
        PlaySound3D("Abilities\\Spells\\Orc\\Shockwave\\Shockwave.wav", GetLocationX(b), GetLocationY(b))
        udg_TempPoint2 = GetSpellTargetLoc()
        udg_TempPoint = PolarProjectionBJ(b, 85.0, AngleBetweenPoints(b, udg_TempPoint2))
        RemoveLocation(b)
        udg_TempBool = false
        CreateNUnitsAtLoc(1, FourCC('e035'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, Shockwave_Slide)
        SaveTriggerHandle(LS(), GetHandleId(k), StringHash("trig"), t)
        TriggerRegisterUnitInRangeSimple(t, 100.0, GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())
        TriggerAddAction(t, Shockwave_Damage)
    end

    --===========================================================================
    gg_trg_Shockwave = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Shockwave, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Shockwave, Condition(Trig_Shockwave_Conditions))
    TriggerAddAction(gg_trg_Shockwave, Trig_Shockwave_Actions)
end)
if Debug then Debug.endFile() end
