if Debug then Debug.beginFile "Game/Stations/ST9/GravitationalPush" end
OnInit.trig("GravitationalPush", function(require)
    ---@return boolean
    function Trig_GravitationalPush_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A080'))) then
            return false
        end
        if (not (GetUnitAbilityLevelSwapped(FourCC('A079'), GetSpellTargetUnit()) == 0)) then
            return false
        end
        return true
    end

    function Trig_GravitationalPush_Actions()
        Push2(GetSpellTargetUnit(), 250.0, 300.0, AngleBetweenUnits(GetSpellAbilityUnit(), GetSpellTargetUnit()))
    end

    --===========================================================================
    gg_trg_GravitationalPush = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GravitationalPush, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_GravitationalPush, Condition(Trig_GravitationalPush_Conditions))
    TriggerAddAction(gg_trg_GravitationalPush, Trig_GravitationalPush_Actions)
end)
if Debug then Debug.endFile() end
