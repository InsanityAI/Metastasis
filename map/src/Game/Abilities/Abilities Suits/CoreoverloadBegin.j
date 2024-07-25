function Trig_CoreoverloadBegin_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A06C')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_CoreoverloadBegin_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempUnit = GetSpellAbilityUnit() 
    set udg_CountUpBarColor = "|cff000000" 
    call CountUpBar(udg_TempUnit, 60, 0.06666, "DoNothing") 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_CoreoverloadBegin takes nothing returns nothing 
    set gg_trg_CoreoverloadBegin = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_CoreoverloadBegin, EVENT_PLAYER_UNIT_SPELL_CHANNEL) 
    call TriggerAddCondition(gg_trg_CoreoverloadBegin, Condition(function Trig_CoreoverloadBegin_Conditions)) 
    call TriggerAddAction(gg_trg_CoreoverloadBegin, function Trig_CoreoverloadBegin_Actions) 
endfunction 

