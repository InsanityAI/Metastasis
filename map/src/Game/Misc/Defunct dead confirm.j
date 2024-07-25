function Trig_Defunct_dead_confirm_Actions takes nothing returns nothing 
    set udg_Defunct_Dead = true 
endfunction 

//=========================================================================== 
function InitTrig_Defunct_dead_confirm takes nothing returns nothing 
    set gg_trg_Defunct_dead_confirm = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_Defunct_dead_confirm, gg_unit_h005_0024, EVENT_UNIT_DEATH) 
    call TriggerAddAction(gg_trg_Defunct_dead_confirm, function Trig_Defunct_dead_confirm_Actions) 
endfunction 

