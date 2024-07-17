if Debug then Debug.beginFile "Game/Abilities/Suits/EnergyShift" end
OnInit.trig("EnergyShift", function(require)
    ---@return boolean
    function Trig_EnergyShift_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('h04M'))) then
            return false
        end
        if (not (GetSpellAbilityId() == FourCC('A0A7'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_EnergyShift_Func005C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A07X'), GetTriggerUnit()) == 1)) then
            return false
        end
        return true
    end

    function Trig_EnergyShift_Actions()
        IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
        if (Trig_EnergyShift_Func005C()) then
            UnitRemoveAbilityBJ(FourCC('A07X'), GetTriggerUnit())
            UnitAddAbilityBJ(FourCC('A0A3'), GetTriggerUnit())
        else
            UnitRemoveAbilityBJ(FourCC('A0A3'), GetTriggerUnit())
            UnitAddAbilityBJ(FourCC('A07X'), GetTriggerUnit())
        end
    end

    --===========================================================================
    gg_trg_EnergyShift = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_EnergyShift, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_EnergyShift, Condition(Trig_EnergyShift_Conditions))
    TriggerAddAction(gg_trg_EnergyShift, Trig_EnergyShift_Actions)
end)
if Debug then Debug.endFile() end
