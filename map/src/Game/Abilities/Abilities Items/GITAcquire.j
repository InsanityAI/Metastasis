function Trig_GITAcquire_Conditions takes nothing returns boolean 
    if(not(GetItemTypeId(GetManipulatedItem()) == 'I00M')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GITAcquire_Func004Func001C takes nothing returns boolean 
    if(not(GetItemTypeId(UnitItemInSlotBJ(GetManipulatingUnit(), GetForLoopIndexA())) == 'I00M')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GITAcquire_Func005C takes nothing returns boolean 
    if(not(udg_TempInt > 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GITAcquire_Actions takes nothing returns nothing 
    set udg_TempInt = 0 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        if(Trig_GITAcquire_Func004Func001C()) then 
            set udg_TempInt = (udg_TempInt + 1) 
        else 
        endif 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    if(Trig_GITAcquire_Func005C()) then 
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10.00, "|cffffcc00You may only carry one of these devices.|r") 
        call UnitRemoveItemSwapped(GetManipulatedItem(), GetManipulatingUnit()) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_GITAcquire takes nothing returns nothing 
    set gg_trg_GITAcquire = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_GITAcquire, EVENT_PLAYER_UNIT_PICKUP_ITEM) 
    call TriggerAddCondition(gg_trg_GITAcquire, Condition(function Trig_GITAcquire_Conditions)) 
    call TriggerAddAction(gg_trg_GITAcquire, function Trig_GITAcquire_Actions) 
endfunction 

