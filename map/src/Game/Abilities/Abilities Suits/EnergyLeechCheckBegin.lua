if Debug then Debug.beginFile "Game/Abilities/Suits/EnergyLeechCheckBegin" end
OnInit.trig("EnergyLeechCheckBegin", function(require)
    ---@return boolean
    function Trig_EnergyLeechCheckBegin_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07X'))) then
            return false
        end
        return true
    end

    function EnergyLeechCheck_Again()
        local l    = GetExpiredTimer() ---@type timer
        local abil = LoadUnitHandle(LS(), GetHandleId(l), StringHash("unit")) ---@type unit
        local targ = LoadUnitHandle(LS(), GetHandleId(l), StringHash("unit2")) ---@type unit

        --Target is out of mana
        if GetUnitState(targ, UNIT_STATE_MANA) <= 1 then
            IssueImmediateOrder(abil, "stop")
        end
    end

    function Trig_EnergyLeechCheckBegin_Actions()
        local l = CreateTimer() ---@type timer
        SaveTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("EnergyLeech_CheckTimer"), l)
        SaveUnitHandle(LS(), GetHandleId(l), StringHash("unit"), GetSpellAbilityUnit())
        SaveUnitHandle(LS(), GetHandleId(l), StringHash("unit2"), GetSpellTargetUnit())
        TimerStart(l, 0.1, true, EnergyLeechCheck_Again)
    end

    --===========================================================================
    gg_trg_EnergyLeechCheckBegin = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_EnergyLeechCheckBegin, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_EnergyLeechCheckBegin, Condition(Trig_EnergyLeechCheckBegin_Conditions))
    TriggerAddAction(gg_trg_EnergyLeechCheckBegin, Trig_EnergyLeechCheckBegin_Actions)
end)
if Debug then Debug.endFile() end
