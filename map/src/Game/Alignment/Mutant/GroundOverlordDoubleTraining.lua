if Debug then Debug.beginFile "Game/Allignment/Mutant/GroundOverlordDoubleTraining" end
OnInit.trig("GroundOverlordDoubleTraining", function(require)
    ---@return boolean
    function Trig_GroundOverlordDoubleTraining_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('h04W'))) then
            return false
        end
        if (not (GetUnitTypeId(GetTrainedUnit()) ~= FourCC('h01T'))) then
            return false
        end
        return true
    end

    function Trig_GroundOverlordDoubleTraining_Actions()
        CreateNUnitsAtLoc(1, GetUnitTypeId(GetTrainedUnit()), udg_Mutant, GetUnitLoc(GetTrainedUnit()), bj_UNIT_FACING)
        IssuePointOrderLocBJ(GetLastCreatedUnit(), "move", GetUnitRallyPoint(GetTriggerUnit()))
    end

    --===========================================================================
    gg_trg_GroundOverlordDoubleTraining = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GroundOverlordDoubleTraining, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_GroundOverlordDoubleTraining, Condition(Trig_GroundOverlordDoubleTraining_Conditions))
    TriggerAddAction(gg_trg_GroundOverlordDoubleTraining, Trig_GroundOverlordDoubleTraining_Actions)
end)
if Debug then Debug.endFile() end
