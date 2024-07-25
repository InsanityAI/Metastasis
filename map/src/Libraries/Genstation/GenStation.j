function ConsoleDisable takes unit console returns nothing 
    if HaveSavedHandle(LS(), GetHandleId(console), StringHash("EnterTrigger")) then 
        call DisableTrigger(LoadTriggerHandle(LS(), GetHandleId(console), StringHash("EnterTrigger"))) 
    endif 
    
    call SetUnitOwner(console, Player(PLAYER_NEUTRAL_PASSIVE), true) 
    call SetUnitOwner(LoadUnitHandle(LS(), GetHandleId(console), StringHash("space")), Player(PLAYER_NEUTRAL_PASSIVE), true) 
endfunction 

function ConsoleEnable takes unit console returns nothing 
    if IsUnitAliveBJ(console) then 
        call EnableTrigger(LoadTriggerHandle(LS(), GetHandleId(console), StringHash("EnterTrigger"))) 
    endif 
endfunction 

function ConsoleCleanup takes nothing returns nothing 
    local trigger k = GetTriggeringTrigger() 
    local trigger m = LoadTriggerHandle(LS(), GetHandleId(k), StringHash("EnterTrigger")) 
    local unit console = LoadUnitHandle(LS(), GetHandleId(k), StringHash("console")) 
    local unit space = LoadUnitHandle(LS(), GetHandleId(k), StringHash("space")) 
    local rect consolerect = LoadRectHandle(LS(), GetHandleId(k), StringHash("consolerect")) 
    local unit destroyed = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), GetUnitTypeId(console), GetUnitX(console), GetUnitY(console), GetUnitFacing(console)) 
        
    if IsUnitAliveBJ(space) or space == console then 
        //If the console has no associated space (IE space=console) then we do not check to see if the space is alive before proceeding. 
        call SetUnitX(destroyed, GetUnitX(console)) 
        call SetUnitY(destroyed, GetUnitY(console)) 
        call UnitAddAbility(destroyed, 'Avul') 
        call SetUnitVertexColor(destroyed, 50, 50, 50, 255) 
        call SetUnitOwner(console, Player(PLAYER_NEUTRAL_PASSIVE), false) 
        call SetUnitOwner(space, Player(PLAYER_NEUTRAL_PASSIVE), false) 
        call SaveUnitHandle(LS(), GetHandleId(k), StringHash("console"), destroyed) 
        call SaveUnitHandle(LS(), GetHandleId(m), StringHash("console"), destroyed) 
        call DisableTrigger(k) 
        call DisableTrigger(m) 
        call RemoveUnit(console) 
        call UnitAddAbility(destroyed, 'A06R') 
        call SetUnitLifeBJ(destroyed, 1) 
        call SaveTriggerHandle(LS(), GetHandleId(destroyed), StringHash("console_k"), k) 
        call SaveTriggerHandle(LS(), GetHandleId(destroyed), StringHash("console_m"), m) 
        call TriggerRegisterUnitEvent(k, destroyed, EVENT_UNIT_DEATH) 
    else 
        call RemoveRect(consolerect) 
        call FlushChildHashtable(LS(), GetHandleId(k)) 
        call FlushChildHashtable(LS(), GetHandleId(m)) 
        call DestroyTrigger(GetTriggeringTrigger()) 
        call DestroyTrigger(GetTriggeringTrigger()) 
    endif 
endfunction 

function ConsoleLoopCheck_Child takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local unit console = LoadUnitHandle(LS(), GetHandleId(k), StringHash("console")) 
    local unit space = LoadUnitHandle(LS(), GetHandleId(k), StringHash("space")) 
    local unit r = LoadUnitHandle(LS(), GetHandleId(k), StringHash("r")) 
    local rect consolerect = LoadRectHandle(LS(), GetHandleId(k), StringHash("consolerect")) 
    
    if RectContainsUnit(consolerect, r) == false or r == null or IsUnitDeadBJ(r) or GetOwningPlayer(r) != GetOwningPlayer(console) then 
        call FlushChildHashtable(LS(), GetHandleId(k)) 
        call DestroyTimer(k) 
        
        call SetUnitOwner(console, Player(PLAYER_NEUTRAL_PASSIVE), false) 
        call SetUnitOwner(space, Player(PLAYER_NEUTRAL_PASSIVE), false) 
    endif 
endfunction 

function ConsoleLoopCheck takes unit console, unit r, rect consolerect, unit space returns nothing 
    local timer k = CreateTimer() 
    
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("console"), console) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("space"), space) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("r"), r) 
    call SaveRectHandle(LS(), GetHandleId(k), StringHash("consolerect"), consolerect) 
    call TimerStart(k, 0.3, true, function ConsoleLoopCheck_Child) 
endfunction 

function ConsoleControl takes nothing returns nothing 
    local trigger m = GetTriggeringTrigger() 
    local unit console = LoadUnitHandle(LS(), GetHandleId(m), StringHash("console")) 
    local unit space = LoadUnitHandle(LS(), GetHandleId(m), StringHash("space")) 
    local rect consolerect = LoadRectHandle(LS(), GetHandleId(m), StringHash("consolerect")) 
    local unit r = GetTriggerUnit() 
    local player om = GetOwningPlayer(r) 
    
    if IsUnitIllusion(r) == false and GetOwningPlayer(console) == Player(PLAYER_NEUTRAL_PASSIVE) and GetUnitPointValue(r) != 37 and udg_Blackout == false and SubStringBJ(I2S(GetUnitPointValue(r)), 1, 1) != "1" then 
        call SetUnitOwner(space, om, false) 
        call SetUnitOwner(console, om, false) 
        if om == Player(bj_PLAYER_NEUTRAL_EXTRA) then 
            set om = udg_Parasite 
        endif 
        call DisplayTextToPlayer(om, 0, 0, (GetUnitName(space))) 
        call DisplayTextToPlayer(om, 0, 0, (" |cff00FF00Access Granted|r" + "")) 
        call SelectUnitForPlayerSingle(console, om) 
        call ConsoleLoopCheck(console, r, consolerect, space) 
    endif 
endfunction 

function GenConsole takes unit console, unit space, rect consolerect returns nothing 
    local trigger t = CreateTrigger() 
    local trigger EnterTrigger = CreateTrigger() 
    
    call TriggerRegisterUnitEvent(t, console, EVENT_UNIT_DEATH) 
    //call TriggerRegisterUnitEvent(t,space,EVENT_UNIT_DEATH) 
    call TriggerAddAction(t, function ConsoleCleanup) 
    call TriggerRegisterEnterRectSimple(EnterTrigger, consolerect) 
    call TriggerAddAction(EnterTrigger, function ConsoleControl) 
    call SaveTriggerHandle(LS(), GetHandleId(t), StringHash("EnterTrigger"), EnterTrigger) 
    call SaveRectHandle(LS(), GetHandleId(EnterTrigger), StringHash("consolerect"), consolerect) 
    call SaveUnitHandle(LS(), GetHandleId(EnterTrigger), StringHash("console"), console) 
    call SaveUnitHandle(LS(), GetHandleId(EnterTrigger), StringHash("space"), space) 
    call SaveRectHandle(LS(), GetHandleId(t), StringHash("consolerect"), consolerect) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("console"), console) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("space"), space) 
    call SaveUnitHandle(LS(), GetHandleId(console), StringHash("space"), space) 
    call SaveTriggerHandle(LS(), GetHandleId(console), StringHash("EnterTrigger"), EnterTrigger) 
endfunction 

//=========================================================================== 
function InitTrig_GenStation takes nothing returns nothing 

    //Arbitress 
    call GenConsole(gg_unit_h000_0013, gg_unit_h003_0018, gg_rct_ST1Control) 
    //Kyo 
    call GenConsole(gg_unit_h006_0026, gg_unit_h007_0027, gg_rct_ST3Control) 
    //Niffeh 
    call GenConsole(gg_unit_h00A_0030, gg_unit_h009_0029, gg_rct_ST4Control) 
    //Swaggah 
    call GenConsole(gg_unit_h00Y_0050, gg_unit_h00X_0049, gg_rct_ST5Control) 
    //Niffeh powar 
    call GenConsole(gg_unit_h048_0143, gg_unit_h048_0143, gg_rct_NiffyPowerControl) 
    //Errun assembly 
    call GenConsole(gg_unit_h04B_0165, gg_unit_h04B_0165, gg_rct_AssemblyControl) 

endfunction 

