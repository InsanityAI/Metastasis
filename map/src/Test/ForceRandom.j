function Trig_ForceRandom_Conditions takes nothing returns boolean 
    if(not(udg_TESTING == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ForceRandom_Actions takes nothing returns nothing 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1290") 
    call TriggerExecute(udg_RandomEvent_Trigger[S2I(SubStringBJ(GetEventPlayerChatString(), 13, 999))]) 
endfunction 

//=========================================================================== 
function InitTrig_ForceRandom takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_ForceRandom = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_ForceRandom, Player(i), "-forcerandom ", false) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_ForceRandom, Condition(function Trig_ForceRandom_Conditions)) 
    call TriggerAddAction(gg_trg_ForceRandom, function Trig_ForceRandom_Actions) 
endfunction 

