if Debug then Debug.beginFile "Game/Stations/ST9/ST9Cell2AnomalyFix" end
OnInit.map("ST9Cell2AnomalyFix", function(require)
    ---@return boolean
    function Trig_ST9Cell2AnomalyFix_Func003Func001C()
        if ((RectContainsUnit(gg_rct_FreeAnomalyRect, GetTriggerUnit()) == false)) then
            return true
        end
        if ((IsDestructableDeadBJ(gg_dest_YTab_4371) == false)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_ST9Cell2AnomalyFix_Func003C()
        if (not Trig_ST9Cell2AnomalyFix_Func003Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST9Cell2AnomalyFix_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('n00A'))) then
            return false
        end
        if (not (IsUnitHiddenBJ(GetTriggerUnit()) == false)) then
            return false
        end
        if (not Trig_ST9Cell2AnomalyFix_Func003C()) then
            return false
        end
        return true
    end

    function Trig_ST9Cell2AnomalyFix_Actions()
        udg_TempPoint = GetRectCenter(gg_rct_Cage2)
        SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_ST9Cell2AnomalyFix = CreateTrigger()
    TriggerRegisterLeaveRectSimple(gg_trg_ST9Cell2AnomalyFix, gg_rct_Cage2)
    TriggerAddCondition(gg_trg_ST9Cell2AnomalyFix, Condition(Trig_ST9Cell2AnomalyFix_Conditions))
    TriggerAddAction(gg_trg_ST9Cell2AnomalyFix, Trig_ST9Cell2AnomalyFix_Actions)
end)
if Debug then Debug.endFile() end
