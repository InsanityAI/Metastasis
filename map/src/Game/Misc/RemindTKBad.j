function Trig_RemindTKBad_Actions takes nothing returns nothing 
    call DisplayTextToForce(GetPlayersAll(), ("|cff008040Never forget, TeamKilling favours the Mutant and Alien!" + "")) 
    call DestroyTrigger(GetTriggeringTrigger()) 
endfunction 

//=========================================================================== 
function InitTrig_RemindTKBad takes nothing returns nothing 
    set gg_trg_RemindTKBad = CreateTrigger() 
    call TriggerRegisterTimerEventSingle(gg_trg_RemindTKBad, 60.00) 
    call TriggerAddAction(gg_trg_RemindTKBad, function Trig_RemindTKBad_Actions) 
endfunction 

