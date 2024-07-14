//TESH.scrollpos=0
//TESH.alwaysfold=0


function Trig_GravitationalControl_Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetBuyingUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_GravitationalControl_Actions takes nothing returns nothing
local player d
    if ( Trig_GravitationalControl_Func001C() ) then
        set udg_TempPlayer = udg_Parasite
    else
        set udg_TempPlayer = GetOwningPlayer(GetBuyingUnit())
    endif
    set udg_TempPoint = GetUnitLoc(gg_unit_h03T_0209)
    call CreateNUnitsAtLoc( 1, 'e017', udg_TempPlayer, udg_TempPoint, bj_UNIT_FACING )
    call PanCameraToTimedLocForPlayer( udg_TempPlayer, udg_TempPoint, 0 )
    call RemoveLocation( udg_TempPoint )
    set d=udg_TempPlayer
    call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_TempPlayer )
    call PolledWait(0.01)
    call ForceUIKeyBJ( d, "J" )
endfunction

//===========================================================================
function InitTrig_GravitationalControl takes nothing returns nothing
    set gg_trg_GravitationalControl = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_GravitationalControl, gg_unit_h012_0217, EVENT_UNIT_SELL_ITEM )
 
    call TriggerAddAction( gg_trg_GravitationalControl, function Trig_GravitationalControl_Actions )
endfunction

