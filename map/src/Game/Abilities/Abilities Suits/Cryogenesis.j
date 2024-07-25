function Trig_Cryogenesis_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07M')) then 
        return false 
    endif 
    return true 
endfunction 

function Cryogenesis_Slide takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local unit l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) 
    local location a = GetUnitLoc(l) 
    local location b = PolarProjectionBJ(a, 40.0, GetUnitFacing(l)) 
    local real c = LoadReal(LS(), GetHandleId(l), StringHash("angle")) 
    local real x = GetUnitX(l) 
    local real y = GetUnitY(l) 
    local real height = LoadReal(LS(), GetHandleId(k), StringHash("height")) 

    if height <= GetLocationZ(b) then 
        call KillUnit(l) 
    endif 
    call SetUnitFlyHeight(l, height - GetLocationZ(b), 0) 
    call SetUnitX(l, GetLocationX(b)) 
    call SetUnitY(l, GetLocationY(b)) 
    call SetUnitFacing(l, c) 
    call RemoveLocation(b) 
    call RemoveLocation(a) 
    if IsUnitDeadBJ(l) then 
        call PauseTimer(k) 
        call DestroyTimer(k) 
    endif 
endfunction 

function Cryogenesis_Damage takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    local unit a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) 
    local unit m 
    if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul') == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() then 
        call KillUnit(a) 
        set m = CreateUnit(GetOwningPlayer(a), 'e01Q', GetUnitX(a), GetUnitY(a), 0) 
        call UnitAddAbility(m, 'A07N') 
        call IssueTargetOrderBJ(m, "slow", GetTriggerUnit()) 
        call DestroyTrigger(t) 
    endif 
endfunction 

function Cryogenesis_Dies takes nothing returns nothing 
    local unit a = GetTriggerUnit() 
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

function Trig_Cryogenesis_Actions takes nothing returns nothing 
    local timer k = CreateTimer() 
    local trigger t = CreateTrigger() 
    local trigger q = CreateTrigger() 

    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempPoint2 = GetSpellTargetLoc() 
    set udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint, 10.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
    set udg_TempBool = false 
    call CreateNUnitsAtLoc(1, 'e02K', GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint3, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
    call SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"), AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
    call TriggerRegisterUnitEvent(q, GetLastCreatedUnit(), EVENT_UNIT_DEATH) 
    call SetUnitPathing(GetLastCreatedUnit(), false) 
    call TriggerAddAction(q, function Cryogenesis_Dies) 
    call SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t) 
    call SaveReal(LS(), GetHandleId(k), StringHash("height"), GetUnitFlyHeight(GetLastCreatedUnit()) + GetLocationZ(udg_TempPoint3)) 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
    call RemoveLocation(udg_TempPoint3) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit()) 
    call TimerStart(k, 0.04, true, function Cryogenesis_Slide) 
    call TriggerRegisterUnitInRangeSimple(t, 100.0, GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit()) 
    call TriggerAddAction(t, function Cryogenesis_Damage) 
    call SetUnitPathing(GetLastCreatedUnit(), false) 
endfunction 

//=========================================================================== 
function InitTrig_Cryogenesis takes nothing returns nothing 
    set gg_trg_Cryogenesis = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Cryogenesis, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Cryogenesis, Condition(function Trig_Cryogenesis_Conditions)) 
    call TriggerAddAction(gg_trg_Cryogenesis, function Trig_Cryogenesis_Actions) 
endfunction 

