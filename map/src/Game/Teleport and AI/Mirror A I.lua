if Debug then Debug.beginFile "Game/TeleportAndAI/MirrorAI" end
OnInit.map("MirrorAI", function(require)
    ---@return boolean
    function Trig_Mirror_A_I_Func005Func002Func001Func003C()
        if (not (GetItemTypeId(udg_TempItem) == FourCC('I01D'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mirror_A_I_Func005Func002Func001C()
        return true
    end

    ---@return boolean
    function Trig_Mirror_A_I_Func005Func002Func002Func003C()
        if (not (DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()), GetOrderPointLoc()) >= 300.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mirror_A_I_Func005Func002Func002Func004Func003C()
        if (not (UnitItemInSlotBJ(GetEnumUnit(), udg_TempInt2) == nil)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mirror_A_I_Func005Func002Func002Func004C()
        if (not (udg_TempInt2 == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mirror_A_I_Func005Func002Func002C()
        if (not (udg_TempInt2 == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mirror_A_I_Func005Func002C()
        if (not (udg_TempInt2 == 1)) then
            return false
        end
        return true
    end

    function Trig_Mirror_A_I_Func005A()
        udg_TempInt2 = GetRandomInt(1, 5)
        if (Trig_Mirror_A_I_Func005Func002C()) then
            if (Trig_Mirror_A_I_Func005Func002Func001C()) then
                IssueImmediateOrderBJ(GetEnumUnit(), "stop")
                IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit)
            else
                udg_TempInt = GetRandomInt(1, 6)
                udg_TempItem = UnitItemInSlotBJ(GetEnumUnit(), udg_TempInt)
                if (Trig_Mirror_A_I_Func005Func002Func001Func003C()) then
                    IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit)
                else
                    UnitUseItemTarget(GetEnumUnit(), udg_TempItem, udg_TempUnit)
                end
            end
        else
            if (Trig_Mirror_A_I_Func005Func002Func002C()) then
                udg_TempInt2 = GetRandomInt(1, 6)
                UnitUseItemPointLoc(GetEnumUnit(), UnitItemInSlotBJ(GetEnumUnit(), udg_TempInt2),
                    GetUnitLoc(udg_TempUnit))
                if (Trig_Mirror_A_I_Func005Func002Func002Func003C()) then
                    IssueImmediateOrderBJ(GetEnumUnit(), "stop")
                    IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit)
                else
                end
            else
                if (Trig_Mirror_A_I_Func005Func002Func002Func004C()) then
                    udg_TempInt2 = GetRandomInt(1, 6)
                    if (Trig_Mirror_A_I_Func005Func002Func002Func004Func003C()) then
                        IssueImmediateOrderBJ(GetEnumUnit(), "stop")
                        IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit)
                    else
                        UnitUseItem(GetEnumUnit(), UnitItemInSlotBJ(GetEnumUnit(), udg_TempInt2))
                    end
                else
                    IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit)
                end
            end
        end
    end

    function Trig_Mirror_A_I_Actions()
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Mirror_Arena)
        GroupRemoveGroup(GetUnitsInRectOfPlayer(gg_rct_Mirror_Arena, Player(PLAYER_NEUTRAL_PASSIVE)), udg_TempUnitGroup)
        udg_TempUnit = GroupPickRandomUnit(udg_TempUnitGroup)
        ForGroupBJ(udg_Mirror_Hostilegroup, Trig_Mirror_A_I_Func005A)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_Mirror_A_I = CreateTrigger()
    DisableTrigger(gg_trg_Mirror_A_I)
    TriggerRegisterTimerEventPeriodic(gg_trg_Mirror_A_I, 1.10)
    TriggerAddAction(gg_trg_Mirror_A_I, Trig_Mirror_A_I_Actions)
end)
if Debug then Debug.endFile() end
