if Debug then Debug.beginFile "Game/Abilities/Suits/PolarityPull" end
OnInit.map("PolarityPull", function(require)
    ---@return boolean
    function Trig_PolarityPull_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A097'))) then
            return false
        end
        return true
    end

    function Trig_PolarityPull_Actions()
        UnitAddAbilityBJ(FourCC('A0A4'), GetTriggerUnit())
        UnitRemoveAbilityBJ(FourCC('A097'), GetTriggerUnit())
    end

    --===========================================================================
    gg_trg_PolarityPull = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PolarityPull, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_PolarityPull, Condition(Trig_PolarityPull_Conditions))
    TriggerAddAction(gg_trg_PolarityPull, Trig_PolarityPull_Actions)
end)
if Debug then Debug.endFile() end
