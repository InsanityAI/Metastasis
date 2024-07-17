if Debug then Debug.beginFile "Game/Abilities/Mutant/SlyTentacles" end
OnInit.map("SlyTentacles", function(require)
    ---@return boolean
    function Trig_SlyTentacles_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A044'))) then
            return false
        end
        return true
    end

    function Trig_SlyTentacles_Actions()
        udg_TempInt = GetRandomInt(1, 6)
        UnitAddItemSwapped(UnitItemInSlotBJ(GetSpellTargetUnit(), udg_TempInt), GetSpellAbilityUnit())
    end

    --===========================================================================
    gg_trg_SlyTentacles = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SlyTentacles, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SlyTentacles, Condition(Trig_SlyTentacles_Conditions))
    TriggerAddAction(gg_trg_SlyTentacles, Trig_SlyTentacles_Actions)
end)
if Debug then Debug.endFile() end
