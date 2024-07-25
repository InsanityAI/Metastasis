function Trig_Sunpod_apocalypse_Conditions takes nothing returns boolean 
    if(not(GetUnitPointValue(GetTriggerUnit()) != 37)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Sunpod_apocalypse_Actions takes nothing returns nothing 
    call SunLoop(GetTriggerUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_Sunpod_apocalypse takes nothing returns nothing 
    set gg_trg_Sunpod_apocalypse = CreateTrigger() 
    call DisableTrigger(gg_trg_Sunpod_apocalypse) 
    call TriggerRegisterUnitInRangeSimple(gg_trg_Sunpod_apocalypse, 600.00, gg_unit_h01A_0197) 
    call TriggerAddCondition(gg_trg_Sunpod_apocalypse, Condition(function Trig_Sunpod_apocalypse_Conditions)) 
    call TriggerAddAction(gg_trg_Sunpod_apocalypse, function Trig_Sunpod_apocalypse_Actions) 
endfunction 

