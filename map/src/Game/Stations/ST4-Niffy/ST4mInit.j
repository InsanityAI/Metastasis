function Trig_ST4mInit_Func003A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V1 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V10 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V11 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V15 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V18 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V2 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V24 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V25 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V3 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V30 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V32 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V4 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V5 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V7 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V8 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V31 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V33 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
endfunction

function Trig_ST4mInit_Actions takes nothing returns nothing
       call DestroyTrigger( GetTriggeringTrigger() )
    call ForForce( GetPlayersAll(), function Trig_ST4mInit_Func003A )
    call RemoveRect( gg_rct_ST4V1)
    call RemoveRect( gg_rct_ST4V10)
    call RemoveRect( gg_rct_ST4V11)
    call RemoveRect( gg_rct_ST4V15)
    call RemoveRect( gg_rct_ST4V18)
    call RemoveRect( gg_rct_ST4V2)
    call RemoveRect( gg_rct_ST4V24)
    call RemoveRect( gg_rct_ST4V25)
    call RemoveRect( gg_rct_ST4V3)
    call RemoveRect( gg_rct_ST4V30)
    call RemoveRect( gg_rct_ST4V31)
    call RemoveRect( gg_rct_ST4V32)
    call RemoveRect( gg_rct_ST4V33)
    call RemoveRect( gg_rct_ST4V4)
    call RemoveRect( gg_rct_ST4V5)
    call RemoveRect( gg_rct_ST4V7)
    call RemoveRect( gg_rct_ST4V8)
    set udg_All_Dock[9] = gg_dest_DTrx_1464
    set udg_All_Dock[10] = gg_dest_DTrx_1474
    set udg_All_Dock[11] = gg_dest_DTrx_1484
    set udg_All_Dock[12] = gg_dest_DTrx_1534
    set udg_All_Dock[13] = gg_dest_DTrx_1494
    set udg_All_Dock[14] = gg_dest_DTrx_1504
    set udg_All_Dock[15] = gg_dest_DTrx_1514
    set udg_All_Dock[16] = gg_dest_DTrx_1524
    set udg_All_Dock[29] = gg_dest_DTrx_2402
    set udg_All_Dock[30] = gg_dest_DTrx_2412
    set udg_All_Dock[31] = gg_dest_DTrx_2422
    set udg_All_Dock[32] = gg_dest_DTrx_2432
    set udg_All_Dock[33] = gg_dest_DTrx_2442
    set bj_forLoopAIndex = 9
    set bj_forLoopAIndexEnd = 16
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()] )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    set bj_forLoopAIndex = 29
    set bj_forLoopAIndexEnd = 33
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()] )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call SetUnitTimeScalePercent( gg_unit_h04A_0144, 0.00 )
    call PauseUnitBJ( true, gg_unit_h04A_0144 )
endfunction

//===========================================================================
function InitTrig_ST4mInit takes nothing returns nothing
    set gg_trg_ST4mInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_ST4mInit, function Trig_ST4mInit_Actions )
endfunction

