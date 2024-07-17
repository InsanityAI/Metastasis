if Debug then Debug.beginFile "Game/Abilities/Suits/PhaseShift" end
OnInit.trig("PhaseShift", function(require)
    ---@return boolean
    function Trig_PhaseShift_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A00R'))) then
            return false
        end
        return true
    end

    function Trig_PhaseShift_Actions()
        local a = GetTriggerUnit() ---@type unit
        UnitAddAbilityBJ(FourCC('Avul'), a)
        PolledWait(1)
        UnitRemoveAbilityBJ(FourCC('Avul'), a)
    end

    --===========================================================================
    gg_trg_PhaseShift = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PhaseShift, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_PhaseShift, Condition(Trig_PhaseShift_Conditions))
    TriggerAddAction(gg_trg_PhaseShift, Trig_PhaseShift_Actions)
end)
if Debug then Debug.endFile() end
