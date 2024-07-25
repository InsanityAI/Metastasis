function Trig_ST7ControlLoss_Conditions takes nothing returns boolean 
    if(not(GetOwningPlayer(GetTriggerUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE))) then 
        return false 
    endif 
    if(not(GetOwningPlayer(GetTriggerUnit()) != Player(PLAYER_NEUTRAL_PASSIVE))) then 
        return false 
    endif 
    if(not(IsUnitIllusionBJ(GetTriggerUnit()) == false)) then 
        return false 
    endif 
    if(not(GetUnitPointValue(GetTriggerUnit()) != 37)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST7ControlLoss_Actions takes nothing returns nothing 
    call SetUnitOwner(gg_unit_h02B_0116, Player(PLAYER_NEUTRAL_AGGRESSIVE), false) 
endfunction 

//===========================================================================  
function InitTrig_ST7ControlLoss takes nothing returns nothing 
    set gg_trg_ST7ControlLoss = CreateTrigger() 
    call TriggerRegisterLeaveRectSimple(gg_trg_ST7ControlLoss, gg_rct_PirateShipControl) 
    call TriggerAddCondition(gg_trg_ST7ControlLoss, Condition(function Trig_ST7ControlLoss_Conditions)) 
    call TriggerAddAction(gg_trg_ST7ControlLoss, function Trig_ST7ControlLoss_Actions) 
endfunction 

