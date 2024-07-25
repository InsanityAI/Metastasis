function Trig_CarrierExplode_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A020')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_CarrierExplode_Actions takes nothing returns nothing 
    set udg_TempUnit = GetSpellAbilityUnit() 
    set udg_CountUpBarColor = "|cffFF0000" 
    call CountUpBar(udg_TempUnit, 60, 0.05, "CarrierSackExplosion") 
endfunction 

//=========================================================================== 
function InitTrig_CarrierExplode takes nothing returns nothing 
    set gg_trg_CarrierExplode = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_CarrierExplode, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_CarrierExplode, Condition(function Trig_CarrierExplode_Conditions)) 
    call TriggerAddAction(gg_trg_CarrierExplode, function Trig_CarrierExplode_Actions) 
endfunction 

