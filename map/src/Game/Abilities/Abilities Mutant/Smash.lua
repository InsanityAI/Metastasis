if Debug then Debug.beginFile "Game/Abilities/Mutant/Smash" end
OnInit.trig("Smash", function(require)
    ---@return boolean
    function Trig_Smash_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A098'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Smash_Func006C()
        if (not (GetUnitTypeId(GetSpellAbilityUnit()) == FourCC('h01G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Smash_Func040Func001Func001C()
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('DTrx'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT40'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT16'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT06'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT30'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Smash_Func040Func001C()
        if (not Trig_Smash_Func040Func001Func001C()) then
            return false
        end
        return true
    end

    function Trig_Smash_Func040A()
        if (Trig_Smash_Func040Func001C()) then
            UnitDamageTarget(udg_TempUnit, GetEnumDestructable(), 1500.0, true, false, ATTACK_TYPE_NORMAL,
                DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        else
        end
    end

    function Trig_Smash_Actions()
        local a = GetSpellAbilityUnit() ---@type unit
        local b = GetSpellTargetLoc() ---@type location
        local t = CreateTrigger() ---@type trigger
        if (Trig_Smash_Func006C()) then
            SetUnitTimeScalePercent(GetSpellAbilityUnit(), 5.50)
        else
            SetUnitTimeScalePercent(GetSpellAbilityUnit(), 9.70)
        end
        SmashEnsureNoOrders(a)
        TriggerSleepAction(0.00)
        if not (SmashCheckEnsure(a)) then
            SmashCheckCleanup(a)
            udg_TempUnit = a
            SetUnitTimeScalePercent(udg_TempUnit, 100.00)
            return
        end
        SetUnitAnimation(GetSpellAbilityUnit(), "attack")
        TriggerSleepAction(3.50)
        if not (SmashCheckEnsure(a)) then
            SmashCheckCleanup(a)
            udg_TempUnit = a
            SetUnitTimeScalePercent(udg_TempUnit, 175.00)
            return
        end
        SetUnitTimeScalePercent(GetSpellAbilityUnit(), 0.00)
        udg_TempUnit = a
        SetUnitTimeScalePercent(udg_TempUnit, 175.00)
        TriggerSleepAction(0.00)
        if not (SmashCheckEnsure(a)) then
            SmashCheckCleanup(a)
            udg_TempUnit = a
            SetUnitTimeScalePercent(udg_TempUnit, 175.00)
            return
        end
        SmashCheckCleanup(a)
        udg_TempUnit = a
        udg_TempPoint2 = b
        SetUnitTimeScalePercent(udg_TempUnit, 100.00)
        AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
        SFXThreadClean()
        DamageAreaForPlayer(GetOwningPlayer(a), 120.0, 1500, GetLocationX(udg_TempPoint2), GetLocationY(udg_TempPoint2))
        EnumDestructablesInCircleBJ(120.00, udg_TempPoint2, Trig_Smash_Func040A)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_Smash = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Smash, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Smash, Condition(Trig_Smash_Conditions))
    TriggerAddAction(gg_trg_Smash, Trig_Smash_Actions)
end)
if Debug then Debug.endFile() end
