function Trig_SwaggerTeleportToSwagger_Actions takes nothing returns nothing
    local player thisPlayer = GetOwningPlayer(GetTriggerUnit()) 
    if GetUnitPointValue(GetTriggerUnit()) != 37 then
        call DisableTrigger( gg_trg_SwaggerTeleportToPlanet )
        set udg_TempPoint = GetRectCenter(gg_rct_SwaggerLandExit)
        call SetUnitPositionLoc( GetTriggerUnit(), udg_TempPoint )
        if thisPlayer == Player(bj_PLAYER_NEUTRAL_EXTRA) then 
            set thisPlayer = udg_Parasite 
        endif 
        call PanCameraToTimedLocForPlayer(thisPlayer, udg_TempPoint, 0 )
        call CreateNUnitsAtLoc( 1, 'e006', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
        call SetUnitScalePercent( GetLastCreatedUnit(), 75.00, 75.00, 75.00 )
        call RemoveLocation(udg_TempPoint)
        call TriggerSleepAction( 0.20 )
        call EnableTrigger( gg_trg_SwaggerTeleportToPlanet )
    else
    endif
endfunction

//===========================================================================
function InitTrig_SwaggerTeleportToSwagger takes nothing returns nothing
    set gg_trg_SwaggerTeleportToSwagger = CreateTrigger(  )
    call DisableTrigger( gg_trg_SwaggerTeleportToSwagger )
    call TriggerRegisterEnterRectSimple( gg_trg_SwaggerTeleportToSwagger, gg_rct_SwaggerLandEnter )
    call TriggerAddAction( gg_trg_SwaggerTeleportToSwagger, function Trig_SwaggerTeleportToSwagger_Actions )
endfunction

