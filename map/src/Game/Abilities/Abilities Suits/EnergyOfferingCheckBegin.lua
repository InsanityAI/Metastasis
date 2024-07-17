if Debug then Debug.beginFile "Game/Abilities/Suits/EnergyOfferingCheckBegin" end
OnInit.trig("EnergyOfferingCheckBegin", function(require)
    ---@return boolean
    function Trig_EnergyOfferingCheckBegin_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A0A3'))) then
            return false
        end
        return true
    end

    function EnergyOfferingCheck_Again()
        local l    = GetExpiredTimer() ---@type timer
        local abil = LoadUnitHandle(LS(), GetHandleId(l), StringHash("unit")) ---@type unit
        local targ = LoadUnitHandle(LS(), GetHandleId(l), StringHash("unit2")) ---@type unit

        --User is out of mana, or target is full mana
        if (GetUnitState(abil, UNIT_STATE_MANA) <= 1 or GetUnitState(targ, UNIT_STATE_MANA) > 99) then
            IssueImmediateOrder(abil, "stop")
        end
    end

    function Trig_EnergyOfferingCheckBegin_Actions()
        local l = CreateTimer() ---@type timer
        SaveTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("EnergyOffering_CheckTimer"), l)
        SaveUnitHandle(LS(), GetHandleId(l), StringHash("unit"), GetSpellAbilityUnit())
        SaveUnitHandle(LS(), GetHandleId(l), StringHash("unit2"), GetSpellTargetUnit())
        TimerStart(l, 0.1, true, EnergyOfferingCheck_Again)
    end

    --===========================================================================
    gg_trg_EnergyOfferingCheckBegin = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_EnergyOfferingCheckBegin, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_EnergyOfferingCheckBegin, Condition(Trig_EnergyOfferingCheckBegin_Conditions))
    TriggerAddAction(gg_trg_EnergyOfferingCheckBegin, Trig_EnergyOfferingCheckBegin_Actions)
end)
if Debug then Debug.endFile() end
