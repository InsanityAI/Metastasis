function Trig_PrionRemoveParasite_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A013')) then 
        return false 
    endif 
    if(not(GetSpellAbilityId() == 'A01S')) then 
        return false 
    endif 
    if(not(GetSpellAbilityId() == 'A01X')) then 
        return false 
    endif 
    if(not(GetSpellAbilityId() == 'A09K')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PrionRemoveParasite_Actions takes nothing returns nothing 
    call UnitRemoveBuffBJ('BNpa', GetSpellTargetUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_PrionRemoveParasite takes nothing returns nothing 
    set gg_trg_PrionRemoveParasite = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_PrionRemoveParasite, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_PrionRemoveParasite, Condition(function Trig_PrionRemoveParasite_Conditions)) 
    call TriggerAddAction(gg_trg_PrionRemoveParasite, function Trig_PrionRemoveParasite_Actions) 
endfunction 

