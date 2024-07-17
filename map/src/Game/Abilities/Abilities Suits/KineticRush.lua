if Debug then Debug.beginFile "Game/Abilities/Suits/KineticRush" end
OnInit.trigg("KineticRush", function(require)
    ---@return boolean
    function KineticRush_Condition()
        if (not (GetSpellAbilityId() == FourCC('A05T') or GetSpellAbilityId() == FourCC('A08X'))) then
            return false
        end
        return true
    end

    function KineticRush_PushAway()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("t")) ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() then
            UnitDamageTarget(a, GetTriggerUnit(), 60.0, true, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
            Push2(GetTriggerUnit(), 500.0, 230.0, AngleBetweenUnits(a, GetTriggerUnit()))
        end
    end

    function Trig_KineticRush_Actions()
        local t = CreateTrigger() ---@type trigger
        local a = GetSpellAbilityUnit() ---@type unit
        local b = GetSpellTargetLoc() ---@type location
        PolledWait(0.01)
        TriggerRegisterUnitInRange(t, a, 90.0, nil)
        TriggerAddAction(t, KineticRush_PushAway)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("t"), a)
        udg_TempPoint = GetUnitLoc(a)
        udg_TempPoint2 = b
        Push2(a, 800.0, 250.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        PolledWait(4.0)
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTrigger(t)
        t = nil
    end

    --===========================================================================
    gg_trg_KineticRush = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_KineticRush, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddAction(gg_trg_KineticRush, Trig_KineticRush_Actions)
    TriggerAddCondition(gg_trg_KineticRush, Condition(KineticRush_Condition))
end)
if Debug then Debug.endFile() end
