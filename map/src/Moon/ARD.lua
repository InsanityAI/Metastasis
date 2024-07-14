//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_ARD_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e022' ) ) then
        return false
    endif
    return true
endfunction

function ARD_Finish takes nothing returns nothing
local item v=CreateItem('I01V',0,0)
call RollOutItem(v)
endfunction

function Trig_ARD_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ( gg_unit_h04B_0165, "stop" )
    call CancelProduction()
    call BeginProduction("Auxiliary Repositioning Drive",600,"ARD_Finish")
endfunction

//===========================================================================
function InitTrig_ARD takes nothing returns nothing
    set gg_trg_ARD = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ARD, EVENT_PLAYER_UNIT_TRAIN_FINISH )
    call TriggerAddCondition( gg_trg_ARD, Condition( function Trig_ARD_Conditions ) )
    call TriggerAddAction( gg_trg_ARD, function Trig_ARD_Actions )
endfunction

