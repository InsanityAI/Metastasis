function Trig_Phase_Cloak_Conditions takes nothing returns boolean 
    if(not(GetItemTypeId(GetManipulatedItem()) == 'I025')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Phase_Cloak_Actions takes nothing returns nothing 
    call UnitAddAbilityForPeriod(GetManipulatingUnit(), 'A08D', 5.0) 
endfunction 

//=========================================================================== 
function InitTrig_Phase_Cloak takes nothing returns nothing 
    set gg_trg_Phase_Cloak = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Phase_Cloak, EVENT_PLAYER_UNIT_USE_ITEM) 
    call TriggerAddCondition(gg_trg_Phase_Cloak, Condition(function Trig_Phase_Cloak_Conditions)) 
    call TriggerAddAction(gg_trg_Phase_Cloak, function Trig_Phase_Cloak_Actions) 
endfunction 

