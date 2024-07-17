if Debug then Debug.beginFile "Game/Stations/Moon/RUM" end
OnInit.trig("RUM", function(require)
    ---@return boolean
    function Trig_RUM_Conditions()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e01Z'))) then
            return false
        end
        return true
    end

    function RUM_Finish()
        local v = CreateItem(FourCC('I01U'), 0, 0) ---@type item
        RollOutItem(v)
    end

    function Trig_RUM_Actions()
        IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop")
        CancelProduction()
        BeginProduction("Raptor Upgrade Module", 340, "RUM_Finish")
    end

    --===========================================================================
    gg_trg_RUM = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RUM, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_RUM, Condition(Trig_RUM_Conditions))
    TriggerAddAction(gg_trg_RUM, Trig_RUM_Actions)
end)
if Debug then Debug.endFile() end
