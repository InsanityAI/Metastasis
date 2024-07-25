function Trig_IllusionPodstart_Func001C takes nothing returns boolean 
    if((GetUnitTypeId(GetTriggerUnit()) == 'h02O')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetBuyingUnit()) == 'h00M')) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_IllusionPodstart_Conditions takes nothing returns boolean 
    if(not Trig_IllusionPodstart_Func001C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_IllusionPodstart_Actions takes nothing returns nothing 
    set udg_IllusionSuitBoolean = true 
    call StartTimerBJ(udg_IllusionSuitTimer, false, 5.00) 
endfunction 

//=========================================================================== 
function InitTrig_IllusionPodstart takes nothing returns nothing 
    set gg_trg_IllusionPodstart = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_IllusionPodstart, EVENT_PLAYER_UNIT_SELL_ITEM) 
    call TriggerAddCondition(gg_trg_IllusionPodstart, Condition(function Trig_IllusionPodstart_Conditions)) 
    call TriggerAddAction(gg_trg_IllusionPodstart, function Trig_IllusionPodstart_Actions) 
endfunction 

