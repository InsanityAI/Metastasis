if Debug then Debug.beginFile "Game/Spaceships/SSGenExit" end
OnInit.map("SSGenExit", function(require)
    ---@return boolean
    function Trig_SSGenExit_Conditions()
        if (not (RectContainsUnit(gg_rct_Space, udg_SS_Space[GetUnitUserData(udg_TempUnit)]) == false)) then
            return false
        end
        if (not (udg_SS_LaunchCountdown[GetUnitUserData(udg_TempUnit)] == false)) then
            return false
        end
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        if RectContainsUnit(gg_rct_Space, udg_SS_Landed[GetUnitUserData(udg_TempUnit)]) == true then
            return false
        end
        return true
    end

    function Trig_SSGenExit_Actions()
        local a                                                 = udg_TempUnit ---@type unit
        local b ---@type unit
        local t                                                 = TimerGetElapsed(udg_GameTimer) ---@type real
        udg_Unit_ShipEnterCooldown[GetUnitAN(GetTriggerUnit())] = t

        if GetUnitPointValue(GetTriggerUnit()) == 37 then
            return
        end

        if GetOwningPlayer(GetTriggerUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE) or GetUnitTypeId(GetTriggerUnit()) == FourCC('h04Q') then
            if udg_SS_LaunchCountdown[GetUnitUserData(udg_TempUnit)] == false then
                if RectContainsUnit(gg_rct_Space, udg_SS_Space[GetUnitUserData(udg_TempUnit)]) == false then
                    DisableTrigger(udg_Spaceship_EnterTrig[GetUnitUserData(udg_TempUnit)])
                    udg_TempPoint = GetUnitLoc(udg_SS_Landed[GetUnitUserData(udg_TempUnit)])
                    if RectContainsLoc(gg_rct_Timeout, udg_TempPoint) == false then
                        SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint)
                    end

                    if GetOwningPlayer(GetTriggerUnit()) ~= Player(14) then
                        PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0)
                    else
                        PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0)
                    end

                    RemoveLocation(udg_TempPoint)
                    PolledWait(0.01)
                    EnableTrigger(udg_Spaceship_EnterTrig[GetUnitUserData(a)])
                else
                    if udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitAN(a)])] then
                        if IsUnitDeadBJ(udg_SS_Space[GetUnitUserData(udg_SS_BoardingTarget[GetUnitUserData(udg_SS_Landed[GetUnitUserData(udg_TempUnit)])])]) then
                            return
                        end

                        b = udg_SS_BoardingTarget[GetUnitAN(a)]
                        DisableTrigger(udg_Spaceship_ExitTrig[GetUnitUserData(b)])
                        udg_TempPoint = GetRectCenter(udg_Spaceship_EnterExit[GetUnitUserData(b)])
                        SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint)
                        if GetOwningPlayer(GetTriggerUnit()) ~= Player(14) then
                            PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0)
                        else
                            PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0)
                        end

                        RemoveLocation(udg_TempPoint)
                        PolledWait(0.01)
                        EnableTrigger(udg_Spaceship_ExitTrig[GetUnitUserData(b)])
                    end
                end
            end
        end
    end

    --===========================================================================
    gg_trg_SSGenExit = CreateTrigger()

    TriggerAddAction(gg_trg_SSGenExit, Trig_SSGenExit_Actions)
end)
if Debug then Debug.endFile() end
