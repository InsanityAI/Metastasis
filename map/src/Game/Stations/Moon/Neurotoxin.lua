if Debug then Debug.beginFile "Game/Stations/Moon/Neurotoxin" end
OnInit.map("Neurotoxin", function(require)
    ---@return boolean
    function Trig_Neurotoxin_Conditions()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e026'))) then
            return false
        end
        return true
    end

    function Neurotoxin_Finish()
        local v = CreateItem(FourCC('I01X'), 0, 0) ---@type item
        RollOutItem(v)
    end

    function Trig_Neurotoxin_Actions()
        IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop")
        CancelProduction()
        BeginProduction("Neurotoxin Module", 300, "Neurotoxin_Finish")
    end

    --===========================================================================
    gg_trg_Neurotoxin = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Neurotoxin, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_Neurotoxin, Condition(Trig_Neurotoxin_Conditions))
    TriggerAddAction(gg_trg_Neurotoxin, Trig_Neurotoxin_Actions)
end)
if Debug then Debug.endFile() end
