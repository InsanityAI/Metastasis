if Debug then Debug.beginFile "Game/PureBugfixes/StalkerRangeRestrictionGroundAttack" end
OnInit.trig("StalkerRangeRestrictionGroundAttack", function(require)
    ---@return boolean
    function Trig_Stalker_Range_Restriction_GroundAttack_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('h01D'))) then
            return false
        end
        if (not (GetIssuedOrderIdBJ() == String2OrderIdBJ("attackground"))) then
            return false
        end
        return true
    end

    function Trig_Stalker_Range_Restriction_GroundAttack_Actions()
        udg_StalkerAttackLocation = GetOrderPointLoc()
        udg_StalkerUnitLocation = GetUnitLoc(GetTriggerUnit())
        udg_StalkerUnit = GetTriggerUnit()
        StartTimerBJ(udg_StalkerAttackTimer, false, 0.00)
    end

    --===========================================================================
    gg_trg_Stalker_Range_Restriction_GroundAttack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Stalker_Range_Restriction_GroundAttack, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    TriggerAddCondition(gg_trg_Stalker_Range_Restriction_GroundAttack,
        Condition(Trig_Stalker_Range_Restriction_GroundAttack_Conditions))
    TriggerAddAction(gg_trg_Stalker_Range_Restriction_GroundAttack, Trig_Stalker_Range_Restriction_GroundAttack_Actions)
end)
if Debug then Debug.endFile() end
