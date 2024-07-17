if Debug then Debug.beginFile "Game/Abilities/Suits/ChargeupFinish" end
OnInit.trig("ChargeupFinish", function(require)
    ---@return boolean
    function Trig_ChargeupFinish_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A04K'))) then
            return false
        end
        return true
    end

    function ChargeupDischarge()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local b ---@type unit

        if GetAttacker() == a then
            b = GetTriggerUnit()
            UnitRemoveAbility(a, FourCC('A093'))
            UnitDamageTarget(a, b, 155.0, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            bj_lastCreatedEffect = AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl", GetUnitX(b),
                GetUnitY(b))
            SFXThreadClean()
            FlushChildHashtable(LS(), GetHandleId(t))
            DestroyTrigger(t)
            PolledWait(0.4)
            UnitRemoveAbility(a, FourCC('Alit'))
        end
    end

    function Trig_ChargeupFinish_Actions()
        local t = CreateTrigger() ---@type trigger
        local a = GetSpellAbilityUnit() ---@type unit
        --200 radius, 150 dmg
        DamageAreaForPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 200.0, 150.0, GetUnitX(GetSpellAbilityUnit()),
            GetUnitY(GetSpellAbilityUnit()))
        TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), a)
        TriggerAddAction(t, ChargeupDischarge)
        UnitAddAbility(a, FourCC('Alit'))
        UnitAddAbility(a, FourCC('A093'))
        PolledWait(8.0)
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTrigger(t)
        UnitRemoveAbility(a, FourCC('Alit'))
        UnitRemoveAbility(a, FourCC('A093'))
    end

    --===========================================================================
    gg_trg_ChargeupFinish = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ChargeupFinish, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ChargeupFinish, Condition(Trig_ChargeupFinish_Conditions))
    TriggerAddAction(gg_trg_ChargeupFinish, Trig_ChargeupFinish_Actions)
end)
if Debug then Debug.endFile() end
