function Trig_PlanetmInit_Func003A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Planet) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
endfunction 

function Trig_PlanetmInit_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call ForForce(GetPlayersAll(), function Trig_PlanetmInit_Func003A) 
    set udg_PlanetRotatePoint = GetRectCenter(gg_rct_Space) 
    set udg_All_Dock[21] = gg_dest_DTrx_1992 
    set udg_All_Dock[22] = gg_dest_DTrx_1993 
    set udg_All_Dock[23] = gg_dest_DTrx_1994 
    set udg_All_Dock[24] = gg_dest_DTrx_1995 
    set udg_All_Dock[35] = gg_dest_DTrx_1991 
    set udg_All_Dock[36] = gg_dest_DTrx_1997 
    set udg_All_Dock[37] = gg_dest_DTrx_1998 
    set udg_All_Dock[38] = gg_dest_DTrx_1996 
    set bj_forLoopAIndex = 21 
    set bj_forLoopAIndexEnd = 24 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()]) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    set bj_forLoopAIndex = 35 
    set bj_forLoopAIndexEnd = 38 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()]) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
endfunction 

//=========================================================================== 
function InitTrig_PlanetmInit takes nothing returns nothing 
    set gg_trg_PlanetmInit = CreateTrigger() 
    call TriggerAddAction(gg_trg_PlanetmInit, function Trig_PlanetmInit_Actions) 
endfunction 

