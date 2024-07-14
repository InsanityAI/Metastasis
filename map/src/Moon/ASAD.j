//TESH.scrollpos=15
//TESH.alwaysfold=0
function Trig_ASAD_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e01W' ) ) then
        return false
    endif
    return true
endfunction

function ASAD_Finish takes nothing returns nothing
local item v=CreateItem('I01S',0,0)
call RollOutItem(v)
endfunction

function Trig_ASAD_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ( gg_unit_h04B_0165, "stop" )
    call CancelProduction()
    call BeginProduction("Arbitress Scan Augmentation Device",300,"ASAD_Finish")
endfunction

//===========================================================================
function InitTrig_ASAD takes nothing returns nothing
    set gg_trg_ASAD = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ASAD, EVENT_PLAYER_UNIT_TRAIN_FINISH )
    call TriggerAddCondition( gg_trg_ASAD, Condition( function Trig_ASAD_Conditions ) )
    call TriggerAddAction( gg_trg_ASAD, function Trig_ASAD_Actions )
endfunction

