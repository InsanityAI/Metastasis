if Debug then Debug.beginFile "Game/Abilities/Suits/PolarityPush" end
OnInit.map("PolarityPush", function(require)
    ---@return boolean
    function Trig_PolarityPush_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A0A4'))) then
            return false
        end
        return true
    end

    function Trig_PolarityPush_Actions()
        UnitAddAbilityBJ(FourCC('A097'), GetTriggerUnit())
        UnitRemoveAbilityBJ(FourCC('A0A4'), GetTriggerUnit())
    end

    --===========================================================================
    gg_trg_PolarityPush = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PolarityPush, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_PolarityPush, Condition(Trig_PolarityPush_Conditions))
    TriggerAddAction(gg_trg_PolarityPush, Trig_PolarityPush_Actions)
end)
if Debug then Debug.endFile() end
