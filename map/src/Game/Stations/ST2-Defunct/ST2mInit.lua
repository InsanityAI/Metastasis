if Debug then Debug.beginFile "Game/Stations/ST2/ST2Init" end
OnInit.map("ST2Init", function(require)
    function Trig_ST2mInit_Func005A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST2V1)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST2V2)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    udg_All_Dock[5] = gg_dest_DTrx_0450
    udg_All_Dock[6] = gg_dest_DTrx_0461
    ForForce(GetPlayersAll(), Trig_ST2mInit_Func005A)
    RemoveRect(gg_rct_ST2V1)
    RemoveRect(gg_rct_ST2V2)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0450)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0461)
end)
if Debug then Debug.endFile() end
