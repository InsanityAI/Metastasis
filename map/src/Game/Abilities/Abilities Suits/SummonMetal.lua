if Debug then Debug.beginFile "Game/Abilities/Suits/SummonMetal" end
OnInit.map("SummonMetal", function(require)
    ---@return boolean
    function Trig_SummonMetal_Conditions()
        if (not (GetUnitTypeId(GetSummonedUnit()) == FourCC('h04L'))) then
            return false
        end
        return true
    end

    function Trig_SummonMetal_Actions()
        SetUnitTimeScalePercent(GetSummonedUnit(), 0.00)
        SetUnitOwner(GetSummonedUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true)
    end

    --===========================================================================
    gg_trg_SummonMetal = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SummonMetal, EVENT_PLAYER_UNIT_SUMMON)
    TriggerAddCondition(gg_trg_SummonMetal, Condition(Trig_SummonMetal_Conditions))
    TriggerAddAction(gg_trg_SummonMetal, Trig_SummonMetal_Actions)
end)
if Debug then Debug.endFile() end
