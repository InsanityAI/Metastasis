if Debug then Debug.beginFile "Game/Abilities/Mutant/Panic" end
OnInit.trig("Panic", function(require)
    ---@return boolean
    function Trig_Panic_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07G'))) then
            return false
        end
        return true
    end

    function Trig_Panic_Actions()
        SetUnitManaPercentBJ(GetSpellAbilityUnit(), 100)
        UnitRemoveAbilityBJ(FourCC('A07H'), GetSpellAbilityUnit())
        UnitRemoveAbilityBJ(FourCC('A07G'), GetSpellAbilityUnit())
    end

    --===========================================================================
    gg_trg_Panic = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Panic, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Panic, Condition(Trig_Panic_Conditions))
    TriggerAddAction(gg_trg_Panic, Trig_Panic_Actions)
end)
if Debug then Debug.endFile() end
