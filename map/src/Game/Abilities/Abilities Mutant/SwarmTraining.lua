if Debug then Debug.beginFile "Game/Abilities/Mutant/SwarmTraining" end
OnInit.trig("SwarmTraining", function(require)
    ---@return boolean
    function Trig_SwarmTraining_Conditions()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('h01S'))) then
            return false
        end
        return true
    end

    function Trig_SwarmTraining_Actions()
        IssueTrainOrderByIdBJ(GetTriggerUnit(), FourCC('h01S'))
    end

    --===========================================================================
    gg_trg_SwarmTraining = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SwarmTraining, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_SwarmTraining, Condition(Trig_SwarmTraining_Conditions))
    TriggerAddAction(gg_trg_SwarmTraining, Trig_SwarmTraining_Actions)
end)
if Debug then Debug.endFile() end
