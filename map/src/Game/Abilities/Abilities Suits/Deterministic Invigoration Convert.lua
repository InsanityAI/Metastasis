if Debug then Debug.beginFile "Game/Abilities/Suits/DeterministicInvigorationConvert" end
OnInit.trig("DeterministicInvigorationConvert", function(require)
    ---@return boolean
    function Trig_Deterministic_Invigoration_Convert_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A09V'))) then
            return false
        end
        return true
    end

    function Trig_Deterministic_Invigoration_Convert_Actions()
        UnitRemoveAbilityBJ(FourCC('A09V'), GetTriggerUnit())
        UnitRemoveAbilityBJ(FourCC('A09W'), GetTriggerUnit())
    end

    --===========================================================================
    gg_trg_Deterministic_Invigoration_Convert = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deterministic_Invigoration_Convert, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Deterministic_Invigoration_Convert,
        Condition(Trig_Deterministic_Invigoration_Convert_Conditions))
    TriggerAddAction(gg_trg_Deterministic_Invigoration_Convert, Trig_Deterministic_Invigoration_Convert_Actions)
end)
if Debug then Debug.endFile() end
