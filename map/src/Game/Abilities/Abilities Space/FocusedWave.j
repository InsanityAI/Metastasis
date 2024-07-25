function Trig_FocusedWave_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A05D')) then 
        return false 
    endif 
    return true 
endfunction 

function FocusedWave_Slide takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local unit l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) 
    local location a = GetUnitLoc(l) 
    local location b = PolarProjectionBJ(a, 20.0, GetUnitFacing(l)) 
    call RemoveLocation(a) 
    call SetUnitPositionLoc(l, b) 
    call RemoveLocation(b) 
    if IsUnitDeadBJ(l) then 
        call DestroyTrigger(LoadTriggerHandle(LS(), GetHandleId(k), StringHash("trig"))) 
        call PauseTimer(k) 
        call DestroyTimer(k) 
    endif 
endfunction 

function FocusedWave_Damage takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    local unit a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) 
    if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul') == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() then 
        if IsUnitExplorer(GetTriggerUnit()) then 
            call UnitDamageTarget(a, GetTriggerUnit(), 15000, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS) 
        else 
            call UnitDamageTarget(a, GetTriggerUnit(), 60000, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS) 
        endif 
        call KillUnit(a) 
        call DestroyTrigger(t) 
        call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e01E', GetUnitX(a), GetUnitY(a), GetRandomDirectionDeg()) 
    endif 
endfunction 

function Trig_FocusedWave_Actions takes nothing returns nothing 
    local timer k = CreateTimer() 
    local trigger t = CreateTrigger() 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempPoint2 = GetSpellTargetLoc() 
    set udg_TempBool = false 
    call CreateNUnitsAtLoc(1, 'e01D', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
    call RemoveLocation(udg_TempPoint3) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit()) 
    call TimerStart(k, 0.04, true, function FocusedWave_Slide) 
    call SaveTriggerHandle(LS(), GetHandleId(k), StringHash("trig"), t) 
    call TriggerRegisterUnitInRangeSimple(t, 100.0, GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit()) 
    call TriggerAddAction(t, function FocusedWave_Damage) 
endfunction 

//=========================================================================== 
function InitTrig_FocusedWave takes nothing returns nothing 
    set gg_trg_FocusedWave = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_FocusedWave, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_FocusedWave, Condition(function Trig_FocusedWave_Conditions)) 
    call TriggerAddAction(gg_trg_FocusedWave, function Trig_FocusedWave_Actions) 
endfunction 

