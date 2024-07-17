if Debug then Debug.beginFile "Game/Stations/Moon/ATM" end
OnInit.map("ATM", function(require)
    ---@return boolean
    function Trig_ATM_Conditions()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e01X'))) then
            return false
        end
        return true
    end

    function ATM_Finish()
        local v = CreateItem(FourCC('I01T'), 0, 0) ---@type item
        RollOutItem(v)
    end

    function Trig_ATM_Actions()
        IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop")
        CancelProduction()
        BeginProduction("Antimatter Teleportation Matrix", 700, "ATM_Finish")
    end

    --===========================================================================
    gg_trg_ATM = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ATM, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_ATM, Condition(Trig_ATM_Conditions))
    TriggerAddAction(gg_trg_ATM, Trig_ATM_Actions)
end)
if Debug then Debug.endFile() end
