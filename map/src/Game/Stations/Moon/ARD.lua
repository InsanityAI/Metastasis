if Debug then Debug.beginFile "Game/Stations/Moon/ARD" end
OnInit.trig("ARD", function(require)
    ---@return boolean
    function Trig_ARD_Conditions()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e022'))) then
            return false
        end
        return true
    end

    function ARD_Finish()
        local v = CreateItem(FourCC('I01V'), 0, 0) ---@type item
        RollOutItem(v)
    end

    function Trig_ARD_Actions()
        IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop")
        CancelProduction()
        BeginProduction("Auxiliary Repositioning Drive", 600, "ARD_Finish")
    end

    --===========================================================================
    gg_trg_ARD = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ARD, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_ARD, Condition(Trig_ARD_Conditions))
    TriggerAddAction(gg_trg_ARD, Trig_ARD_Actions)
end)
if Debug then Debug.endFile() end
