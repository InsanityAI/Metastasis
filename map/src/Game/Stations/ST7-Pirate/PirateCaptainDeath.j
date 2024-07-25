function Trig_PirateCaptainDeath_Actions takes nothing returns nothing 
    set udg_SpaceAI_PirateCaptainAlive = false 
    // With this boolean, the AI won't touch the pirate ship 
endfunction 

//=========================================================================== 
function InitTrig_PirateCaptainDeath takes nothing returns nothing 
    set gg_trg_PirateCaptainDeath = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_PirateCaptainDeath, gg_unit_h02C_0124, EVENT_UNIT_DEATH) 
    call TriggerAddAction(gg_trg_PirateCaptainDeath, function Trig_PirateCaptainDeath_Actions) 
endfunction 

