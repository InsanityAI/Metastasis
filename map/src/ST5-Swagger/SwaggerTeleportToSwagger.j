function Trig_SwaggerTeleportToSwagger_Func002C takes nothing returns boolean
    if ( not ( GetUnitPointValue(GetTriggerUnit()) != 37 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SwaggerTeleportToSwagger_Actions takes nothing returns nothing
    if ( Trig_SwaggerTeleportToSwagger_Func002C() ) then
        call DisableTrigger( gg_trg_SwaggerTeleportToPlanet )
        set udg_TempPoint = GetRectCenter(gg_rct_SwaggerLandExit)
        call SetUnitPositionLoc( GetTriggerUnit(), udg_TempPoint )
        call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0 )
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

