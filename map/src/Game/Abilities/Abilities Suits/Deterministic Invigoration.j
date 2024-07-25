function Trig_Deterministic_Invigoration_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A09Q')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Deterministic_Invigoration_Func005Func003C takes nothing returns boolean 
    if(not(udg_TempUnit != udg_TempUnit2)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Deterministic_Invigoration_Func005Func007C takes nothing returns boolean 
    if((GetUnitTypeId(udg_TempUnit2) == 'h02O')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h016')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h014')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h011')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h012')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h049')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h017')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h04S')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h00G')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h03Z')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h023')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h019')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h00O')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h00P')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h00Q')) then 
        return true 
    endif 
    if((GetUnitTypeId(udg_TempUnit2) == 'h00R')) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_Deterministic_Invigoration_Func005C takes nothing returns boolean 
    if(not Trig_Deterministic_Invigoration_Func005Func007C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Deterministic_Invigoration_Actions takes nothing returns nothing 
    set udg_TempUnit = GetTriggerUnit() 
    set udg_TempUnit2 = GetSpellTargetUnit() 
    if(Trig_Deterministic_Invigoration_Func005C()) then 
    else 
        call UnitAddAbilityBJ('A0A0', udg_TempUnit) 
        // If casted on an ally 
        if(Trig_Deterministic_Invigoration_Func005Func003C()) then 
            // Add buffs to target 
            call UnitAddAbilityBJ('A09W', udg_TempUnit2) 
            call UnitAddAbilityBJ('A09V', udg_TempUnit2) 
        else 
        endif 
        set udg_GuardInvigorationSelf[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))] = udg_TempUnit 
        set udg_GuardInvigorationAlly[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))] = udg_TempUnit2 
        call StartTimerBJ(udg_GuardInvigorationExpiration[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))], false, 8.00) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Deterministic_Invigoration takes nothing returns nothing 
    set gg_trg_Deterministic_Invigoration = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Deterministic_Invigoration, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Deterministic_Invigoration, Condition(function Trig_Deterministic_Invigoration_Conditions)) 
    call TriggerAddAction(gg_trg_Deterministic_Invigoration, function Trig_Deterministic_Invigoration_Actions) 
endfunction 

