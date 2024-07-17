if Debug then Debug.beginFile "Game/Stations/ST5/ST5Init" end
OnInit.map("ST5Init", function(require)
    function Trig_ST5mInit_Func003A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V1)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V10)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V11)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V12)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V13)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V2)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V3)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V4)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V5)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V6)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V7)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V8)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V9)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    ForForce(GetPlayersAll(), Trig_ST5mInit_Func003A)
    RemoveRect(gg_rct_ST5V1)
    RemoveRect(gg_rct_ST5V10)
    RemoveRect(gg_rct_ST5V11)
    RemoveRect(gg_rct_ST5V12)
    RemoveRect(gg_rct_ST5V13)
    RemoveRect(gg_rct_ST5V2)
    RemoveRect(gg_rct_ST5V3)
    RemoveRect(gg_rct_ST5V4)
    RemoveRect(gg_rct_ST5V5)
    RemoveRect(gg_rct_ST5V6)
    RemoveRect(gg_rct_ST5V7)
    RemoveRect(gg_rct_ST5V8)
    RemoveRect(gg_rct_ST5V9)
    udg_All_Dock[17] = gg_dest_DTrx_6090
    udg_All_Dock[18] = gg_dest_DTrx_6101
    udg_All_Dock[19] = gg_dest_DTrx_6104
    udg_All_Dock[20] = gg_dest_DTrx_6115
    udg_All_Dock[39] = gg_dest_DTrx_2061
    udg_All_Dock[40] = gg_dest_DTrx_2066
    bj_forLoopAIndex = 17
    bj_forLoopAIndexEnd = 20
    while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
        ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()])
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
    bj_forLoopAIndex = 39
    bj_forLoopAIndexEnd = 40
    while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
        ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()])
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
    SetUnitTimeScalePercent(gg_unit_h03O_0208, 25.00)
    SetUnitVertexColorBJ(gg_unit_h03O_0208, 0.00, 0.00, 0.00, 100.00)
    SetUnitVertexColorBJ(gg_unit_e012_0074, 100.00, 100.00, 100.00, 100.00)
    SetUnitVertexColorBJ(gg_unit_e012_0092, 100.00, 100.00, 100.00, 100.00)
end)
if Debug then Debug.endFile() end
