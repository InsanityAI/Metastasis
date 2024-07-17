if Debug then Debug.beginFile "Game/Stations/Moon/MoonInit" end
OnInit.map("MoonInit", function(require)
    function Trig_MoonmInit_Func003A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_MoonRect)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    function Trig_MoonmInit_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        ForForce(GetPlayersAll(), Trig_MoonmInit_Func003A)
        udg_PlanetRotatePoint = GetRectCenter(gg_rct_Space)
        udg_All_Dock[41] = gg_dest_DTrx_3136
        udg_All_Dock[42] = gg_dest_DTrx_3141
        udg_All_Dock[43] = gg_dest_DTrx_3126
        udg_All_Dock[44] = gg_dest_DTrx_3131
        bj_forLoopAIndex = 41
        bj_forLoopAIndexEnd = 44
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()])
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    --===========================================================================
    gg_trg_MoonmInit = CreateTrigger()
    TriggerAddAction(gg_trg_MoonmInit, Trig_MoonmInit_Actions)
end)
if Debug then Debug.endFile() end
