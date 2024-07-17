if Debug then Debug.beginFile "Game/Stations/ST6/ST6Init" end
OnInit.map("ST6Init", function(require)
    function Trig_ST6Init_Func003A()
        SetUnitAnimation(GetEnumUnit(), "death")
    end

    function Trig_ST6Init_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        ForGroupBJ(GetUnitsInRectAll(gg_rct_LostStation), Trig_ST6Init_Func003A)
        udg_All_Dock[25] = gg_dest_DTrx_9308
        udg_All_Dock[26] = gg_dest_DTrx_9425
        bj_forLoopAIndex = 25
        bj_forLoopAIndexEnd = 26
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()])
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    --===========================================================================
    gg_trg_ST6Init = CreateTrigger()
    TriggerAddAction(gg_trg_ST6Init, Trig_ST6Init_Actions)
end)
if Debug then Debug.endFile() end
