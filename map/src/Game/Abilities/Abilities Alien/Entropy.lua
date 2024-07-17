if Debug then Debug.beginFile "Game/Abilities/Alien/Entropy" end
OnInit.trig("Entropy", function(require)
    ---@return boolean
    function Trig_Entropy_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03M'))) then
            return false
        end
        return true
    end

    function Entropy_Suck_Enum()
        local r = 0 ---@type real
        local m = 0 ---@type real
        local q = TimerGetElapsed(udg_GameTimer) ---@type real
        if HaveSavedReal(LS(), GetHandleId(GetEnumUnit()), StringHash("Entropy_SuckLeniency")) then
            r = LoadReal(LS(), GetHandleId(GetEnumUnit()), StringHash("Entropy_SuckLeniency"))
            m = LoadReal(LS(), GetHandleId(GetEnumUnit()), StringHash("Entropy_LastSuck"))
        else
            r = 0
            m = q
        end
        if q - m > 5 then
            SaveReal(LS(), GetHandleId(GetEnumUnit()), StringHash("Entropy_SuckLeniency"), 0)
            r = 0
        end
        SaveReal(LS(), GetHandleId(GetEnumUnit()), StringHash("Entropy_LastSuck"), q)
        SaveReal(LS(), GetHandleId(GetEnumUnit()), StringHash("Entropy_SuckLeniency"), r + (1 - r) / 30)
        if udg_TempUnit4 ~= GetEnumUnit() and IsPlayerAlien(GetOwningPlayer(GetEnumUnit())) ~= true then
            Push2(GetEnumUnit(), 250.0 * (1 - r), 160.0 * (1 - r), AngleBetweenUnits(GetEnumUnit(), udg_TempUnit4))
        end
    end

    function Entropy_Suck()
        local t       = GetExpiredTimer() ---@type timer
        local q       = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local om      = GetUnitLoc(q) ---@type location
        local g ---@type group
        g             = GetUnitsInRangeOfLocAll(600.0, om)
        udg_TempPoint = om
        udg_TempUnit4 = q
        ForGroup(g, Entropy_Suck_Enum)
        DestroyGroup(g)
        g = nil
        RemoveLocation(om)
        om = nil
    end

    function Trig_Entropy_Actions()
        local b = GetSpellTargetLoc() ---@type location
        local t = CreateTimer() ---@type timer
        local o ---@type unit
        AddSpecialEffectLoc("Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl", b)
        CreateNUnitsAtLoc(1, FourCC('e00N'), Player(bj_PLAYER_NEUTRAL_EXTRA), b,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
        o = GetLastCreatedUnit()
        TimerStart(t, 2, true, Entropy_Suck)
        while 1 ~= 2 do
            IssuePointOrderLocBJ(o, "blizzard", b)
            PolledWait(300)
        end
    end

    --===========================================================================
    gg_trg_Entropy = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Entropy, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Entropy, Condition(Trig_Entropy_Conditions))
    TriggerAddAction(gg_trg_Entropy, Trig_Entropy_Actions)
end)
if Debug then Debug.endFile() end
