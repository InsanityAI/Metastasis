if Debug then Debug.beginFile "Game/Abilities/Mutant/TaintedVendor" end
OnInit.map("TaintedVendor", function(require)
    ---@return boolean
    function Trig_TaintedVendor_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A01T'))) then
            return false
        end
        return true
    end

    function Trig_TaintedVendor_Actions()
        RemoveItemFromStockBJ(FourCC('I004'), GetSpellTargetUnit())
        UnitAddAbilityBJ(FourCC('A01U'), GetSpellTargetUnit())
    end

    --===========================================================================
    gg_trg_TaintedVendor = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_TaintedVendor, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_TaintedVendor, Condition(Trig_TaintedVendor_Conditions))
    TriggerAddAction(gg_trg_TaintedVendor, Trig_TaintedVendor_Actions)
end)
if Debug then Debug.endFile() end
