function Trig_SSGenEnter_Conditions takes nothing returns boolean 
    if(not(GetOwningPlayer(GetTriggerUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) or GetUnitTypeId(GetTriggerUnit()) == 'h04Q')) then 
        return false 
    endif 
    if(not(GetUnitFlyHeight(udg_SS_Landed[GetUnitUserData(udg_TempUnit)]) <= 101.00)) then 
        return false 
    endif 
    if(not(GetUnitPointValue(GetTriggerUnit()) != 37)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SSGenEnter_Func004Func001001001 takes nothing returns boolean 
    return(GetFilterPlayer() == GetOwningPlayer(GetTriggerUnit())) 
endfunction 

function Trig_SSGenEnter_Actions takes nothing returns nothing 
    local unit a = udg_TempUnit 
    local real t = TimerGetElapsed(udg_GameTimer) 
    local unit b = GetTriggerUnit() 

    if IsUnitExplorer(b) and GetOwningPlayer(b) == Player(PLAYER_NEUTRAL_PASSIVE) then 
        return 
    endif 

    if t < udg_Unit_ShipEnterCooldown[GetUnitAN(b)] + 8.0 then 
        call DisplayTextToPlayer(GetOwningPlayer(b), 0, 0, "|cFFFF0000Please wait " + R2S(udg_Unit_ShipEnterCooldown[GetUnitAN(b)] + 8.0 - t) + " seconds before entering this ship.") 
        return 
    endif 

    set udg_Unit_ShipEnterCooldown[GetUnitAN(b)] = t 
    
    if RectContainsUnit(gg_rct_Space, a) == false then 
        call DisableTrigger(udg_Spaceship_ExitTrig[GetUnitUserData(udg_TempUnit)]) 
        set udg_TempPoint = GetRectCenter(udg_Spaceship_EnterExit[GetUnitUserData(udg_TempUnit)]) 
        call SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint) 
        
        if(GetTriggerUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) then 
            if GetOwningPlayer(GetTriggerUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) then 
                call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0) 
            else 
                call PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0) 
            endif 
        else 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_SSGenEnter_Func004Func001001001)), udg_TempPoint, 2.00, bj_MINIMAPPINGSTYLE_SIMPLE, 0.00, 0.00, 100) 
        endif 
        
        call RemoveLocation(udg_TempPoint) 
        call PolledWait(0.01) 
        call EnableTrigger(udg_Spaceship_ExitTrig[GetUnitUserData(a)]) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_SSGenEnter takes nothing returns nothing 
    set gg_trg_SSGenEnter = CreateTrigger() 
    call TriggerAddCondition(gg_trg_SSGenEnter, Condition(function Trig_SSGenEnter_Conditions)) 
    call TriggerAddAction(gg_trg_SSGenEnter, function Trig_SSGenEnter_Actions) 
endfunction 

