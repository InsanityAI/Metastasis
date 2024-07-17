if Debug then Debug.beginFile "Game/Abilities/Items/Warpal" end
OnInit.trig("Warpal", function(require)
    ---@return boolean
    function Trig_Warpal_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I02X'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Warpal_Func014Func001Func002C()
        if ((GetTriggerUnit() == GetEnumUnit())) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('H03I'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Warpal_Func014Func001C()
        if (not Trig_Warpal_Func014Func001Func002C()) then
            return false
        end
        return true
    end

    function Trig_Warpal_Func014A()
        if (Trig_Warpal_Func014Func001C()) then
        else
            UnitDamageTargetBJ(GetTriggerUnit(), GetEnumUnit(), udg_TempReal, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNKNOWN)
        end
    end

    function Trig_Warpal_Actions()
        udg_TempReal = GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit())
        udg_TempLoc = GetUnitLoc(GetTriggerUnit())
        SetUnitManaBJ(GetTriggerUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit()) - udg_Manacurrent1))
        AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()), "war3mapImported\\TwilightSparkle.mdx")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()), "war3mapImported\\Unleash-the-power.mdx")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()), "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()), "war3mapImported\\Energy-Spark.mdx")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        ForGroupBJ(GetUnitsInRangeOfLocAll(300.00, GetUnitLoc(GetTriggerUnit())), Trig_Warpal_Func014A)
        SetUnitManaBJ(GetTriggerUnit(), 0)
        RemoveLocation(udg_TempLoc)
    end

    --===========================================================================
    gg_trg_Warpal = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Warpal, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Warpal, Condition(Trig_Warpal_Conditions))
    TriggerAddAction(gg_trg_Warpal, Trig_Warpal_Actions)
end)
if Debug then Debug.endFile() end
