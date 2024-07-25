function Trig_SpawnApocalypse_Conditions takes nothing returns boolean 
    if(not(udg_TESTING == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SpawnApocalypse_Actions takes nothing returns nothing 
    call TriggerExecute(udg_Apocalypse_Trigger[S2I(SubStringBJ(GetEventPlayerChatString(), 17, 999))]) 
endfunction 

//===========================================================================  
function InitTrig_SpawnApocalypse takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_SpawnApocalypse = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_SpawnApocalypse, Player(i), "-forceapocalypse", false) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_SpawnApocalypse, Condition(function Trig_SpawnApocalypse_Conditions)) 
    call TriggerAddAction(gg_trg_SpawnApocalypse, function Trig_SpawnApocalypse_Actions) 
endfunction 

