function Trig_MotionSensor_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A062')) then 
        return false 
    endif 
    return true 
endfunction 

function MotionSensor_Clean takes nothing returns nothing 
    local trigger d = GetTriggeringTrigger() 
    local trigger k = LoadTriggerHandle(LS(), GetHandleId(d), StringHash("k")) 
    call FlushChildHashtable(LS(), GetHandleId(k)) 
    call DestroyTrigger(k) 
    call FlushChildHashtable(LS(), GetHandleId(d)) 
    call DestroyTrigger(d) 
endfunction 

function MotionSensor_Trigger takes nothing returns nothing 
    local trigger k = GetTriggeringTrigger() 
    local unit a = LoadUnitHandle(LS(), GetHandleId(k), StringHash("u")) 
    local location q = GetUnitLoc(a) 

    if GetUnitPointValue(GetTriggerUnit()) != 37 and GetOwningPlayer(GetTriggerUnit()) != GetOwningPlayer(a) then 
        call SetSoundPositionLocBJ(gg_snd_WayPointBling, q, 100.0) 
        call PlaySoundBJ(gg_snd_WayPointBling) 
        call PingMinimapForPlayer(GetOwningPlayer(a), GetLocationX(q), GetLocationY(q), 4.0) 
        call DisplayTextToPlayer(GetOwningPlayer(a), 0, 0, "|cff0000FFSensors have detected an intruder.") 
        call StartSoundForPlayerBJ(GetOwningPlayer(a), gg_snd_Hint) 
        call DisableTrigger(k) 
        call PolledWait(4.0) 
        call EnableTrigger(k) 
    endif 
    call RemoveLocation(q) 
    set q = null 
endfunction 
function Trig_MotionSensor_Actions takes nothing returns nothing 
    local trigger k = CreateTrigger() 
    local trigger d = CreateTrigger() 
    local location om = GetSpellTargetLoc() 
    local unit a = CreateUnitAtLoc(GetOwningPlayer(GetSpellAbilityUnit()), 'h045', om, GetRandomDirectionDeg()) 
    call RemoveLocation(om) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("u"), a) 
    call SaveTriggerHandle(LS(), GetHandleId(d), StringHash("k"), k) 
    call TriggerAddAction(d, function MotionSensor_Clean) 
    call TriggerRegisterDeathEvent(d, a) 
    call TriggerRegisterUnitInRangeSimple(k, 325.0, a) 
    call TriggerAddAction(k, function MotionSensor_Trigger) 
    call SetUnitColor(a, ConvertPlayerColor(PLAYER_NEUTRAL_AGGRESSIVE)) 
endfunction 

//=========================================================================== 
function InitTrig_MotionSensor takes nothing returns nothing 
    set gg_trg_MotionSensor = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_MotionSensor, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_MotionSensor, Condition(function Trig_MotionSensor_Conditions)) 
    call TriggerAddAction(gg_trg_MotionSensor, function Trig_MotionSensor_Actions) 
endfunction 

