function Trig_ST7Control_Conditions takes nothing returns boolean 
    if(not(GetOwningPlayer(GetTriggerUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE))) then 
        return false 
    endif 
    if(not(GetOwningPlayer(GetTriggerUnit()) != Player(PLAYER_NEUTRAL_PASSIVE))) then 
        return false 
    endif 
    if(not(IsUnitIllusionBJ(GetTriggerUnit()) == false)) then 
        return false 
    endif 
    if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I012') == true)) then 
        return false 
    endif 
    if(not(GetUnitPointValue(GetTriggerUnit()) != 37)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST7Control_Actions takes nothing returns nothing 
    local player thisPlayer = GetOwningPlayer(GetTriggerUnit()) 
    call SetUnitOwner(gg_unit_h02B_0116, GetOwningPlayer(GetTriggerUnit()), false) 
    call SelectUnitForPlayerSingle(gg_unit_h02B_0116, GetOwningPlayer(GetTriggerUnit())) 
    set udg_TempPoint = GetUnitLoc(gg_unit_h02B_0116) 
    if thisPlayer == Player(bj_PLAYER_NEUTRAL_EXTRA) then 
        set thisPlayer = udg_Parasite 
    endif 
    call PanCameraToTimedLocForPlayer(thisPlayer, udg_TempPoint, 0) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//===========================================================================  
function InitTrig_ST7Control takes nothing returns nothing 
    set gg_trg_ST7Control = CreateTrigger() 
    call TriggerRegisterEnterRectSimple(gg_trg_ST7Control, gg_rct_PirateShipControl) 
    call TriggerAddCondition(gg_trg_ST7Control, Condition(function Trig_ST7Control_Conditions)) 
    call TriggerAddAction(gg_trg_ST7Control, function Trig_ST7Control_Actions) 
endfunction 

