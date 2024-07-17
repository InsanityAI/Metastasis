if Debug then Debug.beginFile "Game/Stations/ST5/SwaggerTeleportToSwagger" end
OnInit.trig("SwaggerTeleportToSwagger", function(require)
    ---@return boolean
    function Trig_SwaggerTeleportToSwagger_Func002C()
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        return true
    end

    function Trig_SwaggerTeleportToSwagger_Actions()
        if (Trig_SwaggerTeleportToSwagger_Func002C()) then
            DisableTrigger(gg_trg_SwaggerTeleportToPlanet)
            udg_TempPoint = GetRectCenter(gg_rct_SwaggerLandExit)
            SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint)
            PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0)
            CreateNUnitsAtLoc(1, FourCC('e006'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
            SetUnitScalePercent(GetLastCreatedUnit(), 75.00, 75.00, 75.00)
            RemoveLocation(udg_TempPoint)
            TriggerSleepAction(0.20)
            EnableTrigger(gg_trg_SwaggerTeleportToPlanet)
        else
        end
    end

    --===========================================================================
    gg_trg_SwaggerTeleportToSwagger = CreateTrigger()
    DisableTrigger(gg_trg_SwaggerTeleportToSwagger)
    TriggerRegisterEnterRectSimple(gg_trg_SwaggerTeleportToSwagger, gg_rct_SwaggerLandEnter)
    TriggerAddAction(gg_trg_SwaggerTeleportToSwagger, Trig_SwaggerTeleportToSwagger_Actions)
end)
if Debug then Debug.endFile() end
