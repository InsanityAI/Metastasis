function DoorOpen_Malfunction takes destructable d returns nothing 
    local destructable dp = LoadDestructableHandle(LS(), GetHandleId(d), StringHash("doorpath")) 
    local trigger destroytrigger = LoadTriggerHandle(LS(), GetHandleId(d), StringHash("destroytrigger")) 
    call SaveBoolean(LS(), GetHandleId(d), StringHash("isopen"), true) 
    call SaveReal(LS(), GetHandleId(d), StringHash("life"), GetDestructableLife(d)) 
    call DisableTrigger(destroytrigger) 
    call KillDestructable(d) 
    call EnableTrigger(destroytrigger) 
    call KillDestructable(dp) 
    call SetDestructableAnimationSpeed(d, 0.5) 
    call SetDestructableAnimation(d, "morph") 
endfunction 
function DoorSlam_Knockback takes nothing returns nothing 
    local location a = GetUnitLoc(GetEnumUnit()) 
    local boolean b 
    if udg_TempInt == 1 then 
        //Horizontal door  
        set b = RAbsBJ(GetLocationY(a) -GetLocationY(udg_TempPoint)) < 55.0 
    else 
        //Vertical door  
        set b = RAbsBJ(GetLocationX(a) -GetLocationX(udg_TempPoint)) < 55.0 
    endif 
    if b then 
        if GetUnitState(GetEnumUnit(), UNIT_STATE_LIFE) <= 175.0 then 
            call SetUnitState(GetEnumUnit(), UNIT_STATE_LIFE, 1.0) 
        else 
            call UnitDamageTarget(udg_TheNullUnit, GetEnumUnit(), 225.0, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
        endif 
        call Push2(GetEnumUnit(), 625.0, 525.0, AngleBetweenPoints(udg_TempPoint, a)) 
        call AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", GetEnumUnit(), "origin") 
        call SFXThreadClean() 
        call RemoveLocation(a) 
    endif 
endfunction 

function DoorClose_Malfunction takes destructable d returns nothing 
    local destructable dp = LoadDestructableHandle(LS(), GetHandleId(d), StringHash("doorpath")) 
    local location o = GetDestructableLoc(d) 
    local group g = GetUnitsInRangeOfLocAll(125.0, o) 
    local boolean isopen = LoadBoolean(LS(), GetHandleId(d), StringHash("isopen")) 
    local real life = LoadReal(LS(), GetHandleId(d), StringHash("life")) 
    if isopen then 
        if life == 0 then 
            set life = GetDestructableMaxLife(d) 
        endif 
        call SaveBoolean(LS(), GetHandleId(d), StringHash("isopen"), false) 
        call SetDestructableAnimationSpeed(d, 2.0) 
        call DestructableRestoreLife(d, GetDestructableMaxLife(d), true) 
        call SetDestructableLife(d, life) 
        call DestructableRestoreLife(dp, GetDestructableMaxLife(dp), true) 
        call SetDestructableAnimation(d, "morph alternate") 
        set udg_TempPoint = o 
        call PlaySound3D("Sound\\Units\\Combat\\MetalHeavyBashMetal1.wav", GetLocationX(o), GetLocationY(o)) 
        if(GetDestructableTypeId(d) == 'B000') then 
            set udg_TempInt = 1 
        else 
            set udg_TempInt = 0 
        endif 
        call ForGroup(g, function DoorSlam_Knockback) 
    endif 
    call RemoveLocation(o) 
    call DestroyGroup(g) 
endfunction 

function DoorOpen takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    //local integer clearance = GetHandleInt(t, "clearance")  
    local integer clearance = LoadInteger(LS(), GetHandleId(t), StringHash("clearance")) 
    //local destructable door = GetHandleDestructable(t, "door")  
    local destructable door = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("door")) 
    //local destructable doorpath=GetHandleDestructable(t, "doorpath")  
    local destructable doorpath = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("doorpath")) 
    //local trigger destroytrigger= GetHandleTrigger(t, "destroytrigger")  
    local trigger destroytrigger = LoadTriggerHandle(LS(), GetHandleId(t), StringHash("destroytrigger")) 
    if GetDestructableLife(door) <= 0 then 
        return 
    endif 
    if clearance != 0 then 
        if UnitHasItemOfTypeBJ(GetTriggerUnit(), clearance) or GetUnitTypeId(GetTriggerUnit()) == 'h037' or GetUnitTypeId(GetTriggerUnit()) == 'h039' then 
            //call SetHandleReal(door, "life", GetDestructableLife(door))  
            call SaveReal(LS(), GetHandleId(door), StringHash("life"), GetDestructableLife(door)) 
            //call SetHandleBoolean(door, "isopen", true)  
            call SaveBoolean(LS(), GetHandleId(door), StringHash("isopen"), true) 
            call DisableTrigger(destroytrigger) 
            call KillDestructable(door) 
            call EnableTrigger(destroytrigger) 
            call KillDestructable(doorpath) 
            call SetDestructableAnimation(door, "morph") 
        endif 
    else 
        //call SetHandleBoolean(door, "isopen", true)  
        call SaveBoolean(LS(), GetHandleId(door), StringHash("isopen"), true) 
        //call SetHandleReal(door, "life", GetDestructableLife(door))  
        call SaveReal(LS(), GetHandleId(door), StringHash("life"), GetDestructableLife(door)) 
        call DisableTrigger(destroytrigger) 
        call KillDestructable(door) 
        call EnableTrigger(destroytrigger) 
        call SetDestructableAnimation(door, "morph") 
    endif 
endfunction 

function DoorClose takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    //local rect r=GetHandleRect(t, "rect")  
    local rect r = LoadRectHandle(LS(), GetHandleId(t), StringHash("rect")) 
    //local integer clearance = GetHandleInt(t, "clearance")  
    local integer clearance = LoadInteger(LS(), GetHandleId(t), StringHash("clearance")) 
    //local destructable door = GetHandleDestructable(t, "door")  
    local destructable door = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("door")) 
    //local destructable doorpath=GetHandleDestructable(t, "doorpath")  
    local destructable doorpath = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("doorpath")) 
    //local trigger destroytrigger= GetHandleTrigger(t, "destroytrigger")  
    local trigger destroytrigger = LoadTriggerHandle(LS(), GetHandleId(t), StringHash("destroytrigger")) 
    local group z = GetUnitsInRectAll(r) 
    //local boolean isopen=GetHandleBoolean(door, "isopen")  
    local boolean isopen = LoadBoolean(LS(), GetHandleId(door), StringHash("isopen")) 
    if(CountUnitsInGroup(z) == 0 or udg_TempDoorHack) and isopen then 
        //call SetHandleBoolean(door, "isopen", false)  
        call SaveBoolean(LS(), GetHandleId(door), StringHash("isopen"), false) 
        call DestructableRestoreLife(door, GetDestructableMaxLife(door), true) 
        call SetDestructableLife(door, LoadReal(LS(), GetHandleId(door), StringHash("life"))) 
        call SetDestructableAnimation(door, "morph alternate") 
        if clearance != 0 then 
            call DestructableRestoreLife(doorpath, GetDestructableMaxLife(doorpath), true) 
        endif 
    endif 
endfunction 

function DoorBustDown takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    local destructable door = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("door")) 
    local destructable doorpath = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("doorpath")) 
    local trigger dooropen = LoadTriggerHandle(LS(), GetHandleId(t), StringHash("t1")) 
    local trigger doorclose = LoadTriggerHandle(LS(), GetHandleId(t), StringHash("t2")) 
    call DestroyTimer(LoadTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer"))) 
    call DestroyTimer(LoadTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer2"))) 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call KillDestructable(doorpath) 
    call DestroyTrigger(dooropen) 
    call DestroyTrigger(doorclose) 
endfunction 

function DoorRegisterClearance takes destructable door, integer clearance returns nothing 
    local trigger t = LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t1")) 
    local trigger k = LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t2")) 
    call SaveInteger(LS(), GetHandleId(t), StringHash("clearance"), clearance) 
    call SaveInteger(LS(), GetHandleId(k), StringHash("clearance"), clearance) 
    set udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t2")) 
    set udg_TempDoorHack = true 
    call TriggerExecute(udg_TempTrigger) 
    set udg_TempDoorHack = false 
    if clearance != 0 then 
        call DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")), 999999, true) 
    else 
        call KillDestructable(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath"))) 
    endif 
endfunction 

function RegisterSecurityDoor takes destructable door, rect where, integer clearance returns nothing 
    local trigger t = CreateTrigger() 
    local trigger k = CreateTrigger() 
    local trigger m = CreateTrigger() 
    local destructable doorpath 
    if GetDestructableTypeId(door) == 'B000' then 
        set doorpath = CreateDestructable('B002', GetDestructableX(door), GetDestructableY(door), 0, 1.0, 1) 
    else 
        set doorpath = CreateDestructable('B004', GetDestructableX(door), GetDestructableY(door), 0, 1.0, 1) 
    endif 

    if clearance == 0 then 
        call KillDestructable(doorpath) 
    endif 
    call TriggerRegisterEnterRectSimple(t, where) 
    call TriggerAddAction(t, function DoorOpen) 
    call TriggerRegisterLeaveRectSimple(k, where) 
    call TriggerAddAction(k, function DoorClose) 
    call TriggerRegisterDeathEvent(m, door) 
    call TriggerAddAction(m, function DoorBustDown) 
    call SaveDestructableHandle(LS(), GetHandleId(t), StringHash("door"), door) 
    call SaveDestructableHandle(LS(), GetHandleId(t), StringHash("doorpath"), doorpath) 
    call SaveRectHandle(LS(), GetHandleId(t), StringHash("rect"), where) 
    call SaveInteger(LS(), GetHandleId(t), StringHash("clearance"), clearance) 
    call SaveDestructableHandle(LS(), GetHandleId(door), StringHash("doorpath"), doorpath) 
    //I hate patch 1.24.  
    call SaveDestructableHandle(LS(), GetHandleId(k), StringHash("door"), door) 
    call SaveDestructableHandle(LS(), GetHandleId(k), StringHash("doorpath"), doorpath) 
    call SaveRectHandle(LS(), GetHandleId(k), StringHash("rect"), where) 
    call SaveInteger(LS(), GetHandleId(k), StringHash("clearance"), clearance) 
    call SaveDestructableHandle(LS(), GetHandleId(m), StringHash("door"), door) 
    call SaveDestructableHandle(LS(), GetHandleId(m), StringHash("doorpath"), doorpath) 
    call SaveRectHandle(LS(), GetHandleId(m), StringHash("rect"), where) 
    call SaveInteger(LS(), GetHandleId(m), StringHash("clearance"), clearance) 
    call SaveTriggerHandle(LS(), GetHandleId(m), StringHash("t1"), t) 
    call SaveTriggerHandle(LS(), GetHandleId(m), StringHash("t2"), k) 
    call SaveTriggerHandle(LS(), GetHandleId(door), StringHash("t1"), t) 
    call SaveTriggerHandle(LS(), GetHandleId(door), StringHash("t2"), k) 
    call SaveTriggerHandle(LS(), GetHandleId(t), StringHash("destroytrigger"), m) 
    call SaveTriggerHandle(LS(), GetHandleId(k), StringHash("destroytrigger"), m) 
    call SaveTriggerHandle(LS(), GetHandleId(door), StringHash("destroytrigger"), m) 
endfunction 

function DoorMalfunction_Open takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local destructable d = LoadDestructableHandle(LS(), GetHandleId(k), StringHash("d")) 
    call DoorOpen_Malfunction(d) 
    call TimerStart(k, 2.25, false, function DoorMalfunction_Open) 
endfunction 

function DoorMalfunction_Slam takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local destructable d = LoadDestructableHandle(LS(), GetHandleId(k), StringHash("d")) 
    call DoorClose_Malfunction(d) 
    call TimerStart(k, 2.25, false, function DoorMalfunction_Slam) 
endfunction 

function DoorMalfunction_End takes destructable door returns nothing 
    call EnableTrigger(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t1"))) 
    call EnableTrigger(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t2"))) 
    call DestroyTimer(LoadTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer"))) 
    call DestroyTimer(LoadTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer2"))) 
endfunction 

function DoorMalfunction takes destructable door returns nothing 
    local timer k = CreateTimer() 
    local timer j = CreateTimer() 
    local location o = GetDestructableLoc(door) 
    if LoadInteger(LS(), GetHandleId(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t1"))), StringHash("clearance")) != 0 then 
        call DestroyTimer(k) 
        call DestroyTimer(j) 
        call RemoveLocation(o) 
        return 
    endif 
    call CreateNUnitsAtLoc(1, 'e039', Player(PLAYER_NEUTRAL_PASSIVE), o, bj_UNIT_FACING) 
    call RemoveLocation(o) 
    call DisableTrigger(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t1"))) 
    call DisableTrigger(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t2"))) 
    call SaveTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer"), k) 
    call SaveTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer2"), j) 
    call SaveDestructableHandle(LS(), GetHandleId(k), StringHash("d"), door) 
    call SaveDestructableHandle(LS(), GetHandleId(j), StringHash("d"), door) 
    call SaveReal(LS(), GetHandleId(door), StringHash("life"), GetDestructableLife(door)) 
    call TimerStart(k, 1.75, false, function DoorMalfunction_Slam) 
    call TimerStart(j, 0.25, false, function DoorMalfunction_Open) 
endfunction 

//===========================================================================  
function InitTrig_DoorSys takes nothing returns nothing 
endfunction 

