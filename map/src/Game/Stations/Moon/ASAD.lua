if Debug then Debug.beginFile "Game/Stations/Moon/ASAD" end
OnInit.trig("ASAD", function(require)
    ---@return boolean
    function Trig_ASAD_Conditions()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e01W'))) then
            return false
        end
        return true
    end

    function ASAD_Finish()
        local v = CreateItem(FourCC('I01S'), 0, 0) ---@type item
        RollOutItem(v)
    end

    function Trig_ASAD_Actions()
        IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop")
        CancelProduction()
        BeginProduction("Arbitress Scan Augmentation Device", 300, "ASAD_Finish")
    end

    --===========================================================================
    gg_trg_ASAD = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ASAD, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_ASAD, Condition(Trig_ASAD_Conditions))
    TriggerAddAction(gg_trg_ASAD, Trig_ASAD_Actions)
end)
if Debug then Debug.endFile() end
