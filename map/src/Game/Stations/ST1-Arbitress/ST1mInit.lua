if Debug then Debug.beginFile "Game/Stations/ST1/ST1Init" end
OnInit.map("ST1Init", function(require)
    require "StationRegister"
    udg_All_Dock[1] = gg_dest_DTrx_0232
    udg_All_Dock[2] = gg_dest_DTrx_0243
    udg_All_Dock[3] = gg_dest_DTrx_0235
    udg_All_Dock[4] = gg_dest_DTrx_0257

    -- TODO: these are for all stations and ships...
    StationRegister(gg_rct_STV1, gg_rct_STV2, gg_rct_STV3, gg_rct_STV4, gg_rct_STV5, gg_rct_STV6, gg_rct_STV7,
        gg_rct_ST1V8, gg_rct_ST1V9, gg_rct_SS1,
        gg_rct_SS2,
        gg_rct_SS3,
        gg_rct_SS4,
        gg_rct_SS5,
        gg_rct_SS6,
        gg_rct_SS7,
        gg_rct_SS8,
        gg_rct_SS9,
        gg_rct_SS10,
        gg_rct_SS11,
        gg_rct_SS12P1,
        gg_rct_SS12P2)

    RemoveRect(gg_rct_STV1)
    RemoveRect(gg_rct_STV2)
    RemoveRect(gg_rct_STV3)
    RemoveRect(gg_rct_STV4)
    RemoveRect(gg_rct_STV5)
    RemoveRect(gg_rct_STV6)
    RemoveRect(gg_rct_STV7)
    RemoveRect(gg_rct_SS12P1)
    RemoveRect(gg_rct_SS12P2)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0232)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0243)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0235)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0257)
    ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642)
end)
if Debug then Debug.endFile() end
