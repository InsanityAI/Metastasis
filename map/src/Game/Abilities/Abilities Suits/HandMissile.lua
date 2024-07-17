if Debug then Debug.beginFile "Game/Abilities/Suits/HandMissile" end
OnInit.trig("HandMissile", function(require)
    ---@return boolean
    function Trig_HandMissile_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A00A'))) then
            return false
        end
        return true
    end

    function Trig_HandMissile_Actions()
        udg_TempPoint = GetUnitLoc(GetTriggerUnit())
        CreateNUnitsAtLoc(1, FourCC('e000'), GetOwningPlayer(GetTriggerUnit()), udg_TempPoint,
            GetUnitFacing(GetTriggerUnit()))
        RemoveLocation(udg_TempPoint)
        udg_TempPoint = GetSpellTargetLoc()
        IssuePointOrderLocBJ(GetLastCreatedUnit(), "clusterrockets", udg_TempPoint)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_HandMissile = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_HandMissile, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_HandMissile, Condition(Trig_HandMissile_Conditions))
    TriggerAddAction(gg_trg_HandMissile, Trig_HandMissile_Actions)
end)
if Debug then Debug.endFile() end
