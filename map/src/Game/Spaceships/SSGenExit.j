function Trig_SSGenExit_Conditions takes nothing returns boolean 
    if(not(RectContainsUnit(gg_rct_Space, udg_SS_Space[GetUnitUserData(udg_TempUnit)]) == false)) then 
        return false 
    endif 
    if(not(udg_SS_LaunchCountdown[GetUnitUserData(udg_TempUnit)] == false)) then 
        return false 
    endif 
    if(not(GetUnitPointValue(GetTriggerUnit()) != 37)) then 
        return false 
    endif 
    if RectContainsUnit(gg_rct_Space, udg_SS_Landed[GetUnitUserData(udg_TempUnit)]) == true then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SSGenExit_Actions takes nothing returns nothing 
    local unit a = udg_TempUnit 
    local unit b 
    local real t = TimerGetElapsed(udg_GameTimer) 
    set udg_Unit_ShipEnterCooldown[GetUnitAN(GetTriggerUnit())] = t 

    if GetUnitPointValue(GetTriggerUnit()) == 37 then 
        return 
    endif 

    if GetOwningPlayer(GetTriggerUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) or GetUnitTypeId(GetTriggerUnit()) == 'h04Q' then 
        if udg_SS_LaunchCountdown[GetUnitUserData(udg_TempUnit)] == false then 
            if RectContainsUnit(gg_rct_Space, udg_SS_Space[GetUnitUserData(udg_TempUnit)]) == false then 
                call DisableTrigger(udg_Spaceship_EnterTrig[GetUnitUserData(udg_TempUnit)]) 
                set udg_TempPoint = GetUnitLoc(udg_SS_Landed[GetUnitUserData(udg_TempUnit)]) 
                if RectContainsLoc(gg_rct_Timeout, udg_TempPoint) == false then 
                    call SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint) 
                endif 
            
                if GetOwningPlayer(GetTriggerUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) then 
                    call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0) 
                else 
                    call PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0) 
                endif 
            
                call RemoveLocation(udg_TempPoint) 
                call PolledWait(0.01) 
                call EnableTrigger(udg_Spaceship_EnterTrig[GetUnitUserData(a)]) 
            else 
                if udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitAN(a)])] then 
                    if IsUnitDeadBJ(udg_SS_Space[GetUnitUserData(udg_SS_BoardingTarget[GetUnitUserData(udg_SS_Landed[GetUnitUserData(udg_TempUnit)])])]) then 
                        return 
                    endif 
                
                    set b = udg_SS_BoardingTarget[GetUnitAN(a)] 
                    call DisableTrigger(udg_Spaceship_ExitTrig[GetUnitUserData(b)]) 
                    set udg_TempPoint = GetRectCenter(udg_Spaceship_EnterExit[GetUnitUserData(b)]) 
                    call SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint) 
                    if GetOwningPlayer(GetTriggerUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) then 
                        call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0) 
                    else 
                        call PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0) 
                    endif 
                
                    call RemoveLocation(udg_TempPoint) 
                    call PolledWait(0.01) 
                    call EnableTrigger(udg_Spaceship_ExitTrig[GetUnitUserData(b)]) 
                endif 
            endif 
        endif 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_SSGenExit takes nothing returns nothing 
    set gg_trg_SSGenExit = CreateTrigger() 

    call TriggerAddAction(gg_trg_SSGenExit, function Trig_SSGenExit_Actions) 
endfunction 

