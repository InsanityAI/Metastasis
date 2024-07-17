if Debug then Debug.beginFile "Game/PureBugfixes/ExplorerInfectionBugfix" end
OnInit.map("ExplorerInfectionBugfix", function(require)
    ---@return boolean
    function Trig_Explorer_infection_Bugfix_Func001C()
        if ((GetSpellAbilityId() == FourCC('A013'))) then
            return true
        end
        if ((GetSpellAbilityId() == FourCC('A01S'))) then
            return true
        end
        if ((GetSpellAbilityId() == FourCC('A01X'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Explorer_infection_Bugfix_Conditions()
        if (not Trig_Explorer_infection_Bugfix_Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Explorer_infection_Bugfix_Func003Func007C()
        return false
    end

    ---@return boolean
    function Trig_Explorer_infection_Bugfix_Func003C()
        if (not Trig_Explorer_infection_Bugfix_Func003Func007C()) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h001'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02I'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02K'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02S'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h03K'))) then
            return false
        end
        return true
    end

    function Trig_Explorer_infection_Bugfix_Actions()
        if (Trig_Explorer_infection_Bugfix_Func003C()) then
            IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
            CreateTextTagUnitBJ("TRIGSTR_4838", GetTriggerUnit(), 0, 10, 100.00, 100.00, 100, 0)
            SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
            SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            SetTextTagLifespanBJ(GetLastCreatedTextTag(), 5)
            SetTextTagFadepointBJ(GetLastCreatedTextTag(), 4)
        else
        end
    end

    --===========================================================================
    gg_trg_Explorer_infection_Bugfix = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Explorer_infection_Bugfix, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Explorer_infection_Bugfix, Condition(Trig_Explorer_infection_Bugfix_Conditions))
    TriggerAddAction(gg_trg_Explorer_infection_Bugfix, Trig_Explorer_infection_Bugfix_Actions)
end)
if Debug then Debug.endFile() end
