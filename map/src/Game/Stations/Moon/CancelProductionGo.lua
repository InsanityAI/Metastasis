if Debug then Debug.beginFile "Game/Stations/Moon/CancelProductionGo" end
OnInit.trig("CancelProductionGo", function(require)
    ---@return boolean
    function Trig_CancelProductionGo_Conditions()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e01V'))) then
            return false
        end
        return true
    end

    function Trig_CancelProductionGo_Actions()
        IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop")
        CancelProduction()
    end

    --===========================================================================
    gg_trg_CancelProductionGo = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CancelProductionGo, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_CancelProductionGo, Condition(Trig_CancelProductionGo_Conditions))
    TriggerAddAction(gg_trg_CancelProductionGo, Trig_CancelProductionGo_Actions)
end)
if Debug then Debug.endFile() end
