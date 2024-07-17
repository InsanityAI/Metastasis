if Debug then Debug.beginFile "Game/Abilities/Items/PhaseCloak" end
OnInit.trig("PhaseCloak", function(require)
    ---@return boolean
    function Trig_Phase_Cloak_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I025'))) then
            return false
        end
        return true
    end

    function Trig_Phase_Cloak_Actions()
        UnitAddAbilityForPeriod(GetManipulatingUnit(), FourCC('A08D'), 5.0)
    end

    --===========================================================================
    gg_trg_Phase_Cloak = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Phase_Cloak, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Phase_Cloak, Condition(Trig_Phase_Cloak_Conditions))
    TriggerAddAction(gg_trg_Phase_Cloak, Trig_Phase_Cloak_Actions)
end)
if Debug then Debug.endFile() end
