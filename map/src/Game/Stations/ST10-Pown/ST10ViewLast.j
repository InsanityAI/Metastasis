function Trig_ST10ViewLast_Conditions takes nothing returns boolean 
    return GetSpellAbilityId() == 'A084' 
endfunction 

function Trig_ST10ViewLast_Actions takes nothing returns nothing 
    local player thisPlayer = GetOwningPlayer(GetSpellAbilityUnit()) 
    set udg_TempPoint = LoadLocationHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("PortPlace")) 
    if thisPlayer == Player(bj_PLAYER_NEUTRAL_EXTRA) then 
        set thisPlayer = udg_Parasite 
    endif 
    call PanCameraToTimedLocForPlayer(thisPlayer, udg_TempPoint, 0.25) 
endfunction 

//===========================================================================   
function InitTrig_ST10ViewLast takes nothing returns nothing 
    set gg_trg_ST10ViewLast = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ST10ViewLast, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_ST10ViewLast, Condition(function Trig_ST10ViewLast_Conditions)) 
    call TriggerAddAction(gg_trg_ST10ViewLast, function Trig_ST10ViewLast_Actions) 
endfunction 

