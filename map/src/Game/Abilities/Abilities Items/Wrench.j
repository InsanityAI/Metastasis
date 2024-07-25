function Trig_Wrench_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A00Z')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Wrench_Func004Func001C takes nothing returns boolean 
    if(not(GetItemTypeId(UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA())) == 'I00H')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Wrench_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellTargetUnit()) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        if(Trig_Wrench_Func004Func001C()) then 
            set udg_TempItem = UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()) 
        else 
        endif 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call SetItemPositionLoc(udg_TempItem, udg_TempPoint) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_Wrench takes nothing returns nothing 
    set gg_trg_Wrench = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Wrench, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Wrench, Condition(function Trig_Wrench_Conditions)) 
    call TriggerAddAction(gg_trg_Wrench, function Trig_Wrench_Actions) 
endfunction 

