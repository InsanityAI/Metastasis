if Debug then Debug.beginFile "Game/Abilities/Suits/EnergyOfferingCheckEnd" end
OnInit.trig("EnergyOfferingCheckEnd", function(require)
    ---@return boolean
    function Trig_EnergyOfferingCheckEnd_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A0A3'))) then
            return false
        end
        return true
    end

    function Trig_EnergyOfferingCheckEnd_Actions()
        local l = LoadTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("EnergyOffering_CheckTimer")) ---@type timer
        FlushChildHashtable(LS(), GetHandleId(l))
        PauseTimer(l)
        DestroyTimer(l)
    end

    --===========================================================================
    gg_trg_EnergyOfferingCheckEnd = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_EnergyOfferingCheckEnd, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(gg_trg_EnergyOfferingCheckEnd, Condition(Trig_EnergyOfferingCheckEnd_Conditions))
    TriggerAddAction(gg_trg_EnergyOfferingCheckEnd, Trig_EnergyOfferingCheckEnd_Actions)
end)
if Debug then Debug.endFile() end
