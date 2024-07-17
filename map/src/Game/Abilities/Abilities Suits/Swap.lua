if Debug then Debug.beginFile "Game/Abilities/Suits/Swap" end
OnInit.map("Swap", function(require)
    ---@return boolean
    function Trig_Swap_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A04E'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Swap_Func005002002001()
        return (GetUnitTypeId(GetFilterUnit()) == FourCC('h00M'))
    end

    ---@return boolean
    function Trig_Swap_Func005002002002()
        return (IsUnitIllusionBJ(GetFilterUnit()) == true)
    end

    ---@return boolean
    function Trig_Swap_Func005002002()
        return GetBooleanAnd(Trig_Swap_Func005002002001(), Trig_Swap_Func005002002002())
    end

    function Trig_Swap_Func007A()
        udg_TempReal2 = GetUnitFacing(GetEnumUnit())
        udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
        SetUnitPositionLocFacingBJ(GetEnumUnit(), udg_TempPoint, udg_TempReal)
        udg_TempReal2 = GetUnitFacing(GetEnumUnit())
        SetUnitPositionLocFacingBJ(udg_TempUnit, udg_TempPoint2, udg_TempReal2)
        SetUnitPositionLocFacingBJ(GetEnumUnit(), udg_TempPoint, udg_TempReal)
        SetUnitPositionLocFacingBJ(udg_TempUnit, udg_TempPoint2, udg_TempReal2)
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
    end

    function Trig_Swap_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempReal = GetUnitFacing(GetSpellAbilityUnit())
        udg_TempUnitGroup = GetUnitsOfPlayerMatching(GetOwningPlayer(GetSpellAbilityUnit()),
            Condition(Trig_Swap_Func005002002))
        udg_TempUnit = GetSpellAbilityUnit()
        ForGroupBJ(udg_TempUnitGroup, Trig_Swap_Func007A)
    end

    --===========================================================================
    gg_trg_Swap = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Swap, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Swap, Condition(Trig_Swap_Conditions))
    TriggerAddAction(gg_trg_Swap, Trig_Swap_Actions)
end)
if Debug then Debug.endFile() end
