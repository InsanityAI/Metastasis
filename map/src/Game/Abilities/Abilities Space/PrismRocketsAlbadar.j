function Trig_PrismRocketsAlbadar_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07L')) then 
        return false 
    endif 
    return true 
endfunction 

function PrismRocketAlbadar_Slide takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local unit l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) 
    local location a = GetUnitLoc(l) 
    local location b = PolarProjectionBJ(a, 80.0, GetUnitFacing(l)) 
    local real c = LoadReal(LS(), GetHandleId(l), StringHash("angle")) 
    if GetLocationZ(b) > GetLocationZ(a) + GetUnitFlyHeight(l) then 
        call KillUnit(l) 
    endif 
    //if IsPointPathable(GetLocationX(b), GetLocationY(b), false) == false then 
    //call KillUnit(l) 
    //endif 
    call SetUnitPositionLoc(l, b) 
    call SetUnitFacing(l, c) 
    call RemoveLocation(b) 
    call RemoveLocation(a) 
    if IsUnitDeadBJ(l) then 
        call PauseTimer(k) 
        call DestroyTimer(k) 
    endif 
endfunction 

function PrismRocketAlbadar_Damage takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    local unit a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) 
    if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul') == 0 and IsUnitAliveBJ(GetTriggerUnit()) and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() then 
        call UnitDamageTarget(a, GetTriggerUnit(), 450, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
        call KillUnit(a) 
        call DestroyTrigger(t) 

    endif 
endfunction 
function PrismRocketAlbadar_Dies takes nothing returns nothing 
    local trigger q = GetTriggeringTrigger() 
    local trigger t = LoadTriggerHandle(LS(), GetHandleId(q), StringHash("t")) 
    local trigger o = LoadTriggerHandle(LS(), GetHandleId(q), StringHash("o")) 
    call FlushChildHashtable(LS(), GetHandleId(GetTriggerUnit())) 
    call FlushChildHashtable(LS(), GetHandleId(q)) 
    call FlushChildHashtable(LS(), GetHandleId(t)) 
    call FlushChildHashtable(LS(), GetHandleId(o)) 
    call DestroyTrigger(q) 
    call DestroyTrigger(t) 
    call DestroyTrigger(o) 
endfunction 

function FirePrismRocketAlbadar takes real x1, real y2, real z1, real angle returns nothing 
    local timer k = CreateTimer() 
    local trigger t = CreateTrigger() 
    local trigger q = CreateTrigger() 
    set udg_TempPoint = Location(x1, y2) 
    set udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint, 160.0, angle) 
    set udg_TempBool = false 
    call CreateNUnitsAtLoc(1, 'e02J', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, angle) 
    call SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"), angle) 
    call TriggerRegisterUnitEvent(q, GetLastCreatedUnit(), EVENT_UNIT_DEATH) 
    call TriggerAddAction(q, function PrismRocketAlbadar_Dies) 
    call SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit()) 
    call RemoveLocation(udg_TempPoint) 
    call TimerStart(k, 0.04, true, function PrismRocketAlbadar_Slide) 
    call TriggerRegisterUnitInRangeSimple(t, 150.0, GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit()) 
    call TriggerAddAction(t, function PrismRocketAlbadar_Damage) 
    call SetUnitPathing(GetLastCreatedUnit(), false) 
endfunction 

function PrismRocketsAlbadar_Fire takes nothing returns nothing 
    local timer t = GetExpiredTimer() 
    local unit b = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) 
    local real x = LoadReal(LS(), GetHandleId(t), StringHash("x")) 
    local real y = LoadReal(LS(), GetHandleId(t), StringHash("y")) 
    local location o = Location(x, y) 
    local location c = PolarProjectionBJ(o, GetRandomReal(0, 300.0), GetRandomDirectionDeg()) 
    local location n = GetUnitLoc(b) 
    local location m = PolarProjectionBJ(n, 80.0, AngleBetweenPoints(c, n)) 
    local real omnomnom = AngleBetweenPoints(m, c) 
    call RemoveLocation(n) 
    set n = null 
    call FirePrismRocketAlbadar(GetLocationX(m), GetLocationY(m), GetLocationZ(o) + 130.0, omnomnom) 
    call RemoveLocation(o) 
    set o = null 
    call RemoveLocation(m) 
    set m = null 
    call RemoveLocation(c) 
    set c = null 
endfunction 

function Trig_PrismRocketsAlbadar_Actions takes nothing returns nothing 
    local timer t = CreateTimer() 
    local unit b = GetSpellAbilityUnit() 
    local location d = GetSpellTargetLoc() 
    local real x = GetLocationX(d) 
    local real y = GetLocationY(d) 
    call RemoveLocation(d) 
    set d = null 
    call SaveTimerHandle(LS(), GetHandleId(b), StringHash("PrismRocket_Timer"), t) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), b) 
    call SaveReal(LS(), GetHandleId(t), StringHash("x"), x) 
    call SaveReal(LS(), GetHandleId(t), StringHash("y"), y) 
    call TimerStart(t, 0.1, true, function PrismRocketsAlbadar_Fire) 
endfunction 

//=========================================================================== 
function InitTrig_PrismRocketsAlbadar takes nothing returns nothing 
    set gg_trg_PrismRocketsAlbadar = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_PrismRocketsAlbadar, EVENT_PLAYER_UNIT_SPELL_CHANNEL) 
    call TriggerAddCondition(gg_trg_PrismRocketsAlbadar, Condition(function Trig_PrismRocketsAlbadar_Conditions)) 
    call TriggerAddAction(gg_trg_PrismRocketsAlbadar, function Trig_PrismRocketsAlbadar_Actions) 
endfunction 

