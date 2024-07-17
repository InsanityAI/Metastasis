if Debug then Debug.beginFile "Game/Stations/Moon/Ore" end
OnInit.trig("Ore", function(require)
    ---@return boolean
    function Trig_Ore_Conditions()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e025'))) then
            return false
        end
        return true
    end

    function Ore_Finish()
        local v = CreateItem(FourCC('I01W'), 0, 0) ---@type item
        RollOutItem(v)
    end

    function Trig_Ore_Actions()
        IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop")
        CancelProduction()
        BeginProduction("Refined Ore", 70, "Ore_Finish")
    end

    --===========================================================================
    gg_trg_Ore = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ore, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_Ore, Condition(Trig_Ore_Conditions))
    TriggerAddAction(gg_trg_Ore, Trig_Ore_Actions)
end)
if Debug then Debug.endFile() end
