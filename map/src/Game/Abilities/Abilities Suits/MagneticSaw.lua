if Debug then Debug.beginFile "Game/Abilities/Suits/MagneticSaw" end
OnInit.trig("MagneticSaw", function(require)
    ---@return boolean
    function Trig_MagneticSaw_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A061'))) then
            return false
        end
        return true
    end

    function Trig_MagneticSaw_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        CreateNUnitsAtLoc(1, FourCC('h03N'), GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING)
        SetUnitTimeScalePercent(GetLastCreatedUnit(), 200.00)
        IssueTargetOrderBJ(GetLastCreatedUnit(), "attack", GetSpellTargetUnit())
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_MagneticSaw = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MagneticSaw, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_MagneticSaw, Condition(Trig_MagneticSaw_Conditions))
    TriggerAddAction(gg_trg_MagneticSaw, Trig_MagneticSaw_Actions)
end)
if Debug then Debug.endFile() end
