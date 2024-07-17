if Debug then Debug.beginFile "Game/Stations/ST3/ST3Init" end
OnInit.map("ST3Init", function(require)
    function Trig_ST3mInit_Func006A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V1)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V2)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V3)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V4)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V5)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST3V6)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    udg_All_Dock[7] = gg_dest_DTrx_0657
    udg_All_Dock[8] = gg_dest_DTrx_0668
    udg_All_Dock[34] = gg_dest_DTrx_0230
    ForForce(GetPlayersAll(), Trig_ST3mInit_Func006A)
    RemoveRect(gg_rct_ST3V1)
    RemoveRect(gg_rct_ST3V2)
    RemoveRect(gg_rct_ST3V3)
    RemoveRect(gg_rct_ST3V4)
    RemoveRect(gg_rct_ST3V5)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0657)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0668)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0230)
end)
if Debug then Debug.endFile() end
