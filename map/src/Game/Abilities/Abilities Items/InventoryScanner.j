function Trig_InventoryScanner_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A08Y')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_InventoryScanner_Actions takes nothing returns nothing 
    call DisplayTextToPlayer(GetOwningPlayer(GetSpellTargetUnit()), 0, 0, "|cFFFF0000Your inventory has been scanned.|r") 
    call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "|cFFFF0000The target's inventory contains:|r") 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, GetItemName(UnitItemInSlotBJ(GetSpellTargetUnit(), GetForLoopIndexA()))) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
endfunction 

//=========================================================================== 
function InitTrig_InventoryScanner takes nothing returns nothing 
    set gg_trg_InventoryScanner = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_InventoryScanner, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_InventoryScanner, Condition(function Trig_InventoryScanner_Conditions)) 
    call TriggerAddAction(gg_trg_InventoryScanner, function Trig_InventoryScanner_Actions) 
endfunction 

