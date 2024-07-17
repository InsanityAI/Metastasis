if Debug then Debug.beginFile "Game/PureBugfixes/IllusionStop" end
OnInit.trig("IllusionStop", function(require)
    ---@return boolean
    function Trig_IllusionStop_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A00T'))) then
            return false
        end
        if (not (udg_IllusionSuitBoolean == true)) then
            return false
        end
        return true
    end

    function Trig_IllusionStop_Actions()
        IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
    end

    --===========================================================================
    gg_trg_IllusionStop = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_IllusionStop, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_IllusionStop, Condition(Trig_IllusionStop_Conditions))
    TriggerAddAction(gg_trg_IllusionStop, Trig_IllusionStop_Actions)
end)
if Debug then Debug.endFile() end
