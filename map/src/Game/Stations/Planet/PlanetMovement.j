function Trig_PlanetMovement_Conditions takes nothing returns boolean 
    if(not(UnitHasBuffBJ(gg_unit_h008_0196, 'B000') == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlanetMovement_Func003C takes nothing returns boolean 
    if(not(udg_PlanetAngle >= 360.00)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlanetMovement_Actions takes nothing returns nothing 
    if(Trig_PlanetMovement_Func003C()) then 
        set udg_PlanetAngle = 0.00 
    else 
    endif 
    set udg_PlanetAngle = (udg_PlanetAngle + 0.02) 
    set udg_PlanetTempPoint = PolarProjectionBJ(udg_PlanetRotatePoint, 2300.00, udg_PlanetAngle) 
    call SetUnitPositionLoc(gg_unit_h008_0196, udg_PlanetTempPoint) 
    call RemoveLocation(udg_PlanetTempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_PlanetMovement takes nothing returns nothing 
    set gg_trg_PlanetMovement = CreateTrigger() 
    call TriggerRegisterTimerEventPeriodic(gg_trg_PlanetMovement, 0.08) 
    call TriggerAddCondition(gg_trg_PlanetMovement, Condition(function Trig_PlanetMovement_Conditions)) 
    call TriggerAddAction(gg_trg_PlanetMovement, function Trig_PlanetMovement_Actions) 
endfunction 

