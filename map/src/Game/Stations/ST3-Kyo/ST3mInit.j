function Trig_ST3mInit_Func006A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V1 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V2 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V3 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V4 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V5 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V6 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
endfunction

function Trig_ST3mInit_Actions takes nothing returns nothing
       call DestroyTrigger( GetTriggeringTrigger() )
    set udg_All_Dock[7] = gg_dest_DTrx_0657
    set udg_All_Dock[8] = gg_dest_DTrx_0668
    set udg_All_Dock[34] = gg_dest_DTrx_0230
    call ForForce( GetPlayersAll(), function Trig_ST3mInit_Func006A )
    call RemoveRect( gg_rct_ST3V1)
    call RemoveRect( gg_rct_ST3V2)
    call RemoveRect( gg_rct_ST3V3)
    call RemoveRect( gg_rct_ST3V4)
    call RemoveRect( gg_rct_ST3V5)
    call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0657 )
    call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0668 )
    call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0230 )
endfunction

//===========================================================================
function InitTrig_ST3mInit takes nothing returns nothing
    set gg_trg_ST3mInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_ST3mInit, function Trig_ST3mInit_Actions )
endfunction

