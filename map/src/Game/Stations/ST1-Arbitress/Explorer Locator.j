function Trig_Explorer_Locator_Conditions takes nothing returns boolean 
    if(not(GetItemTypeId(GetSoldItem()) == 'I02B')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Explorer_Locator_Func004Func001Func002Func001001001 takes nothing returns boolean 
    return(GetFilterPlayer() == udg_Parasite) 
endfunction 

function Trig_Explorer_Locator_Func004Func001Func002Func002001001 takes nothing returns boolean 
    return(GetFilterPlayer() == GetOwningPlayer(GetBuyingUnit())) 
endfunction 

function Trig_Explorer_Locator_Func004Func001Func002C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetBuyingUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Explorer_Locator_Func004Func001Func005C takes nothing returns boolean 
    if((GetUnitTypeId(GetEnumUnit()) == 'h02Q')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'h02H')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'h02L')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'h002')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'h03J')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'h02S')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'h02I')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'h02K')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'h001')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'h03K')) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_Explorer_Locator_Func004Func001C takes nothing returns boolean 
    if(not(RectContainsUnit(gg_rct_Timeout, GetEnumUnit()) == false)) then 
        return false 
    endif 
    if(not Trig_Explorer_Locator_Func004Func001Func005C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Explorer_Locator_Func004A takes nothing returns nothing 
    if(Trig_Explorer_Locator_Func004Func001C()) then 
        set udg_TempPoint = GetUnitLoc(GetEnumUnit()) 
        if(Trig_Explorer_Locator_Func004Func001Func002C()) then 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_Explorer_Locator_Func004Func001Func002Func002001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 50.00, 50.00, 100) 
        else 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_Explorer_Locator_Func004Func001Func002Func001001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 50.00, 50.00, 100) 
        endif 
        call RemoveLocation(udg_TempPoint) 
    else 
    endif 
endfunction 

function Trig_Explorer_Locator_Actions takes nothing returns nothing 
    call RemoveItem(GetSoldItem()) 
    call ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), function Trig_Explorer_Locator_Func004A) 
endfunction 

//=========================================================================== 
function InitTrig_Explorer_Locator takes nothing returns nothing 
    set gg_trg_Explorer_Locator = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Explorer_Locator, EVENT_PLAYER_UNIT_SELL_ITEM) 
    call TriggerAddCondition(gg_trg_Explorer_Locator, Condition(function Trig_Explorer_Locator_Conditions)) 
    call TriggerAddAction(gg_trg_Explorer_Locator, function Trig_Explorer_Locator_Actions) 
endfunction 

