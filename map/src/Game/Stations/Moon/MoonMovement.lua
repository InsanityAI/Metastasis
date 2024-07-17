if Debug then Debug.beginFile "Game/Stations/Moon/MoonMovement" end
OnInit.trig("MoonMovement", function(require)
    ---@return boolean
    function Trig_MoonMovement_Conditions()
        if (not (UnitHasBuffBJ(gg_unit_h03T_0209, FourCC('B000')) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MoonMovement_Func003C()
        if (not (udg_MoonAngle >= 360.00)) then
            return false
        end
        return true
    end

    function Trig_MoonMovement_Actions()
        if (Trig_MoonMovement_Func003C()) then
            udg_MoonAngle = 0.00
        else
        end
        udg_MoonAngle = (udg_MoonAngle + 0.06)
        udg_PlanetTempPoint = GetUnitLoc(gg_unit_h008_0196)
        udg_MoonTempPoint = PolarProjectionBJ(udg_PlanetTempPoint, 800.00, udg_MoonAngle)
        SetUnitPositionLoc(gg_unit_h03T_0209, udg_MoonTempPoint)
        RemoveLocation(udg_PlanetTempPoint)
        RemoveLocation(udg_MoonTempPoint)
    end

    --===========================================================================
    gg_trg_MoonMovement = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_MoonMovement, 0.04)
    TriggerAddCondition(gg_trg_MoonMovement, Condition(Trig_MoonMovement_Conditions))
    TriggerAddAction(gg_trg_MoonMovement, Trig_MoonMovement_Actions)
end)
if Debug then Debug.endFile() end
