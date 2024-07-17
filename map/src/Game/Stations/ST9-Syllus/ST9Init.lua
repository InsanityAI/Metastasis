if Debug then Debug.beginFile "Game/Stations/ST9/ST9Init" end
OnInit.trig("ST9Init", function(require)
    function Trig_ST9Init_Func002A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V1)
        DestroyFogModifier(GetLastCreatedFogModifier())
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V2)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V3)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V4)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V5)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V6)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V7)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V8)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage1)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage2)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage3)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage4)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage5)
        DestroyFogModifier(GetLastCreatedFogModifier())
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage6)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    function Trig_ST9Init_Func003A()
        BasicAI(GetEnumUnit(), 300, 1000.0)
    end

    function Trig_ST9Init_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        ForForce(GetPlayersAll(), Trig_ST9Init_Func002A)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Cage5), Trig_ST9Init_Func003A)
        udg_TempUnit = gg_unit_h04P_0266
        BasicAI_Murmusk(udg_TempUnit, 160, 700.0)
        udg_All_Dock[47] = gg_dest_DTrx_7022
        udg_All_Dock[48] = gg_dest_DTrx_7025
        udg_All_Dock[49] = gg_dest_DTrx_7023
        udg_All_Dock[50] = gg_dest_DTrx_7024
        udg_All_Dock[51] = gg_dest_DTrx_7020
        udg_All_Dock[52] = gg_dest_DTrx_7021
        bj_forLoopAIndex = 47
        bj_forLoopAIndexEnd = 52
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()])
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        udg_TempUnit = gg_unit_h04I_0012
        GenConsole(udg_TempUnit, udg_TempUnit, gg_rct_ST9Control)
        udg_TempUnit = gg_unit_h04R_0258
        GenConsole(udg_TempUnit, udg_TempUnit, gg_rct_ST9Control2)
    end

    --===========================================================================
    gg_trg_ST9Init = CreateTrigger()
    TriggerAddAction(gg_trg_ST9Init, Trig_ST9Init_Actions)
end)
if Debug then Debug.endFile() end
