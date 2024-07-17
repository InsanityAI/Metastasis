if Debug then Debug.beginFile "Game/PureBugfixes/RapidInfectionBugfix" end
OnInit.map("RapidInfectionBugfix", function(require)
    ---@return boolean
    function Trig_Rapid_Infection_Bugfix_Func002C()
        if ((GetUnitTypeId(GetTriggerUnit()) == FourCC('h01M'))) then
            return true
        end
        if ((GetUnitTypeId(GetTriggerUnit()) == FourCC('h01L'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Rapid_Infection_Bugfix_Func003C()
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h01M'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h01L'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Rapid_Infection_Bugfix_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A01X'))) then
            return false
        end
        if (not Trig_Rapid_Infection_Bugfix_Func002C()) then
            return false
        end
        if (not Trig_Rapid_Infection_Bugfix_Func003C()) then
            return false
        end
        return true
    end

    function Trig_Rapid_Infection_Bugfix_Actions()
        IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
    end

    --===========================================================================
    gg_trg_Rapid_Infection_Bugfix = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Rapid_Infection_Bugfix, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Rapid_Infection_Bugfix, Condition(Trig_Rapid_Infection_Bugfix_Conditions))
    TriggerAddAction(gg_trg_Rapid_Infection_Bugfix, Trig_Rapid_Infection_Bugfix_Actions)
end)
if Debug then Debug.endFile() end
