if Debug then Debug.beginFile "Game/Abilities/Alien/TemporalFlux" end
OnInit.trig("TemporalFlux", function(require)
    ---@return boolean
    function Trig_TemporalFlux_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02Z'))) then
            return false
        end
        return true
    end

    function Trig_TemporalFlux_Actions()
        local a = GetSpellTargetUnit() ---@type unit
        local r ---@type item
        UnitRemoveBuffs(a, true, true)
        udg_TempPoint = GetUnitLoc(a)
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        udg_TempUnitType = FourCC('e00T')
        udg_TempReal = 180.00
        ExecuteFunc("AlienRequirementRemove")
        ExecuteFunc("AlienRequirementRestore")
        CreateNUnitsAtLoc(1, FourCC('e000'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        IssueTargetOrderBJ(GetLastCreatedUnit(), "slow", a)
        CreateNUnitsAtLoc(1, FourCC('e000'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING)
        r = UnitAddItemByIdSwapped(FourCC('I014'), GetLastCreatedUnit())
        UnitUseItemTarget(GetLastCreatedUnit(), r, GetSpellTargetUnit())

        RemoveLocation(udg_TempPoint)
        PolledWait(1)
        RemoveItem(r)
        UnitAddAbilityBJ(FourCC('Avul'), a)
        PolledWait(35.00)
        UnitRemoveAbilityBJ(FourCC('Avul'), a)
    end

    --===========================================================================
    gg_trg_TemporalFlux = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_TemporalFlux, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_TemporalFlux, Condition(Trig_TemporalFlux_Conditions))
    TriggerAddAction(gg_trg_TemporalFlux, Trig_TemporalFlux_Actions)
end)
if Debug then Debug.endFile() end
