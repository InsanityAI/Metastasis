if Debug then Debug.beginFile "Game/Stations/ST8/NeurotoxinEnd" end
OnInit.map("NeurotoxinEnd", function(require)
    ---@return boolean
    function Trig_NeurotoxinEnd_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07D'))) then
            return false
        end
        return true
    end

    function Trig_NeurotoxinEnd_Actions()
        DestroyTimer(LoadTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("neurotoxin_unit")))
        DestroyLightning(LoadLightningHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("neuroLightning")))
    end

    --===========================================================================
    gg_trg_NeurotoxinEnd = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_NeurotoxinEnd, gg_unit_h04E_0259, EVENT_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(gg_trg_NeurotoxinEnd, Condition(Trig_NeurotoxinEnd_Conditions))
    TriggerAddAction(gg_trg_NeurotoxinEnd, Trig_NeurotoxinEnd_Actions)
end)
if Debug then Debug.endFile() end
