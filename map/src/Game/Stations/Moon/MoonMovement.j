function Trig_MoonMovement_Conditions takes nothing returns boolean 
    if(not(UnitHasBuffBJ(gg_unit_h03T_0209, 'B000') == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MoonMovement_Func003C takes nothing returns boolean 
    if(not(udg_MoonAngle >= 360.00)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MoonMovement_Actions takes nothing returns nothing 
    if(Trig_MoonMovement_Func003C()) then 
        set udg_MoonAngle = 0.00 
    else 
    endif 
    set udg_MoonAngle = (udg_MoonAngle + 0.06) 
    set udg_PlanetTempPoint = GetUnitLoc(gg_unit_h008_0196) 
    set udg_MoonTempPoint = PolarProjectionBJ(udg_PlanetTempPoint, 800.00, udg_MoonAngle) 
    call SetUnitPositionLoc(gg_unit_h03T_0209, udg_MoonTempPoint) 
    call RemoveLocation(udg_PlanetTempPoint) 
    call RemoveLocation(udg_MoonTempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_MoonMovement takes nothing returns nothing 
    set gg_trg_MoonMovement = CreateTrigger() 
    call TriggerRegisterTimerEventPeriodic(gg_trg_MoonMovement, 0.04) 
    call TriggerAddCondition(gg_trg_MoonMovement, Condition(function Trig_MoonMovement_Conditions)) 
    call TriggerAddAction(gg_trg_MoonMovement, function Trig_MoonMovement_Actions) 
endfunction 

