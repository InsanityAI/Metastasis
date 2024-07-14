//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_ATM_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e01X' ) ) then
        return false
    endif
    return true
endfunction

function ATM_Finish takes nothing returns nothing
local item v=CreateItem('I01T',0,0)
call RollOutItem(v)
endfunction

function Trig_ATM_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ( gg_unit_h04B_0165, "stop" )
    call CancelProduction()
    call BeginProduction("Antimatter Teleportation Matrix",700,"ATM_Finish")
endfunction

//===========================================================================
function InitTrig_ATM takes nothing returns nothing
    set gg_trg_ATM = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ATM, EVENT_PLAYER_UNIT_TRAIN_FINISH )
    call TriggerAddCondition( gg_trg_ATM, Condition( function Trig_ATM_Conditions ) )
    call TriggerAddAction( gg_trg_ATM, function Trig_ATM_Actions )
endfunction

