function Trig_AlienAdjustShop_Conditions takes nothing returns boolean 
    if(not(IsUnitAliveBJ(udg_AlienForm_Alien) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienAdjustShop_Func007Func001C takes nothing returns boolean 
    if(not(UnitItemInSlotBJ(udg_AlienForm_Alien, GetForLoopIndexA()) != null)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienAdjustShop_Func008Func002C takes nothing returns boolean 
    if(not((7 - udg_TempInt) == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienAdjustShop_Func008C takes nothing returns boolean 
    if(not((7 - udg_TempInt) != GetUnitAbilityLevelSwapped('A03E', udg_Alien_ShopWorkaround))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienAdjustShop_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(udg_AlienForm_Alien) 
    call SetUnitPositionLoc(udg_Alien_ShopWorkaround, udg_TempPoint) 
    call RemoveLocation(udg_TempPoint) 
    set udg_TempInt = 0 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        if(Trig_AlienAdjustShop_Func007Func001C()) then 
            set udg_TempInt = (udg_TempInt + 1) 
        else 
        endif 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    if(Trig_AlienAdjustShop_Func008C()) then 
        call SetUnitAbilityLevelSwapped('A03E', udg_Alien_ShopWorkaround, (7 - udg_TempInt)) 
        if(Trig_AlienAdjustShop_Func008Func002C()) then 
            call UnitAddItemByIdSwapped('I01B', udg_Alien_ShopWorkaround) 
        else 
            call RemoveItem(GetItemOfTypeFromUnitBJ(udg_Alien_ShopWorkaround, 'I01B')) 
        endif 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_AlienAdjustShop takes nothing returns nothing 
    set gg_trg_AlienAdjustShop = CreateTrigger() 
    call DisableTrigger(gg_trg_AlienAdjustShop) 
    call TriggerRegisterTimerEventPeriodic(gg_trg_AlienAdjustShop, 0.20) 
    call TriggerAddCondition(gg_trg_AlienAdjustShop, Condition(function Trig_AlienAdjustShop_Conditions)) 
    call TriggerAddAction(gg_trg_AlienAdjustShop, function Trig_AlienAdjustShop_Actions) 
endfunction 

