if Debug then Debug.beginFile "Game/Abilities/Suits/CoreOverloadStop" end
OnInit.trig("CoreOverloadStop", function(require)
    ---@return boolean
    function Trig_CoreoverloadStop_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06C'))) then
            return false
        end
        return true
    end

    function Trig_CoreoverloadStop_Actions()
        SetUnitManaBJ(GetSpellAbilityUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetSpellAbilityUnit()) - 20.00))
        DestroyUnitBar(GetSpellAbilityUnit())
    end

    --===========================================================================
    gg_trg_CoreoverloadStop = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CoreoverloadStop, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(gg_trg_CoreoverloadStop, Condition(Trig_CoreoverloadStop_Conditions))
    TriggerAddAction(gg_trg_CoreoverloadStop, Trig_CoreoverloadStop_Actions)
end)
if Debug then Debug.endFile() end
