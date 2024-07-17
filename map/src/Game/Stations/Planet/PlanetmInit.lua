if Debug then Debug.beginFile "Game/Stations/Planet/PlanetInit" end
OnInit.map("PlanetInit", function(require)



function Trig_PlanetmInit_Func003A()
    CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Planet )
    DestroyFogModifier( GetLastCreatedFogModifier() )
end

function Trig_PlanetmInit_Actions()
    DestroyTrigger(GetTriggeringTrigger())
    ForForce( GetPlayersAll(), Trig_PlanetmInit_Func003A )
    udg_PlanetRotatePoint = GetRectCenter(gg_rct_Space)
    udg_All_Dock[21] = gg_dest_DTrx_1992
    udg_All_Dock[22] = gg_dest_DTrx_1993
    udg_All_Dock[23] = gg_dest_DTrx_1994
    udg_All_Dock[24] = gg_dest_DTrx_1995
    udg_All_Dock[35] = gg_dest_DTrx_1991
    udg_All_Dock[36] = gg_dest_DTrx_1997
    udg_All_Dock[37] = gg_dest_DTrx_1998
    udg_All_Dock[38] = gg_dest_DTrx_1996
    bj_forLoopAIndex = 21
    bj_forLoopAIndexEnd = 24
    while bj_forLoopAIndex <= bj_forLoopAIndexEnd do 
        ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()] )
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
    bj_forLoopAIndex = 35
    bj_forLoopAIndexEnd = 38
    while bj_forLoopAIndex <= bj_forLoopAIndexEnd do 
        ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()] )
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
end

--===========================================================================
    gg_trg_PlanetmInit = CreateTrigger(  )
    TriggerAddAction( gg_trg_PlanetmInit, Trig_PlanetmInit_Actions )
end)
if Debug then Debug.endFile() end
