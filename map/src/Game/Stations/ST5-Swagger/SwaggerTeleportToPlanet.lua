if Debug then Debug.beginFile "Game/Stations/ST5/SwaggerTeleportToPlanet" end
OnInit.map("SwaggerTeleportToPlanet", function(require)
    ---@return boolean
    function Trig_SwaggerTeleportToPlanet_Func002C()
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        return true
    end

    function Trig_SwaggerTeleportToPlanet_Actions()
        if (Trig_SwaggerTeleportToPlanet_Func002C()) then
            DisableTrigger(gg_trg_SwaggerTeleportToSwagger)
            udg_TempPoint = GetRectCenter(gg_rct_SwaggerLandEnter)
            SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint)
            PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0)
            CreateNUnitsAtLoc(1, FourCC('e006'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
            SetUnitScalePercent(GetLastCreatedUnit(), 75.00, 75.00, 75.00)
            RemoveLocation(udg_TempPoint)
            -- Necessary, though annoying because without it units would be instantly transported between entry points.
            TriggerSleepAction(0.20)
            EnableTrigger(gg_trg_SwaggerTeleportToSwagger)
        else
        end
    end

    --===========================================================================
    gg_trg_SwaggerTeleportToPlanet = CreateTrigger()
    DisableTrigger(gg_trg_SwaggerTeleportToPlanet)
    TriggerRegisterEnterRectSimple(gg_trg_SwaggerTeleportToPlanet, gg_rct_SwaggerLandExit)
    TriggerAddAction(gg_trg_SwaggerTeleportToPlanet, Trig_SwaggerTeleportToPlanet_Actions)
end)
if Debug then Debug.endFile() end
