if Debug then Debug.beginFile "Game/Misc/PreventOutOfSectorAttack" end
OnInit.map("PreventOutOfSectorAttack", function(require)
    ---@return boolean
    function Trig_PreventOutOfSectorAttack_Conditions()
        if (not (GetIssuedOrderIdBJ() == String2OrderIdBJ("attack"))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PreventOutOfSectorAttack_Func009C()
        if (not (udg_TempBool == false)) then
            return false
        end
        return true
    end

    function Trig_PreventOutOfSectorAttack_Actions()
        udg_TempPoint = GetUnitLoc(GetOrderedUnit())
        udg_TempInt = GetSector(udg_TempPoint)
        RemoveLocation(udg_TempPoint)
        udg_TempPoint = GetUnitLoc(GetOrderTargetUnit())
        udg_TempBool = LocInSector(udg_TempPoint, udg_TempInt)
        RemoveLocation(udg_TempPoint)
        if (Trig_PreventOutOfSectorAttack_Func009C()) then
            udg_TempPoint = GetUnitLoc(GetOrderedUnit())
            IssuePointOrderLocBJ(GetOrderedUnit(), "move", udg_TempPoint)
            RemoveLocation(udg_TempPoint)
        else
        end
    end

    --===========================================================================
    gg_trg_PreventOutOfSectorAttack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PreventOutOfSectorAttack, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    TriggerAddCondition(gg_trg_PreventOutOfSectorAttack, Condition(Trig_PreventOutOfSectorAttack_Conditions))
    TriggerAddAction(gg_trg_PreventOutOfSectorAttack, Trig_PreventOutOfSectorAttack_Actions)
end)
if Debug then Debug.endFile() end
