if Debug then Debug.beginFile "Game/Abilities/Items/ConsoleRepair" end
OnInit.trig("ConsoleRepair", function(require)
    ---@return boolean
    function Trig_ConsoleRepair_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06Q'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ConsoleRepair_Func003Func001C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A06R'), GetEnumUnit()) == 1)) then
            return false
        end
        return true
    end

    function Trig_ConsoleRepair_Func003A()
        if (Trig_ConsoleRepair_Func003Func001C()) then
            RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), FourCC('I01R')))
            SetUnitVertexColorBJ(GetEnumUnit(), 100, 100, 100, 0)
            SetUnitLifePercentBJ(GetEnumUnit(), 100)
            EnableTrigger(LoadTriggerHandle(LS(), GetHandleId(GetEnumUnit()), StringHash("console_k")))
            EnableTrigger(LoadTriggerHandle(LS(), GetHandleId(GetEnumUnit()), StringHash("console_m")))
            UnitRemoveAbilityBJ(FourCC('Avul'), GetEnumUnit())
            UnitRemoveAbilityBJ(FourCC('A06R'), GetEnumUnit())
        else
        end
    end

    function Trig_ConsoleRepair_Actions()
        ForGroupBJ(GetUnitsInRangeOfLocAll(200.00, GetSpellTargetLoc()), Trig_ConsoleRepair_Func003A)
    end

    --===========================================================================
    gg_trg_ConsoleRepair = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ConsoleRepair, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ConsoleRepair, Condition(Trig_ConsoleRepair_Conditions))
    TriggerAddAction(gg_trg_ConsoleRepair, Trig_ConsoleRepair_Actions)
end)
if Debug then Debug.endFile() end
