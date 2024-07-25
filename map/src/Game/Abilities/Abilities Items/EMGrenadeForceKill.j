function Trig_EMGrenadeForceKill_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetEnteringUnit()) == 'e00W')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_EMGrenadeForceKill_Actions takes nothing returns nothing 
    call UnitApplyTimedLifeBJ(1.23, 'BTLF', GetEnteringUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_EMGrenadeForceKill takes nothing returns nothing 
    set gg_trg_EMGrenadeForceKill = CreateTrigger() 
    call TriggerRegisterEnterRectSimple(gg_trg_EMGrenadeForceKill, GetPlayableMapRect()) 
    call TriggerAddCondition(gg_trg_EMGrenadeForceKill, Condition(function Trig_EMGrenadeForceKill_Conditions)) 
    call TriggerAddAction(gg_trg_EMGrenadeForceKill, function Trig_EMGrenadeForceKill_Actions) 
endfunction 

