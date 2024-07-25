function Trig_BackFromHellEldritchDeath_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTriggerUnit()) == 'h02Z')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHellEldritchDeath_Actions takes nothing returns nothing 
    set udg_EldritchBeastExists = false 
endfunction 

//=========================================================================== 
function InitTrig_BackFromHellEldritchDeath takes nothing returns nothing 
    set gg_trg_BackFromHellEldritchDeath = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_BackFromHellEldritchDeath, EVENT_PLAYER_UNIT_DEATH) 
    call TriggerAddCondition(gg_trg_BackFromHellEldritchDeath, Condition(function Trig_BackFromHellEldritchDeath_Conditions)) 
    call TriggerAddAction(gg_trg_BackFromHellEldritchDeath, function Trig_BackFromHellEldritchDeath_Actions) 
endfunction 

