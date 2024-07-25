function Trig_PlayerDeathText_Conditions takes nothing returns boolean 
    if(not(IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) == true)) then 
        return false 
    endif 
    if(not(GetTriggerPlayer() != udg_HiddenAndroid)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerDeathText_Func015Func001C takes nothing returns boolean 
    if(not(GetEnumPlayer() != udg_HiddenAndroid)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerDeathText_Func015A takes nothing returns nothing 
    if(Trig_PlayerDeathText_Func015Func001C()) then 
        set udg_TempString = "|cffffcc00" + udg_OriginalName[GetConvertedPlayerId(GetTriggerPlayer())] + "|r: " + GetEventPlayerChatString() 
        call DisplayTextToPlayer(GetEnumPlayer(), 0, 0, udg_TempString) 
    else 
    endif 
endfunction 

function Trig_PlayerDeathText_Actions takes nothing returns nothing 
    call ForForce(udg_DeadGroup, function Trig_PlayerDeathText_Func015A) 
endfunction 

//=========================================================================== 
function InitTrig_PlayerDeathText takes nothing returns nothing 
    set gg_trg_PlayerDeathText = CreateTrigger() 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(0), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(1), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(2), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(3), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(4), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(5), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(6), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(7), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(8), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(9), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(10), "", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(11), "", false) 
    call TriggerAddCondition(gg_trg_PlayerDeathText, Condition(function Trig_PlayerDeathText_Conditions)) 
    call TriggerAddAction(gg_trg_PlayerDeathText, function Trig_PlayerDeathText_Actions) 
endfunction 

