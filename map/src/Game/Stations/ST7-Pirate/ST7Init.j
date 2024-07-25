function Trig_ST7Init_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    set udg_All_Dock[27] = gg_dest_DTrx_9311 
    set udg_All_Dock[28] = gg_dest_DTrx_9316 
    set bj_forLoopAIndex = 27 
    set bj_forLoopAIndexEnd = 28 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()]) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    set udg_All_Dock[45] = gg_dest_DTrx_2150 
    set udg_All_Dock[46] = gg_dest_DTrx_2156 
    set bj_forLoopAIndex = 45 
    set bj_forLoopAIndexEnd = 46 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()]) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
endfunction 

//=========================================================================== 
function InitTrig_ST7Init takes nothing returns nothing 
    set gg_trg_ST7Init = CreateTrigger() 
    call TriggerAddAction(gg_trg_ST7Init, function Trig_ST7Init_Actions) 
endfunction 

