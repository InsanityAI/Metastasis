if Debug then Debug.beginFile "Game/Abilities/Mutant/MutantSpecializedON" end
OnInit.trig("MutantSpecializedON", function(require)
    ---@return boolean
    function Trig_Mutant_Specialized_ON_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A01X'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mutant_Specialized_ON_Func003C()
        if (not (udg_Mutant_IsRapidGestation == true)) then
            return false
        end
        return true
    end

    function Trig_Mutant_Specialized_ON_Actions()
        if (Trig_Mutant_Specialized_ON_Func003C()) then
            udg_Infection3_initiated = true
            DestroyTrigger(GetTriggeringTrigger())
        else
        end
    end

    --===========================================================================
    gg_trg_Mutant_Specialized_ON = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Mutant_Specialized_ON, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Mutant_Specialized_ON, Condition(Trig_Mutant_Specialized_ON_Conditions))
    TriggerAddAction(gg_trg_Mutant_Specialized_ON, Trig_Mutant_Specialized_ON_Actions)
end)
if Debug then Debug.endFile() end
