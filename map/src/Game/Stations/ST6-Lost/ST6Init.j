function Trig_ST6Init_Func003A takes nothing returns nothing 
    call SetUnitAnimation(GetEnumUnit(), "death") 
endfunction 

function Trig_ST6Init_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call ForGroupBJ(GetUnitsInRectAll(gg_rct_LostStation), function Trig_ST6Init_Func003A) 
    set udg_All_Dock[25] = gg_dest_DTrx_9308 
    set udg_All_Dock[26] = gg_dest_DTrx_9425 
    set bj_forLoopAIndex = 25 
    set bj_forLoopAIndexEnd = 26 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()]) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
endfunction 

//=========================================================================== 
function InitTrig_ST6Init takes nothing returns nothing 
    set gg_trg_ST6Init = CreateTrigger() 
    call TriggerAddAction(gg_trg_ST6Init, function Trig_ST6Init_Actions) 
endfunction 

