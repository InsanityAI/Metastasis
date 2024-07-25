function Trig_Clear_Actions takes nothing returns nothing 
    if GetTriggerPlayer() == GetLocalPlayer() then 
        call ClearTextMessages() 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Clear takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_Clear = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_Clear, Player(i), "-clear", true) 
        set i = i + 1 
    endloop 
    call TriggerAddAction(gg_trg_Clear, function Trig_Clear_Actions) 
endfunction