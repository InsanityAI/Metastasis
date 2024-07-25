function Trig_SwaggerTeleportToPlanet_Actions takes nothing returns nothing 
    local player thisPlayer = GetOwningPlayer(GetTriggerUnit()) 
    if GetUnitPointValue(GetTriggerUnit()) != 37 then 
        call DisableTrigger(gg_trg_SwaggerTeleportToSwagger) 
        set udg_TempPoint = GetRectCenter(gg_rct_SwaggerLandEnter) 
        call SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint) 
        if thisPlayer == Player(bj_PLAYER_NEUTRAL_EXTRA) then 
            set thisPlayer = udg_Parasite 
        endif 
        call PanCameraToTimedLocForPlayer(thisPlayer, udg_TempPoint, 0) 
        call CreateNUnitsAtLoc(1, 'e006', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING) 
        call SetUnitScalePercent(GetLastCreatedUnit(), 75.00, 75.00, 75.00) 
        call RemoveLocation(udg_TempPoint) 
        // Necessary, though annoying because without it units would be instantly transported between entry points.  
        call TriggerSleepAction(0.20) 
        call EnableTrigger(gg_trg_SwaggerTeleportToSwagger) 
    else 
    endif 
endfunction 

//===========================================================================  
function InitTrig_SwaggerTeleportToPlanet takes nothing returns nothing 
    set gg_trg_SwaggerTeleportToPlanet = CreateTrigger() 
    call DisableTrigger(gg_trg_SwaggerTeleportToPlanet) 
    call TriggerRegisterEnterRectSimple(gg_trg_SwaggerTeleportToPlanet, gg_rct_SwaggerLandExit) 
    call TriggerAddAction(gg_trg_SwaggerTeleportToPlanet, function Trig_SwaggerTeleportToPlanet_Actions) 
endfunction 

