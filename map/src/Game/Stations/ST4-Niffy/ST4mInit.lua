if Debug then Debug.beginFile "Game/Stations/ST4/ST4Init" end
OnInit.map("ST4Init", function(require)
    function Trig_ST4mInit_Func003A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V1)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V10)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V11)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V15)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V18)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V2)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V24)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V25)
        DestroyFogModifier(GetLastCreatedFogModifier())
        DestroyFogModifier(GetLastCreatedFogModifier())
        DestroyFogModifier(GetLastCreatedFogModifier())
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V3)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V30)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V32)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V4)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V5)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V7)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V8)
        DestroyFogModifier(GetLastCreatedFogModifier())
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V31)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST4V33)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    function Trig_ST4mInit_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        ForForce(GetPlayersAll(), Trig_ST4mInit_Func003A)
        RemoveRect(gg_rct_ST4V1)
        RemoveRect(gg_rct_ST4V10)
        RemoveRect(gg_rct_ST4V11)
        RemoveRect(gg_rct_ST4V15)
        RemoveRect(gg_rct_ST4V18)
        RemoveRect(gg_rct_ST4V2)
        RemoveRect(gg_rct_ST4V24)
        RemoveRect(gg_rct_ST4V25)
        RemoveRect(gg_rct_ST4V3)
        RemoveRect(gg_rct_ST4V30)
        RemoveRect(gg_rct_ST4V31)
        RemoveRect(gg_rct_ST4V32)
        RemoveRect(gg_rct_ST4V33)
        RemoveRect(gg_rct_ST4V4)
        RemoveRect(gg_rct_ST4V5)
        RemoveRect(gg_rct_ST4V7)
        RemoveRect(gg_rct_ST4V8)
        udg_All_Dock[9] = gg_dest_DTrx_1464
        udg_All_Dock[10] = gg_dest_DTrx_1474
        udg_All_Dock[11] = gg_dest_DTrx_1484
        udg_All_Dock[12] = gg_dest_DTrx_1534
        udg_All_Dock[13] = gg_dest_DTrx_1494
        udg_All_Dock[14] = gg_dest_DTrx_1504
        udg_All_Dock[15] = gg_dest_DTrx_1514
        udg_All_Dock[16] = gg_dest_DTrx_1524
        udg_All_Dock[29] = gg_dest_DTrx_2402
        udg_All_Dock[30] = gg_dest_DTrx_2412
        udg_All_Dock[31] = gg_dest_DTrx_2422
        udg_All_Dock[32] = gg_dest_DTrx_2432
        udg_All_Dock[33] = gg_dest_DTrx_2442
        bj_forLoopAIndex = 9
        bj_forLoopAIndexEnd = 16
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()])
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        bj_forLoopAIndex = 29
        bj_forLoopAIndexEnd = 33
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()])
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        SetUnitTimeScalePercent(gg_unit_h04A_0144, 0.00)
        PauseUnitBJ(true, gg_unit_h04A_0144)
    end

    --===========================================================================
    gg_trg_ST4mInit = CreateTrigger()
    TriggerAddAction(gg_trg_ST4mInit, Trig_ST4mInit_Actions)
end)
if Debug then Debug.endFile() end
