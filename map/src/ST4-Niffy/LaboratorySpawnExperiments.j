function Trig_LaboratorySpawnExperiments_Func003C takes nothing returns boolean
    if ( not ( GetRandomInt(0, 1) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_LaboratorySpawnExperiments_Actions takes nothing returns nothing
    set udg_TempPoint = GetRectCenter(gg_rct_ST4EscapePod)
    if ( Trig_LaboratorySpawnExperiments_Func003C() ) then
        call CreateNUnitsAtLoc( 1, 'n000', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    else
        call CreateNUnitsAtLoc( 1, 'n001', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    endif
    call CreateNUnitsAtLoc( 1, 'e006', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_LaboratorySpawnExperiments takes nothing returns nothing
    set gg_trg_LaboratorySpawnExperiments = CreateTrigger(  )
    call DisableTrigger( gg_trg_LaboratorySpawnExperiments )
    call TriggerRegisterTimerEventPeriodic( gg_trg_LaboratorySpawnExperiments, 22.00 )
    call TriggerAddAction( gg_trg_LaboratorySpawnExperiments, function Trig_LaboratorySpawnExperiments_Actions )
endfunction

