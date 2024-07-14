function Trig_ST4DefenseDrone2Loss_Conditions takes nothing returns boolean
    if ( not ( GetUnitPointValue(GetTriggerUnit()) != 37 ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) != 'h00B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST4DefenseDrone2Loss_Func004C takes nothing returns boolean
    if ( not ( GetOwningPlayer(gg_unit_h00B_0031) == GetOwningPlayer(GetTriggerUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST4DefenseDrone2Loss_Actions takes nothing returns nothing
    if ( Trig_ST4DefenseDrone2Loss_Func004C() ) then
        call SetUnitOwner( gg_unit_h00B_0031, Player(PLAYER_NEUTRAL_PASSIVE), false )
    else
    endif
endfunction

//===========================================================================
function InitTrig_ST4DefenseDrone2Loss takes nothing returns nothing
    set gg_trg_ST4DefenseDrone2Loss = CreateTrigger(  )
    call TriggerRegisterLeaveRectSimple( gg_trg_ST4DefenseDrone2Loss, gg_rct_DD2 )
    call TriggerAddCondition( gg_trg_ST4DefenseDrone2Loss, Condition( function Trig_ST4DefenseDrone2Loss_Conditions ) )
    call TriggerAddAction( gg_trg_ST4DefenseDrone2Loss, function Trig_ST4DefenseDrone2Loss_Actions )
endfunction

