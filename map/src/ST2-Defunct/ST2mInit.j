function Trig_ST2mInit_Func005A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST2V1 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST2V2 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
endfunction

function Trig_ST2mInit_Actions takes nothing returns nothing
       call DestroyTrigger( GetTriggeringTrigger() )
    set udg_All_Dock[5] = gg_dest_DTrx_0450
    set udg_All_Dock[6] = gg_dest_DTrx_0461
    call ForForce( GetPlayersAll(), function Trig_ST2mInit_Func005A )
    call RemoveRect( gg_rct_ST2V1)
    call RemoveRect( gg_rct_ST2V2)
    call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0450 )
    call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0461 )
endfunction

//===========================================================================
function InitTrig_ST2mInit takes nothing returns nothing
    set gg_trg_ST2mInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_ST2mInit, function Trig_ST2mInit_Actions )
endfunction

