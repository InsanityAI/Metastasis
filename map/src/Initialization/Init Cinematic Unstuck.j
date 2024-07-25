function Trig_Init_Cinematic_Unstuck_Actions takes nothing returns nothing 
    call CinematicUnstuckInit() 
endfunction 

//=========================================================================== 
function InitTrig_Init_Cinematic_Unstuck takes nothing returns nothing 
    set gg_trg_Init_Cinematic_Unstuck = CreateTrigger() 
    call TriggerAddAction(gg_trg_Init_Cinematic_Unstuck, function Trig_Init_Cinematic_Unstuck_Actions) 
endfunction 

