//TESH.scrollpos=3
//TESH.alwaysfold=0
function Trig_RUM_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e01Z' ) ) then
        return false
    endif
    return true
endfunction

function RUM_Finish takes nothing returns nothing
local item v=CreateItem('I01U',0,0)
call RollOutItem(v)
endfunction

function Trig_RUM_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ( gg_unit_h04B_0165, "stop" )
    call CancelProduction()
    call BeginProduction("Raptor Upgrade Module",340,"RUM_Finish")
endfunction

//===========================================================================
function InitTrig_RUM takes nothing returns nothing
    set gg_trg_RUM = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_RUM, EVENT_PLAYER_UNIT_TRAIN_FINISH )
    call TriggerAddCondition( gg_trg_RUM, Condition( function Trig_RUM_Conditions ) )
    call TriggerAddAction( gg_trg_RUM, function Trig_RUM_Actions )
endfunction

