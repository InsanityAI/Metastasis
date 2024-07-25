function Trig_PrismRocketsEndAlbadar_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07L')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PrismRocketsEndAlbadar_Actions takes nothing returns nothing 
    local timer t = LoadTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("PrismRocket_Timer")) 
    call FlushChildHashtable(LS(), GetHandleId(t)) 
    call DestroyTimer(t) 
    call PauseTimer(t) 
endfunction 

//=========================================================================== 
function InitTrig_PrismRocketsEndAlbadar takes nothing returns nothing 
    set gg_trg_PrismRocketsEndAlbadar = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_PrismRocketsEndAlbadar, EVENT_PLAYER_UNIT_SPELL_ENDCAST) 
    call TriggerAddCondition(gg_trg_PrismRocketsEndAlbadar, Condition(function Trig_PrismRocketsEndAlbadar_Conditions)) 
    call TriggerAddAction(gg_trg_PrismRocketsEndAlbadar, function Trig_PrismRocketsEndAlbadar_Actions) 
endfunction 

