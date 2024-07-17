if Debug then Debug.beginFile "Game/Abilities/Mutant/RollingThunder" end
OnInit.trig("RollingThunder", function(require)
    ---@return boolean
    function Trig_RollingThunder_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A08T'))) then
            return false
        end
        return true
    end

    function Trig_RollingThunder_Actions()
        local a      = GetSpellAbilityUnit() ---@type unit
        udg_TempUnit = a
        UnitRemoveAbilityBJ(FourCC('A08T'), udg_TempUnit)
        UnitAddAbilityBJ(FourCC('A08U'), udg_TempUnit)
        TriggerSleepAction(15.00)
        udg_TempUnit = a
        UnitRemoveAbilityBJ(FourCC('A08U'), udg_TempUnit)
        UnitAddAbilityBJ(FourCC('A08T'), udg_TempUnit)
    end

    --===========================================================================
    gg_trg_RollingThunder = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RollingThunder, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_RollingThunder, Condition(Trig_RollingThunder_Conditions))
    TriggerAddAction(gg_trg_RollingThunder, Trig_RollingThunder_Actions)
end)
if Debug then Debug.endFile() end
