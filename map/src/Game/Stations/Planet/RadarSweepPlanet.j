function Trig_RadarSweepPlanet_Func004Func001Func002Func001001001 takes nothing returns boolean 
    return(GetFilterPlayer() == udg_Parasite) 
endfunction 

function Trig_RadarSweepPlanet_Func004Func001Func002Func002001001 takes nothing returns boolean 
    return(GetFilterPlayer() == GetOwningPlayer(GetBuyingUnit())) 
endfunction 

function Trig_RadarSweepPlanet_Func004Func001Func002C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetBuyingUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RadarSweepPlanet_Func004Func001C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE))) then 
        return false 
    endif 
    if(not(GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE))) then 
        return false 
    endif 
    if(not(GetUnitPointValue(GetEnumUnit()) != 37)) then 
        return false 
    endif 
    if(not(GetUnitAbilityLevelSwapped('Aloc', GetEnumUnit()) == 0)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RadarSweepPlanet_Func004Func002Func002Func001001001 takes nothing returns boolean 
    return(udg_Parasite == GetFilterPlayer()) 
endfunction 

function Trig_RadarSweepPlanet_Func004Func002Func002Func002001001 takes nothing returns boolean 
    return(GetOwningPlayer(GetBuyingUnit()) == GetFilterPlayer()) 
endfunction 

function Trig_RadarSweepPlanet_Func004Func002Func002C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetBuyingUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RadarSweepPlanet_Func004Func002C takes nothing returns boolean 
    if not(IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RadarSweepPlanet_Func004A takes nothing returns nothing 
    if(Trig_RadarSweepPlanet_Func004Func001C()) then 
        set udg_TempPoint = GetUnitLoc(GetEnumUnit()) 
        if(Trig_RadarSweepPlanet_Func004Func001Func002C()) then 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_RadarSweepPlanet_Func004Func001Func002Func002001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100) 
        else 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_RadarSweepPlanet_Func004Func001Func002Func001001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100) 
        endif 
        call RemoveLocation(udg_TempPoint) 
    else 
    endif 
    if(Trig_RadarSweepPlanet_Func004Func002C()) then 
        set udg_TempPoint2 = GetUnitLoc(GetEnumUnit()) 
        if(Trig_RadarSweepPlanet_Func004Func002Func002C()) then 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_RadarSweepPlanet_Func004Func002Func002Func002001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00) 
        else 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_RadarSweepPlanet_Func004Func002Func002Func001001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00) 
        endif 
        call RemoveLocation(udg_TempPoint2) 
    else 
    endif 
endfunction 

function Trig_RadarSweepPlanet_Actions takes nothing returns nothing 
    call RemoveItem(GetSoldItem()) 
    call DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "|cffffcc00Planetary sweep complete.|r") 
    call ForGroupBJ(GetUnitsInRectAll(gg_rct_Planet), function Trig_RadarSweepPlanet_Func004A) 
endfunction 

//=========================================================================== 
function InitTrig_RadarSweepPlanet takes nothing returns nothing 
    set gg_trg_RadarSweepPlanet = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_RadarSweepPlanet, gg_unit_h019_0154, EVENT_UNIT_SELL_ITEM) 
    call TriggerAddAction(gg_trg_RadarSweepPlanet, function Trig_RadarSweepPlanet_Actions) 
endfunction 

