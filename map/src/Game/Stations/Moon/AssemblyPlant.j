function AP_LoopVisibilityAndTime takes texttag l, string production, real startx, real starty, timer m returns nothing 
    local integer i 
    local integer r = GetHandleId(l) 
    local boolean k = false 
    call SaveBoolean(AP_Hash, r, StringHash("w"), true) 
    loop 
        exitwhen LoadBoolean(AP_Hash, r, StringHash("w")) != true or k 
        set i = 0 
        loop 
            exitwhen i > 11 
            if IsVisibleToPlayer(startx, starty, Player(i)) then 
                if GetLocalPlayer() == Player(i) then 
                    call SetTextTagVisibility(l, true) 
                endif 
            else 
                if GetLocalPlayer() == Player(i) then 
                    call SetTextTagVisibility(l, false) 
                endif 
            endif 
            set i = i + 1 
        endloop 
        call SetTextTagTextBJ(l, production + " (" + I2S(R2I(TimerGetRemaining(m))) + ")", 10.0) 
        if TimerGetRemaining(m) == 0 then 
            set k = true 
        else 
            call PolledWait(0.2) 
        endif 
    endloop 
    call DestroyTextTag(l) 
endfunction 

function DestroyLoopedTextTag takes texttag t returns nothing 
    if t != null then 
        call SaveBoolean(AP_Hash, GetHandleId(t), StringHash("w"), false) 
    endif 
endfunction 

globals 
    integer AssemblyPlant_ProductionNumber = 0 
    trigger AP_HashStore = CreateTrigger() 
    texttag AP_InfoTag = null 
    hashtable AP_Hash = InitHashtable() 
endglobals 

function BLARGH takes nothing returns nothing 
endfunction 
function BeginProduction takes string text, real duration, string ExecuteWhenDone returns nothing 
    local integer ProductionID 
    local location bm = Location(11345.9, -1960) 
    local texttag j = CreateTextTagLocBJ(text, bm, 90.0, 10.0, 50, 100, 100, 0) 
    local timer m = CreateTimer() 
    set AP_InfoTag = j 
    call SetTextTagVisibility(j, true) 
    call RemoveLocation(bm) 
    set bm = null 
    call TimerStart(m, duration, false, function BLARGH) 
    set AssemblyPlant_ProductionNumber = AssemblyPlant_ProductionNumber + 1 
    set ProductionID = AssemblyPlant_ProductionNumber 
    call SaveBoolean(AP_Hash, GetHandleId(AP_HashStore), ProductionID, true) 
    call AP_LoopVisibilityAndTime(j, text, 11345.9, -1960, m) 
    call DestroyTextTag(j) 
    if LoadBoolean(AP_Hash, GetHandleId(AP_HashStore), ProductionID) == true and TimerGetRemaining(m) == 0 then 
        call ExecuteFunc(ExecuteWhenDone) 
    endif 
    call DestroyTimer(m) 
endfunction 

function CancelProduction takes nothing returns nothing 
    call SaveBoolean(AP_Hash, GetHandleId(AP_HashStore), AssemblyPlant_ProductionNumber, false) 
    call DestroyLoopedTextTag(AP_InfoTag) 
endfunction 

function RollOutItem_Slide takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local item j = LoadItemHandle(AP_Hash, GetHandleId(k), StringHash("j")) 
    call SetItemPosition(j, 11074.8, GetItemY(j) -2) 
    if RectContainsItem(j, gg_rct_AssemblyDropoff) then 
        call PauseTimer(k) 
        call FlushChildHashtable(AP_Hash, GetHandleId(k)) 
        call DestroyTimer(k) 
    endif 
endfunction 

function RollOutItem takes item j returns nothing 
    local timer k = CreateTimer() 
    call SetItemPosition(j, 11074.8, -1904) 
    call SaveItemHandle(AP_Hash, GetHandleId(k), StringHash("j"), j) 
    call TimerStart(k, 0.04, true, function RollOutItem_Slide) 
endfunction 
//=========================================================================== 
function InitTrig_AssemblyPlant takes nothing returns nothing 
endfunction 

