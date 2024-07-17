if Debug then Debug.beginFile "Game/Abilities/Mutant/PrionRemoveParasite" end
OnInit.map("PrionRemoveParasite", function(require)
    ---@return boolean
    function Trig_PrionRemoveParasite_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A013'))) then
            return false
        end
        if (not (GetSpellAbilityId() == FourCC('A01S'))) then
            return false
        end
        if (not (GetSpellAbilityId() == FourCC('A01X'))) then
            return false
        end
        if (not (GetSpellAbilityId() == FourCC('A09K'))) then
            return false
        end
        return true
    end

    function Trig_PrionRemoveParasite_Actions()
        UnitRemoveBuffBJ(FourCC('BNpa'), GetSpellTargetUnit())
    end

    --===========================================================================
    gg_trg_PrionRemoveParasite = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PrionRemoveParasite, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_PrionRemoveParasite, Condition(Trig_PrionRemoveParasite_Conditions))
    TriggerAddAction(gg_trg_PrionRemoveParasite, Trig_PrionRemoveParasite_Actions)
end)
if Debug then Debug.endFile() end
