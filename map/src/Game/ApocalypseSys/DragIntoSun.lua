if Debug then Debug.beginFile "Game/ApocalypseSys/DragIntoSun" end
OnInit.trig("DragIntoSun", function(require)
    ---@return boolean
    function Trig_DragIntoSun_Func003Func001Func003Func001C()
        if ((udg_TempBool == true)) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h031'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h032'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02P'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_DragIntoSun_Func003Func001Func003C()
        if (not Trig_DragIntoSun_Func003Func001Func003Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_DragIntoSun_Func003Func001C()
        if (not (GetEnumUnit() ~= udg_TempUnit)) then
            return false
        end
        return true
    end

    function Trig_DragIntoSun_Func003A()
        if (Trig_DragIntoSun_Func003Func001C()) then
            udg_TempBool = IsUnitExplorer(GetEnumUnit())
            udg_TempReal = AngleBetweenUnits(GetEnumUnit(), gg_unit_h01A_0197)
            if (Trig_DragIntoSun_Func003Func001Func003C()) then
                SetUnitX(GetEnumUnit(),
                    GetUnitX(GetEnumUnit()) + CosBJ(udg_TempReal) * (GetUnitMoveSpeed(GetEnumUnit()) + 15) / 25)
                SetUnitY(GetEnumUnit(),
                    GetUnitY(GetEnumUnit()) + SinBJ(udg_TempReal) * (GetUnitMoveSpeed(GetEnumUnit()) + 15) / 25)
            else
                udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
                udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 1.00, udg_TempReal)
                SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint)
                RemoveLocation(udg_TempPoint)
                RemoveLocation(udg_TempPoint2)
            end
        else
        end
    end

    function Trig_DragIntoSun_Actions()
        udg_TempUnit = gg_unit_h01A_0197
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Space), Trig_DragIntoSun_Func003A)
    end

    --===========================================================================
    gg_trg_DragIntoSun = CreateTrigger()
    DisableTrigger(gg_trg_DragIntoSun)
    TriggerRegisterTimerEventPeriodic(gg_trg_DragIntoSun, 0.04)
    TriggerAddAction(gg_trg_DragIntoSun, Trig_DragIntoSun_Actions)
end)
if Debug then Debug.endFile() end
