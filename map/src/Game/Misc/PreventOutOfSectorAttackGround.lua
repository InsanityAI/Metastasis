if Debug then Debug.beginFile "Game/Misc/PreventOutOfSectorAttackGround" end
OnInit.trig("PreventOutOfSectorAttackGround", function(require)
    ---@return boolean
    function Trig_PreventOutOfSectorAttackGround_Conditions()
        if (not (GetIssuedOrderIdBJ() == String2OrderIdBJ("attackground"))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PreventOutOfSectorAttackGround_Func009C()
        if (not (udg_TempBool == false)) then
            return false
        end
        return true
    end

    function Trig_PreventOutOfSectorAttackGround_Actions()
        udg_TempPoint = GetUnitLoc(GetOrderedUnit())
        udg_TempInt = GetSector(udg_TempPoint)
        RemoveLocation(udg_TempPoint)
        udg_TempPoint = GetOrderPointLoc()
        udg_TempBool = LocInSector(udg_TempPoint, udg_TempInt)
        RemoveLocation(udg_TempPoint)
        if (Trig_PreventOutOfSectorAttackGround_Func009C()) then
            udg_TempPoint = GetUnitLoc(GetOrderedUnit())
            IssuePointOrderLocBJ(GetOrderedUnit(), "move", udg_TempPoint)
            RemoveLocation(udg_TempPoint)
        else
        end
    end

    --===========================================================================
    gg_trg_PreventOutOfSectorAttackGround = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PreventOutOfSectorAttackGround, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    TriggerAddCondition(gg_trg_PreventOutOfSectorAttackGround,
        Condition(Trig_PreventOutOfSectorAttackGround_Conditions))
    TriggerAddAction(gg_trg_PreventOutOfSectorAttackGround, Trig_PreventOutOfSectorAttackGround_Actions)
end)
if Debug then Debug.endFile() end
