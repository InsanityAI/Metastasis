function Trig_MagneticThrust_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07U')) then 
        return false 
    endif 
    return true 
endfunction 

//Push2 is global function pushing units, muh physicsss 

//Optimally, med regenerator + GIT Resolver (+ motion sensor) 
//Should take no damage from pushing, while also not pushing bounce'd units. 
//But whatever. 
//Honestly, if the initial thrust of magnetic suit did no damage, it would be not OP, but broken. 
function MT_PushAway takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    local unit a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("t")) 

    if not(HaveSavedBoolean(LS(), GetHandleId(a), StringHash("AlreadyHit_" + I2S(GetUnitAN(GetTriggerUnit()))))) and GetUnitAbilityLevel(GetTriggerUnit(), 'Avul') == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 then 
        
        //If the one who cast it, do not damage, otherwise PUSHHHH 
        if(LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit()) then 
            call UnitDamageTarget(a, GetTriggerUnit(), 100.0, true, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
        endif 
        
        call Push2(GetTriggerUnit(), 400.0, 230.0, AngleBetweenUnits(a, GetTriggerUnit())) 
        
        //Cache already hit by an object, so the same won't do it again? 
        call SaveBoolean(LS(), GetHandleId(a), StringHash("AlreadyHit_" + I2S(GetUnitAN(GetTriggerUnit()))), true) 
    endif 

endfunction 


function MT_Cleanup takes nothing returns nothing 
    local timer m = GetExpiredTimer() 
    local trigger t = LoadTriggerHandle(LS(), GetHandleId(m), StringHash("a")) 
    local unit a = LoadUnitHandle(LS(), GetHandleId(m), StringHash("unit")) 

    call FlushChildHashtable(LS(), GetHandleId(t)) 
    call DestroyTrigger(t) 
    call FlushChildHashtable(LS(), GetHandleId(m)) 
    call DestroyTimer(m) 
    call FlushChildHashtable(LS(), GetHandleId(a)) 
endfunction 

function ThrustPickedMetalUnit takes nothing returns nothing 
    local trigger pushContactTrigger 
    local timer m 
    local unit thrustableUnit = GetEnumUnit() 

    //useless if, since the units enumerated/picked here, are already filtered! 
    //However! that suit unit function is DEFINITELY interesting. As in, you can push other players holy fuck. 
    //if GetUnitTypeId(thrustableUnit)=='h04L' or GetUnitTypeId(thrustableUnit)=='h03N' or GetUnitTypeId(GetFilterUnit())=='n00J' or IsUnitSuit(thrustableUnit) then 
    set m = CreateTimer() 
    set pushContactTrigger = CreateTrigger() 
        
    //90 range is the magnetic thrust 
    //When the enumerated unit (metal) comes into contact with something on 90 range (melee contact), then run function push away ;) 
    call TriggerRegisterUnitInRange(pushContactTrigger, thrustableUnit, 90.0, null) 
    call TriggerAddAction(pushContactTrigger, function MT_PushAway) 
        
    //Cache/Remember who the caster is, and which ones are the pushed objects! 
    call SaveUnitHandle(LS(), GetHandleId(pushContactTrigger), StringHash("t"), thrustableUnit) 
    call SaveUnitHandle(LS(), GetHandleId(pushContactTrigger), StringHash("caster"), udg_TempUnit4) 
        
        
    call SaveTriggerHandle(LS(), GetHandleId(m), StringHash("a"), pushContactTrigger) 
    call SaveUnitHandle(LS(), GetHandleId(m), StringHash("unit"), thrustableUnit) 
    set udg_TempPoint = GetUnitLoc(thrustableUnit) 
        
    //If suited unit pushed (doesnt happen cuz of filter feelsbadman) 
    if IsUnitSuit(thrustableUnit) then 
        call Push2(thrustableUnit, 250.0, 250.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
        call TimerStart(m, 1.0, false, function MT_Cleanup) 
    else //magnetic object 
        call Push2(thrustableUnit, 800.0, 250.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
        call TimerStart(m, 4.0, false, function MT_Cleanup) 
    endif 
        
    call RemoveLocation(udg_TempPoint) 

    set pushContactTrigger = null 
    //endif 
endfunction 

//return IsMetallicObject 
function MT_Filter takes nothing returns boolean 
    return GetUnitTypeId(GetFilterUnit()) == 'h04L' or GetUnitTypeId(GetFilterUnit()) == 'h03N' or GetUnitTypeId(GetFilterUnit()) == 'n00J' or GetUnitTypeId(GetFilterUnit()) == 'h04A' or GetUnitTypeId(GetFilterUnit()) == 'h01Z' or GetUnitTypeId(GetFilterUnit()) == 'h00B' or GetUnitTypeId(GetFilterUnit()) == 'e018' or GetUnitTypeId(GetFilterUnit()) == 'h04Q' or GetUnitTypeId(GetFilterUnit()) == 'h038' or GetUnitTypeId(GetFilterUnit()) == 'e00C' //or GetUnitTypeId(GetFilterUnit())=='h045' 
endfunction 

function Trig_MagneticThrust_Actions takes nothing returns nothing 
    local location magneticMasterLocation = GetUnitLoc(GetSpellAbilityUnit()) 
    local boolexpr ord = Condition(function MT_Filter) 
    local group metallicObjectGroup = GetUnitsInRangeOfLocMatching(310.00, magneticMasterLocation, ord) 
    local group tempMetallicObjectGroup = metallicObjectGroup 
    local unit pickedUnit 
    local integer i = 0 
    
    set udg_TempPoint2 = GetSpellTargetLoc() 
    set udg_TempUnit4 = GetSpellAbilityUnit() 
    
    //If more than 5 units to be pushed (in the metal/saw/barrel group) 
    //Take metallicObjectGroup's elements and put them onto... wtf? 
    //Remove, put them onto tempMetallicObjectGroup, then merge the groups, wtf?!!!!! 
    //WHY IS THIS A THING? WAS THERE EVEN A BUG? 
    if CountUnitsInGroup(metallicObjectGroup) > 5 then 
        set tempMetallicObjectGroup = CreateGroup() 
        
        loop 
            exitwhen i > 4 
            set pickedUnit = FirstOfGroup(metallicObjectGroup) 
            call GroupRemoveUnit(metallicObjectGroup, pickedUnit) 
            call GroupAddUnit(tempMetallicObjectGroup, pickedUnit) 
            set i = i + 1 
        endloop 

        set metallicObjectGroup = tempMetallicObjectGroup 
    endif 

    //Pushing time! 
    call ForGroupBJ(metallicObjectGroup, function ThrustPickedMetalUnit) 
    
    //Clean cache 
    call DestroyGroup(metallicObjectGroup) 
    call DestroyGroup(tempMetallicObjectGroup) 
    call RemoveLocation(magneticMasterLocation) 
endfunction 

//=========================================================================== 
function InitTrig_MagneticThrust takes nothing returns nothing 
    set gg_trg_MagneticThrust = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_MagneticThrust, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_MagneticThrust, Condition(function Trig_MagneticThrust_Conditions)) 
    call TriggerAddAction(gg_trg_MagneticThrust, function Trig_MagneticThrust_Actions) 
endfunction 

