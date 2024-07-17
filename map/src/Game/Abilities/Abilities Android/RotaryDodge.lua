if Debug then Debug.beginFile "Game/Abilities/Android/RotaryDodge" end
OnInit.trig("RotaryDodge", function(require)
    ---@return boolean
    function Trig_RotaryDodge_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A065'))) then
            return false
        end
        return true
    end

    function Trig_RotaryDodge_Actions()
        local a = GetSpellAbilityUnit() ---@type unit
        UnitAddAbilityForPeriod(a, FourCC('Avul'), 5.0)
        DamageAreaForPlayer(GetOwningPlayer(a), 225.0, 100.0, GetUnitX(GetSpellAbilityUnit()),
            GetUnitY(GetSpellAbilityUnit()))

        UnitAddAbilityBJ(FourCC('Amrf'), a)
        SetUnitTimeScale(a, 2.0)
        SetUnitMoveSpeed(a, 420.0)
        SetUnitFlyHeightBJ(a, 450.00, 250.00)
        UnitRemoveAbilityBJ(FourCC('Amrf'), a)
        PolledWait(4.20)
        UnitAddAbilityBJ(FourCC('Amrf'), a)
        SetUnitFlyHeightBJ(a, 0.00, 587.50)
        UnitRemoveAbilityBJ(FourCC('Amrf'), a)
        PolledWait(0.70)
        SetUnitMoveSpeed(a, 310.0)
        SetUnitTimeScale(a, 1.0)
        bj_lastCreatedEffect = AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",
            GetUnitX(a), GetUnitY(a))
        SFXThreadClean()
        DamageAreaForPlayer(GetOwningPlayer(a), 225.0, 100.0, GetUnitX(a), GetUnitY(a))
    end

    --===========================================================================
    gg_trg_RotaryDodge = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RotaryDodge, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_RotaryDodge, Condition(Trig_RotaryDodge_Conditions))
    TriggerAddAction(gg_trg_RotaryDodge, Trig_RotaryDodge_Actions)
end)
if Debug then Debug.endFile() end
