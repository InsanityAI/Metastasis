function Trig_Kidot_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07J')) then 
        return false 
    endif 
    return true 
endfunction 

function Kidot_Slide takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local unit l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) 
    local location a = GetUnitLoc(l) 
    local location b = PolarProjectionBJ(a, 20.0, GetUnitFacing(l)) 
    local real c = LoadReal(LS(), GetHandleId(l), StringHash("angle")) 
    local real x = GetUnitX(l) 
    local real y = GetUnitY(l) 
    if GetLocationZ(b) > GetLocationZ(a) + 60.0 then 
        call KillUnit(l) 
    endif 
    if IsPointPathable(GetLocationX(b), GetLocationY(b), false) == false then 
        call KillUnit(l) 
    endif 
    call SetUnitPositionLoc(l, b) 
    call SetUnitFacing(l, c) 
    if x == GetUnitX(l) and y == GetUnitY(l) then 
        call KillUnit(l) 
    endif 
    call RemoveLocation(b) 
    call RemoveLocation(a) 
    if IsUnitDeadBJ(l) then 
        call PauseTimer(k) 
        call DestroyTimer(k) 
    endif 
endfunction 

function Kidot_Damage takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    local unit a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) 
    if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul') == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() then 
        call KillUnit(a) 
        call DestroyTrigger(t) 
    endif 
endfunction 
function Kidot_OrderAngle takes nothing returns nothing 
    local unit rocket = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("unit")) 
    local location a = GetUnitLoc(rocket) 
    local location b = GetOrderPointLoc() 
    local real c = AngleBetweenPoints(a, b) 
    call RemoveLocation(a) 
    call RemoveLocation(b) 
    call SaveReal(LS(), GetHandleId(rocket), StringHash("angle"), c) 
endfunction 

function Kidot_Dies takes nothing returns nothing 
    local unit a = GetTriggerUnit() 
    local trigger q = GetTriggeringTrigger() 
    local trigger t = LoadTriggerHandle(LS(), GetHandleId(q), StringHash("t")) 
    local trigger o = LoadTriggerHandle(LS(), GetHandleId(q), StringHash("o")) 
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e01E', GetUnitX(a), GetUnitY(a), GetRandomDirectionDeg()) 
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e02I', GetUnitX(a), GetUnitY(a), GetRandomDirectionDeg()) 
    call FlushChildHashtable(LS(), GetHandleId(GetTriggerUnit())) 
    call FlushChildHashtable(LS(), GetHandleId(q)) 
    call FlushChildHashtable(LS(), GetHandleId(t)) 
    call FlushChildHashtable(LS(), GetHandleId(o)) 
    call DestroyTrigger(q) 
    call DestroyTrigger(t) 
    call DestroyTrigger(o) 
endfunction 

function Trig_Kidot_Actions takes nothing returns nothing 
    local timer k = CreateTimer() 
    local trigger t = CreateTrigger() 
    local trigger q = CreateTrigger() 

    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempPoint2 = GetSpellTargetLoc() 
    set udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint, 10.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
    set udg_TempBool = false 
    call CreateNUnitsAtLoc(1, 'e02H', GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint3, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
    call SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"), AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
    call TriggerRegisterUnitEvent(q, GetLastCreatedUnit(), EVENT_UNIT_DEATH) 
    call TriggerAddAction(q, function Kidot_Dies) 
    call SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t) 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
    call RemoveLocation(udg_TempPoint3) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit()) 
    call TimerStart(k, 0.04, true, function Kidot_Slide) 
    call TriggerRegisterUnitInRangeSimple(t, 50.0, GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit()) 
    call TriggerAddAction(t, function Kidot_Damage) 
    call SetUnitPathing(GetLastCreatedUnit(), false) 
endfunction 

//=========================================================================== 
function InitTrig_KidotProjection takes nothing returns nothing 
    set gg_trg_KidotProjection = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_KidotProjection, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_KidotProjection, Condition(function Trig_Kidot_Conditions)) 
    call TriggerAddAction(gg_trg_KidotProjection, function Trig_Kidot_Actions) 
endfunction 

