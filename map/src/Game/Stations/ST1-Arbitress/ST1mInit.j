function Trig_ST1mInit_Func007A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_STV1) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_STV2) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_STV3) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_STV4) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_STV5) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_STV6) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_STV7) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST1V8) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST1V9) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
endfunction 

function Trig_ST1mInit_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    set udg_All_Dock[1] = gg_dest_DTrx_0232 
    set udg_All_Dock[2] = gg_dest_DTrx_0243 
    set udg_All_Dock[3] = gg_dest_DTrx_0235 
    set udg_All_Dock[4] = gg_dest_DTrx_0257 
    call ForForce(GetPlayersAll(), function Trig_ST1mInit_Func007A) 
    call RemoveRect(gg_rct_STV1) 
    call RemoveRect(gg_rct_STV2) 
    call RemoveRect(gg_rct_STV3) 
    call RemoveRect(gg_rct_STV4) 
    call RemoveRect(gg_rct_STV5) 
    call RemoveRect(gg_rct_STV6) 
    call RemoveRect(gg_rct_STV7) 
    call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0232) 
    call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0243) 
    call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0235) 
    call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0257) 
    call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642) 
endfunction 

//=========================================================================== 
function InitTrig_ST1mInit takes nothing returns nothing 
    set gg_trg_ST1mInit = CreateTrigger() 
    call TriggerAddAction(gg_trg_ST1mInit, function Trig_ST1mInit_Actions) 
endfunction 

