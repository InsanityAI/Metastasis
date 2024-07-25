function Trig_Allow_Func013C takes nothing returns boolean 
    if(not(GetTriggerPlayer() == udg_Mutant)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Allow_Func014C takes nothing returns boolean 
    if(not(GetTriggerPlayer() == udg_Parasite)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Allow_Actions takes nothing returns nothing 
    if(Trig_Allow_Func013C()) then 
        set udg_AllowMutantTK = true 
        call DisableTrigger(gg_trg_NoMutantTK) 
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Your spawns may now attack you.") 
    else 
    endif 
    if(Trig_Allow_Func014C()) then 
        set udg_AllowAlienTK = true 
        call DisableTrigger(gg_trg_NoAlienTK) 
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Your spawns may now attack you.") 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Allow takes nothing returns nothing 
    set gg_trg_Allow = CreateTrigger() 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(0), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(1), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(2), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(3), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(4), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(5), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(6), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(7), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(8), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(9), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(10), "-allow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(11), "-allow", true) 
    call TriggerAddAction(gg_trg_Allow, function Trig_Allow_Actions) 
endfunction 

