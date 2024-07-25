function Trig_Muteilate_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A02Y')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Muteilate_Actions takes nothing returns nothing 
    local unit k = GetSpellTargetUnit() 
    local string i = GetPlayerName(GetOwningPlayer(k)) 
    local player d = GetOwningPlayer(k) 
    local string j 
    if udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(k))] == k then 
        call DisplayTextToPlayer(GetOwningPlayer(k), 0, 0, "|cff00FFFFYou can no longer seem to form words...|r") 
        call SetPlayerName(GetOwningPlayer(k), "                                                                                                                                                                                                                                                " + "                                                                                                                                                                                                                                                " + "                                                                                                                                                                                                                                                ") 
        set j = GetPlayerName(GetOwningPlayer(k)) 
        call PolledWait(60.00) 
        if GetPlayerName(d) == j then 
            call SetPlayerName(d, i) 
            call DisplayTextToPlayer(d, 0, 0, "|cff00FFFFYour voice returns to you!|r") 
        endif 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Muteilate takes nothing returns nothing 
    set gg_trg_Muteilate = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Muteilate, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Muteilate, Condition(function Trig_Muteilate_Conditions)) 
    call TriggerAddAction(gg_trg_Muteilate, function Trig_Muteilate_Actions) 
endfunction 

