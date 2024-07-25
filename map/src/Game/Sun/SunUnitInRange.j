function Trig_SunUnitInRange_Conditions takes nothing returns boolean 
    if(not(GetUnitPointValue(GetTriggerUnit()) != 37)) then 
        return false 
    endif 
    if(not(GetUnitTypeId(GetTriggerUnit()) != 'h02P')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SunUnitInRange_Actions takes nothing returns nothing 
    call SunLoop(GetTriggerUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_SunUnitInRange takes nothing returns nothing 
    set gg_trg_SunUnitInRange = CreateTrigger() 
    call TriggerRegisterUnitInRangeSimple(gg_trg_SunUnitInRange, 600.00, gg_unit_h01A_0197) 
    call TriggerAddCondition(gg_trg_SunUnitInRange, Condition(function Trig_SunUnitInRange_Conditions)) 
    call TriggerAddAction(gg_trg_SunUnitInRange, function Trig_SunUnitInRange_Actions) 
endfunction 

