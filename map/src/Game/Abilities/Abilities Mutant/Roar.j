function Trig_Roar_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A01J')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Roar_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    call SetSoundPositionLocBJ(gg_snd_SargerasRoar, udg_TempPoint, 0) 
    call PlaySoundBJ(gg_snd_SargerasRoar) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_Roar takes nothing returns nothing 
    set gg_trg_Roar = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Roar, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Roar, Condition(function Trig_Roar_Conditions)) 
    call TriggerAddAction(gg_trg_Roar, function Trig_Roar_Actions) 
endfunction 

