function Trig_AlienFormTransfer_Conditions takes nothing returns boolean 
    if(not(udg_Alien_ShopWorkaround == GetBuyingUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienFormTransfer_Actions takes nothing returns nothing 
    call UnitAddItemByIdSwapped(GetItemTypeId(GetSoldItem()), udg_AlienForm_Alien) 
    call RemoveItem(GetSoldItem()) 
endfunction 

//=========================================================================== 
function InitTrig_AlienFormTransfer takes nothing returns nothing 
    set gg_trg_AlienFormTransfer = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AlienFormTransfer, EVENT_PLAYER_UNIT_SELL_ITEM) 
    call TriggerAddCondition(gg_trg_AlienFormTransfer, Condition(function Trig_AlienFormTransfer_Conditions)) 
    call TriggerAddAction(gg_trg_AlienFormTransfer, function Trig_AlienFormTransfer_Actions) 
endfunction 

