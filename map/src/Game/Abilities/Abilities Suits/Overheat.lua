if Debug then Debug.beginFile "Game/Abilities/Suits/Overheat" end
OnInit.trig("Overheat", function(require)
    ---@return boolean
    function Trig_Overheat_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A04G'))) then
            return false
        end
        return true
    end

    function Trig_Overheat_Actions()
        local a = GetSpellAbilityUnit() ---@type unit
        local d ---@type unit
        PolledWait(4.00)
        udg_TempPoint = GetUnitLoc(a)
        CreateNUnitsAtLoc(1, FourCC('e00F'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        d = GetLastCreatedUnit()
        RemoveLocation(udg_TempPoint)
        IssueTargetOrderBJ(GetLastCreatedUnit(), "slow", a)

        PolledWait(0.5)
        RemoveUnit(d)
    end

    --===========================================================================
    gg_trg_Overheat = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Overheat, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Overheat, Condition(Trig_Overheat_Conditions))
    TriggerAddAction(gg_trg_Overheat, Trig_Overheat_Actions)
end)
if Debug then Debug.endFile() end
