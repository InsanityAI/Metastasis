function Trig_PulseWave_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A068')) then 
        return false 
    endif 
    return true 
endfunction 

function PulseWave_Slide takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local unit l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) 
    local location a = GetUnitLoc(l) 
    local location b = PolarProjectionBJ(a, 40.0, GetUnitFacing(l)) 
    call RemoveLocation(a) 
    call SetUnitPositionLoc(l, b) 
    call RemoveLocation(b) 
    if IsUnitDeadBJ(l) then 
        call DestroyTrigger(LoadTriggerHandle(LS(), GetHandleId(k), StringHash("trig"))) 
        call PauseTimer(k) 
        call DestroyTimer(k) 

    endif 
endfunction 

function PulseWave_Damage takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    local unit a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) 
    local unit b = GetTriggerUnit() 
    if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul') == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() then 
        call UnitDamageTarget(a, GetTriggerUnit(), 75, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
        if IsUnitType(b, UNIT_TYPE_STRUCTURE) != true then 
            call SetUnitAnimation(b, "death") 
        endif 
        call PauseUnit(b, true) 
        call PolledWait(0.8) 
        call PauseUnit(b, false) 
        if not(IsUnitSuit(b) or GetUnitTypeId(b) == 'h00H') then 
            call SetUnitAnimation(b, "stand") 
        endif 
        //call KillUnit(a) 
        //call DestroyTrigger(t) 
    endif 
endfunction 

function Trig_PulseWave_Actions takes nothing returns nothing 
    local timer k = CreateTimer() 
    local trigger t = CreateTrigger() 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempPoint2 = GetSpellTargetLoc() 
    set udg_TempBool = false 
    call CreateNUnitsAtLoc(1, 'e01R', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
    call RemoveLocation(udg_TempPoint3) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit()) 
    call TimerStart(k, 0.04, true, function PulseWave_Slide) 
    call SaveTriggerHandle(LS(), GetHandleId(k), StringHash("trig"), t) 
    call TriggerRegisterUnitInRangeSimple(t, 100.0, GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit()) 
    call TriggerAddAction(t, function PulseWave_Damage) 
endfunction 

//=========================================================================== 
function InitTrig_PulseWave takes nothing returns nothing 
    set gg_trg_PulseWave = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_PulseWave, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_PulseWave, Condition(function Trig_PulseWave_Conditions)) 
    call TriggerAddAction(gg_trg_PulseWave, function Trig_PulseWave_Actions) 
endfunction 

