if Debug then Debug.beginFile "Game/Stations/ST7/ST7Init" end
OnInit.map("ST7Init", function(require)
    udg_All_Dock[27] = gg_dest_DTrx_9311
    udg_All_Dock[28] = gg_dest_DTrx_9316
    bj_forLoopAIndex = 27
    bj_forLoopAIndexEnd = 28
    while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
        ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()])
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
    udg_All_Dock[45] = gg_dest_DTrx_2150
    udg_All_Dock[46] = gg_dest_DTrx_2156
    bj_forLoopAIndex = 45
    bj_forLoopAIndexEnd = 46
    while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
        ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()])
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
end)
if Debug then Debug.endFile() end
