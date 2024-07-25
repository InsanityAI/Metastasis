function Rubble_Clearing_Device_Conditions takes nothing returns boolean 
    return GetSpellAbilityId() == 'A08E' 
endfunction 

function RCD_Damage2 takes nothing returns nothing 
    local timer t = GetExpiredTimer() 
    local destructable a = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("d")) 
    local unit b = LoadUnitHandle(LS(), GetHandleId(t), StringHash("u")) 
    call FlushChildHashtable(LS(), GetHandleId(t)) 
    call DestroyTimer(t) 
    call UnitDamageTarget(b, a, 750, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
endfunction 

function RCD_Damage takes nothing returns nothing 
    local timer t = CreateTimer() 
    call SaveDestructableHandle(LS(), GetHandleId(t), StringHash("d"), GetEnumDestructable()) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("u"), GetSpellAbilityUnit()) 
    call TimerStart(t, udg_TempReal * GetRandomReal(0.8, 1.2), false, function RCD_Damage2) 
endfunction 

function Rubble_Clearing_Device_Actions takes nothing returns nothing 
    local location a = GetSpellTargetLoc() 
    local location b = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempReal = DistanceBetweenPoints(a, b) / 700.0 
    call EnumDestructablesInCircleBJ(100.00, a, function RCD_Damage) 
    call RemoveLocation(a) 
    call RemoveLocation(b) 
endfunction 

//=========================================================================== 
function InitTrig_Rubble_Clearing_Device takes nothing returns nothing 
    set gg_trg_Rubble_Clearing_Device = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Rubble_Clearing_Device, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Rubble_Clearing_Device, Condition(function Rubble_Clearing_Device_Conditions)) 
    call TriggerAddAction(gg_trg_Rubble_Clearing_Device, function Rubble_Clearing_Device_Actions) 
endfunction 

