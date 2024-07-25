 function Trig_FusionBombPurchase_Conditions takes nothing returns boolean 
    if(not(GetItemTypeId(GetSoldItem()) == 'I00N')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FusionBombPurchase_Actions takes nothing returns nothing 
    local unit a = GetSellingUnit() 
    call SetUnitAnimation(a, "stand work") 
    call PolledWait(58.00) 
    if IsUnitAliveBJ(a) then 
        call SetUnitAnimation(a, "stand") 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_FusionBombPurchase takes nothing returns nothing 
    set gg_trg_FusionBombPurchase = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_FusionBombPurchase, EVENT_PLAYER_UNIT_SELL_ITEM) 
    call TriggerAddCondition(gg_trg_FusionBombPurchase, Condition(function Trig_FusionBombPurchase_Conditions)) 
    call TriggerAddAction(gg_trg_FusionBombPurchase, function Trig_FusionBombPurchase_Actions) 
endfunction 

