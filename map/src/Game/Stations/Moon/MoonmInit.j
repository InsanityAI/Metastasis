function Trig_MoonmInit_Func003A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_MoonRect )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
endfunction

function Trig_MoonmInit_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call ForForce( GetPlayersAll(), function Trig_MoonmInit_Func003A )
    set udg_PlanetRotatePoint = GetRectCenter(gg_rct_Space)
    set udg_All_Dock[41] = gg_dest_DTrx_3136
    set udg_All_Dock[42] = gg_dest_DTrx_3141
    set udg_All_Dock[43] = gg_dest_DTrx_3126
    set udg_All_Dock[44] = gg_dest_DTrx_3131
    set bj_forLoopAIndex = 41
    set bj_forLoopAIndexEnd = 44
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()] )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_MoonmInit takes nothing returns nothing
    set gg_trg_MoonmInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_MoonmInit, function Trig_MoonmInit_Actions )
endfunction

