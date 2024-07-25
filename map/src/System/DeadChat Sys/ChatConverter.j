globals 
    multiboard ChatBoard 
    string array ChatLog 
    integer RowOn = 1 
endglobals 

function ChatConverter takes nothing returns nothing 
    local player p = GetTriggerPlayer() 
    local string s = GetEventPlayerChatString() 
    local integer maxrow = 39 
    local integer r = RowOn 
    local integer i = 1 
    if IsPlayerInForce(p, udg_DeadGroup) and SubString(s, 0, 1) != "-" then 
        if RowOn > maxrow then 
            set RowOn = maxrow 
            loop 
                exitwhen i > maxrow 
                set ChatLog[i - 1] = ChatLog[i] 
                set i = i + 1 
            endloop 
     
        endif 
        set ChatLog[RowOn] = "|cffFF8000" + udg_OriginalName[GetConvertedPlayerId(p)] + "|r: " + s 
        set i = 1 
        loop 
            exitwhen i > RowOn 
            call MultiboardSetItemValueBJ(ChatBoard, 1, i, ChatLog[i]) 
            set i = i + 1 
        endloop 
        set RowOn = RowOn + 1 
    endif 
endfunction 

function InitChatSystem takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    set ChatBoard = CreateMultiboardBJ(1, 40, "Dead Player Chat") 
    call MultiboardSetItemWidthBJ(ChatBoard, 1, 0, 100.00) 
    call MultiboardSetItemStyleBJ(ChatBoard, 1, 0, true, false) 
    call MultiboardDisplay(ChatBoard, false) 
endfunction 
//===========================================================================  
function InitTrig_ChatConverter takes nothing returns nothing 
    local integer i = 0 
    local trigger t = CreateTrigger() 
    call TriggerAddAction(t, function InitChatSystem) 
    call TriggerRegisterTimerEvent(t, 0.0, false) 
    set gg_trg_ChatConverter = CreateTrigger() 
    loop 
        exitwhen i > 11 
        if GetPlayerController(Player(i)) == MAP_CONTROL_USER then 
            call TriggerRegisterPlayerChatEvent(gg_trg_ChatConverter, Player(i), "", false) 
        endif 
        set i = i + 1 
    endloop 
    call TriggerAddAction(gg_trg_ChatConverter, function ChatConverter) 

endfunction 

