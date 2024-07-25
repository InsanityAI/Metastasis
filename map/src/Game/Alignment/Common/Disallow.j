function Trig_Disallow_Func013C takes nothing returns boolean 
    if(not(GetTriggerPlayer() == udg_Mutant)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Disallow_Func014C takes nothing returns boolean 
    if(not(GetTriggerPlayer() == udg_Parasite)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Disallow_Actions takes nothing returns nothing 
    if(Trig_Disallow_Func013C()) then 
        set udg_AllowMutantTK = false 
        call EnableTrigger(gg_trg_NoMutantTK) 
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Your spawns may no longer attack you.") 
    else 
    endif 
    if(Trig_Disallow_Func014C()) then 
        set udg_AllowAlienTK = false 
        call EnableTrigger(gg_trg_NoAlienTK) 
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Your spawns may no longer attack you.") 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Disallow takes nothing returns nothing 
    set gg_trg_Disallow = CreateTrigger() 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(0), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(1), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(2), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(3), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(4), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(5), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(6), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(7), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(8), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(9), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(10), "-disallow", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(11), "-disallow", true) 
    call TriggerAddAction(gg_trg_Disallow, function Trig_Disallow_Actions) 
endfunction 

