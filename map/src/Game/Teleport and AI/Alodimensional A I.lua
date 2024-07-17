if Debug then Debug.beginFile "Game/TeleportAndAI/AlodimensionalAI" end
OnInit.map("AlodimensionalAI", function(require)
    function Trig_Alodimensional_A_I_Func002A()
    end

    ---@return boolean
    function Trig_Alodimensional_A_I_Func006C()
        if (not (IsUnitGroupEmptyBJ(GetLastCreatedGroup()) == true)) then
            return false
        end
        return true
    end

    function Trig_Alodimensional_A_I_Actions()
        ForGroupBJ(GetUnitsInRangeOfLocAll(600.00, GetUnitLoc(udg_Extraterrestial_unit)),
            Trig_Alodimensional_A_I_Func002A)
        udg_TempUnitGroup = GetLastCreatedGroup()
        GroupRemoveUnitSimple(udg_Extraterrestial_unit, GetLastCreatedGroup())
        udg_TempPoint = OffsetLocation(GetUnitLoc(udg_Extraterrestial_unit), GetRandomReal(0, 360.00),
            GetRandomReal(0, 360.00))
        if (Trig_Alodimensional_A_I_Func006C()) then
            IssueTargetOrderBJ(udg_Extraterrestial_unit, "attack", GroupPickRandomUnit(udg_TempUnitGroup))
        else
            SetUnitPositionLocFacingLocBJ(udg_Extraterrestial_unit, udg_TempPoint, udg_TempPoint)
        end
        RemoveLocation(udg_TempPoint)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_Alodimensional_A_I = CreateTrigger()
    DisableTrigger(gg_trg_Alodimensional_A_I)
    TriggerRegisterTimerEventPeriodic(gg_trg_Alodimensional_A_I, 6.00)
    TriggerAddAction(gg_trg_Alodimensional_A_I, Trig_Alodimensional_A_I_Actions)
end)
if Debug then Debug.endFile() end
