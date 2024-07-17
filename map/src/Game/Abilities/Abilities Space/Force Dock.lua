if Debug then Debug.beginFile "Game/Abilities/Space/ForceDock" end
OnInit.map("ForceDock", function(require)
    ---@return boolean
    function Trig_Force_Dock_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A04D'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Force_Dock_Func003Func003C()
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02Q'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02H'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02L'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h002'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h03J'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Force_Dock_Func003C()
        if (not Trig_Force_Dock_Func003Func003C()) then
            return false
        end
        return true
    end

    function Trig_Force_Dock_Actions()
        if (Trig_Force_Dock_Func003C()) then
            IssueTargetOrderBJ(GetSpellTargetUnit(), "acidbomb", gg_unit_h009_0029)
        else
            IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
        end
    end

    --===========================================================================
    gg_trg_Force_Dock = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Force_Dock, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Force_Dock, Condition(Trig_Force_Dock_Conditions))
    TriggerAddAction(gg_trg_Force_Dock, Trig_Force_Dock_Actions)
end)
if Debug then Debug.endFile() end
