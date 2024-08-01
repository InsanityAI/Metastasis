function Trig_CommunicationError_Fixed takes nothing returns nothing
    call Timeout.complete()
    call CSAPI_systemMessage("|c00ffcc00System reboot complete. We apologise for any inconvenience.|r")
    set ChatSilence_enabled = true
endfunction

function Trig_CommunicationError_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    set udg_RandomEvent_On[18] = true 
    call TimerStart(udg_RandomEvent, GetRandomReal(240.00, 600.00), false, null) 
    call CSAPI_systemMessage("|cff000000COMMUNICATION ERROR: Your comm device is experiencing a virus. Please standby while we reboot.|r")
    set ChatSilence_enabled = false
    call Timeout.start(60, false, function Trig_CommunicationError_Fixed)
endfunction 

//===========================================================================  
function InitTrig_CommunicationError takes nothing returns nothing 
    set gg_trg_CommunicationError = CreateTrigger() 
    call DisableTrigger(gg_trg_CommunicationError) 
    call TriggerAddAction(gg_trg_CommunicationError, function Trig_CommunicationError_Actions) 
endfunction 

