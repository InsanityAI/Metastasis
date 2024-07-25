function Trig_SpaceCollision_Func002Func004Func002Func002C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetEnumUnit()) != 'h02P')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SpaceCollision_Func002Func004Func002C takes nothing returns boolean 
    if(not(GetEnumUnit() != udg_TempUnit)) then 
        return false 
    endif 
    if(not(GetEnumUnit() != gg_unit_h01A_0197)) then 
        return false 
    endif 
    if(not(GetUnitPointValue(GetEnumUnit()) != 37)) then 
        return false 
    endif 
    if not(not(IsUnitStation(GetEnumUnit()) and udg_TempUnit == gg_unit_h00X_0049)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SpaceCollision_Func002Func004A takes nothing returns nothing 
    local integer r 
    if(Trig_SpaceCollision_Func002Func004Func002C()) then 
        // The above condition prevents the Swagger from pushing stations. 
        if(Trig_SpaceCollision_Func002Func004Func002Func002C()) then 
            set udg_TempPoint2 = GetUnitLoc(GetEnumUnit()) 
            call Push(GetEnumUnit(), 30.0, 10.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
            call RemoveLocation(udg_TempPoint2) 
        else 
            set r = LoadInteger(LS(), GetHandleId(GetEnumUnit()), StringHash("PushTolerance")) + 1 
            call SaveInteger(LS(), GetHandleId(GetEnumUnit()), StringHash("PushTolerance"), r) 
            set udg_TempPoint2 = GetUnitLoc(GetEnumUnit()) 
            call Push(GetEnumUnit(), 30.0 / r, 10.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
            call RemoveLocation(udg_TempPoint2) 
        endif 
    else 
    endif 
endfunction 

function Trig_SpaceCollision_Func002A takes nothing returns nothing 
    set udg_TempUnit = GetEnumUnit() 
    set udg_TempPoint = GetUnitLoc(udg_TempUnit) 
    set udg_TempUnitGroup = GetUnitsInRangeOfLocAll(udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)], udg_TempPoint) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_SpaceCollision_Func002Func004A) 
    call RemoveLocation(udg_TempPoint) 
    call DestroyGroup(udg_TempUnitGroup) 
endfunction 

function Trig_SpaceCollision_Actions takes nothing returns nothing 
    call ForGroupBJ(udg_SpaceObject_CollideGroup, function Trig_SpaceCollision_Func002A) 
endfunction 

//=========================================================================== 
function InitTrig_SpaceCollision takes nothing returns nothing 
    set gg_trg_SpaceCollision = CreateTrigger() 
    call TriggerRegisterTimerEventPeriodic(gg_trg_SpaceCollision, 0.25) 
    call TriggerAddAction(gg_trg_SpaceCollision, function Trig_SpaceCollision_Actions) 
endfunction 

