if Debug then Debug.beginFile "Game/Abilities/Alien/ParasiteRemovePrion" end
OnInit.trig("ParasiteRemovePrion", function(require)
    ---@return boolean
    function Trig_ParasiteRemovePrion_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02N'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteRemovePrion_Func003C()
        if (not (udg_Infection3_initiated == true)) then
            return false
        end
        if (not (UnitHasBuffBJ(GetSpellTargetUnit(), FourCC('B009')) == true)) then
            return false
        end
        return true
    end

    function Trig_ParasiteRemovePrion_Actions()
        if (Trig_ParasiteRemovePrion_Func003C()) then
            IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
        else
            UnitRemoveBuffBJ(FourCC('B009'), GetSpellTargetUnit())
        end
    end

    --===========================================================================
    gg_trg_ParasiteRemovePrion = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ParasiteRemovePrion, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ParasiteRemovePrion, Condition(Trig_ParasiteRemovePrion_Conditions))
    TriggerAddAction(gg_trg_ParasiteRemovePrion, Trig_ParasiteRemovePrion_Actions)
end)
if Debug then Debug.endFile() end
