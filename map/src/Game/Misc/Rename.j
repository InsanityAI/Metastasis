function Trig_Rename_Conditions takes nothing returns boolean 
    if(not(SubStringBJ(GetEventPlayerChatString(), 1, 7) == "-rename")) then 
        return false 
    endif 
    if(not(IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Rename_Actions takes nothing returns nothing 
    local string name = udg_NamePrepension[GetConvertedPlayerId(GetTriggerPlayer())] + SubStringBJ(GetEventPlayerChatString(), 9, 99) 
    call SetPlayerName(GetTriggerPlayer(), name) 
    call StateGrid_SetPlayerName(GetTriggerPlayer(), name) 
endfunction 

//=========================================================================== 
function InitTrig_Rename takes nothing returns nothing 
    set gg_trg_Rename = CreateTrigger() 
    call DisableTrigger(gg_trg_Rename) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(0), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(1), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(2), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(3), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(4), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(5), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(6), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(7), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(8), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(9), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(10), "-rename", false) 
    call TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(11), "-rename", false) 
    call TriggerAddCondition(gg_trg_Rename, Condition(function Trig_Rename_Conditions)) 
    call TriggerAddAction(gg_trg_Rename, function Trig_Rename_Actions) 
endfunction 

