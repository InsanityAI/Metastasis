function Trig_SwarmTraining_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'h01S' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SwarmTraining_Actions takes nothing returns nothing
    call IssueTrainOrderByIdBJ( GetTriggerUnit(), 'h01S' )
endfunction

//===========================================================================
function InitTrig_SwarmTraining takes nothing returns nothing
    set gg_trg_SwarmTraining = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SwarmTraining, EVENT_PLAYER_UNIT_TRAIN_FINISH )
    call TriggerAddCondition( gg_trg_SwarmTraining, Condition( function Trig_SwarmTraining_Conditions ) )
    call TriggerAddAction( gg_trg_SwarmTraining, function Trig_SwarmTraining_Actions )
endfunction

