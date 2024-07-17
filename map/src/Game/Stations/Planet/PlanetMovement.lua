if Debug then Debug.beginFile "Game/Stations/Planet/PlanetMovement" end
OnInit.trig("PlanetMovement", function(require)
    ---@return boolean
    function Trig_PlanetMovement_Conditions()
        if (not (UnitHasBuffBJ(gg_unit_h008_0196, FourCC('B000')) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlanetMovement_Func003C()
        if (not (udg_PlanetAngle >= 360.00)) then
            return false
        end
        return true
    end

    function Trig_PlanetMovement_Actions()
        if (Trig_PlanetMovement_Func003C()) then
            udg_PlanetAngle = 0.00
        else
        end
        udg_PlanetAngle = (udg_PlanetAngle + 0.02)
        udg_PlanetTempPoint = PolarProjectionBJ(udg_PlanetRotatePoint, 2300.00, udg_PlanetAngle)
        SetUnitPositionLoc(gg_unit_h008_0196, udg_PlanetTempPoint)
        RemoveLocation(udg_PlanetTempPoint)
    end

    --===========================================================================
    gg_trg_PlanetMovement = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_PlanetMovement, 0.08)
    TriggerAddCondition(gg_trg_PlanetMovement, Condition(Trig_PlanetMovement_Conditions))
    TriggerAddAction(gg_trg_PlanetMovement, Trig_PlanetMovement_Actions)
end)
if Debug then Debug.endFile() end
