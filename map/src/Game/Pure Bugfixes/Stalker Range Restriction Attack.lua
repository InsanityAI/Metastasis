if Debug then Debug.beginFile "Game/PureBugfixes/StalkerRangeRestrictionAttack" end
OnInit.trig("StalkerRangeRestrictionAttack", function(require)
    ---@return boolean
    function Trig_Stalker_Range_Restriction_Attack_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('h01D'))) then
            return false
        end
        if (not (GetIssuedOrderIdBJ() == String2OrderIdBJ("attack"))) then
            return false
        end
        return true
    end

    function Trig_Stalker_Range_Restriction_Attack_Actions()
        udg_StalkerAttackLocation = GetUnitLoc(GetOrderTargetUnit())
        udg_StalkerUnitLocation = GetUnitLoc(GetTriggerUnit())
        udg_StalkerUnit = GetTriggerUnit()
        StartTimerBJ(udg_StalkerAttackTimer, false, 0.00)
    end

    --===========================================================================
    gg_trg_Stalker_Range_Restriction_Attack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Stalker_Range_Restriction_Attack, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    TriggerAddCondition(gg_trg_Stalker_Range_Restriction_Attack,
        Condition(Trig_Stalker_Range_Restriction_Attack_Conditions))
    TriggerAddAction(gg_trg_Stalker_Range_Restriction_Attack, Trig_Stalker_Range_Restriction_Attack_Actions)
end)
if Debug then Debug.endFile() end
