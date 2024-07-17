if Debug then Debug.beginFile "Game/Abilities/Suits/EnergyLeechCheckEnd" end
OnInit.trigg("EnergyLeechCheckEnd", function(require)
    ---@return boolean
    function Trig_EnergyLeechCheckEnd_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07X'))) then
            return false
        end
        return true
    end

    function Trig_EnergyLeechCheckEnd_Actions()
        local l = LoadTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("EnergyLeech_CheckTimer")) ---@type timer
        FlushChildHashtable(LS(), GetHandleId(l))
        PauseTimer(l)
        DestroyTimer(l)
    end

    --===========================================================================
    gg_trg_EnergyLeechCheckEnd = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_EnergyLeechCheckEnd, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(gg_trg_EnergyLeechCheckEnd, Condition(Trig_EnergyLeechCheckEnd_Conditions))
    TriggerAddAction(gg_trg_EnergyLeechCheckEnd, Trig_EnergyLeechCheckEnd_Actions)
end)
if Debug then Debug.endFile() end
