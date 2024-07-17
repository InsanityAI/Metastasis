if Debug then Debug.beginFile "Game/Abilities/Alien/EntropyTimer" end
OnInit.trig("EntropyTimer", function(require)
    ---@return boolean
    function Trig_Entropytimer_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03M'))) then
            return false
        end
        return true
    end

    function Trig_Entropytimer_Actions()
        UnitApplyTimedLifeBJ(60.00, FourCC('BTLF'), GetLastCreatedUnit())
    end

    --===========================================================================
    gg_trg_Entropytimer = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Entropytimer, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Entropytimer, Condition(Trig_Entropytimer_Conditions))
    TriggerAddAction(gg_trg_Entropytimer, Trig_Entropytimer_Actions)
end)
if Debug then Debug.endFile() end
