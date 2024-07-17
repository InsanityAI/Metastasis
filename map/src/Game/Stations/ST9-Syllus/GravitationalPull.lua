if Debug then Debug.beginFile "Game/Stations/ST9/GravitationalPull" end
OnInit.map("GravitationalPull", function(require)
    ---@return boolean
    function Trig_GravitationalPull_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07Z'))) then
            return false
        end
        if (not (GetUnitAbilityLevelSwapped(FourCC('A079'), GetSpellTargetUnit()) == 0)) then
            return false
        end
        return true
    end

    function Trig_GravitationalPull_Actions()
        Push2(GetSpellTargetUnit(), 250.0, 300.0, AngleBetweenUnits(GetSpellTargetUnit(), GetSpellAbilityUnit()))
    end

    --===========================================================================
    gg_trg_GravitationalPull = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GravitationalPull, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_GravitationalPull, Condition(Trig_GravitationalPull_Conditions))
    TriggerAddAction(gg_trg_GravitationalPull, Trig_GravitationalPull_Actions)
end)
if Debug then Debug.endFile() end
