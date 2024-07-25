function Trig_ST5mInit_Func003A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V1) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V10) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V11) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V12) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V13) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V2) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V3) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V4) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V5) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V6) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V7) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V8) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST5V9) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
endfunction 

function Trig_ST5mInit_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call ForForce(GetPlayersAll(), function Trig_ST5mInit_Func003A) 
    call RemoveRect(gg_rct_ST5V1) 
    call RemoveRect(gg_rct_ST5V10) 
    call RemoveRect(gg_rct_ST5V11) 
    call RemoveRect(gg_rct_ST5V12) 
    call RemoveRect(gg_rct_ST5V13) 
    call RemoveRect(gg_rct_ST5V2) 
    call RemoveRect(gg_rct_ST5V3) 
    call RemoveRect(gg_rct_ST5V4) 
    call RemoveRect(gg_rct_ST5V5) 
    call RemoveRect(gg_rct_ST5V6) 
    call RemoveRect(gg_rct_ST5V7) 
    call RemoveRect(gg_rct_ST5V8) 
    call RemoveRect(gg_rct_ST5V9) 
    set udg_All_Dock[17] = gg_dest_DTrx_6090 
    set udg_All_Dock[18] = gg_dest_DTrx_6101 
    set udg_All_Dock[19] = gg_dest_DTrx_6104 
    set udg_All_Dock[20] = gg_dest_DTrx_6115 
    set udg_All_Dock[39] = gg_dest_DTrx_2061 
    set udg_All_Dock[40] = gg_dest_DTrx_2066 
    set bj_forLoopAIndex = 17 
    set bj_forLoopAIndexEnd = 20 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()]) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    set bj_forLoopAIndex = 39 
    set bj_forLoopAIndexEnd = 40 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()]) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call SetUnitTimeScalePercent(gg_unit_h03O_0208, 25.00) 
    call SetUnitVertexColorBJ(gg_unit_h03O_0208, 0.00, 0.00, 0.00, 100.00) 
    call SetUnitVertexColorBJ(gg_unit_e012_0074, 100.00, 100.00, 100.00, 100.00) 
    call SetUnitVertexColorBJ(gg_unit_e012_0092, 100.00, 100.00, 100.00, 100.00) 
endfunction 

//=========================================================================== 
function InitTrig_ST5mInit takes nothing returns nothing 
    set gg_trg_ST5mInit = CreateTrigger() 
    call TriggerAddAction(gg_trg_ST5mInit, function Trig_ST5mInit_Actions) 
endfunction 

