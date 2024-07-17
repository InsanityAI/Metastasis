if Debug then Debug.beginFile "Game/Spaceships/SSGenEnter" end
OnInit.trig("SSGenEnter", function(require)
    ---@return boolean
    function Trig_SSGenEnter_Conditions()
        if (not (GetOwningPlayer(GetTriggerUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE) or GetUnitTypeId(GetTriggerUnit()) == FourCC('h04Q'))) then
            return false
        end
        if (not (GetUnitFlyHeight(udg_SS_Landed[GetUnitUserData(udg_TempUnit)]) <= 101.00)) then
            return false
        end
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SSGenEnter_Func004Func001001001()
        return (GetFilterPlayer() == GetOwningPlayer(GetTriggerUnit()))
    end

    function Trig_SSGenEnter_Actions()
        local a = udg_TempUnit ---@type unit
        local t = TimerGetElapsed(udg_GameTimer) ---@type real
        local b = GetTriggerUnit() ---@type unit

        if IsUnitExplorer(b) and GetOwningPlayer(b) == Player(PLAYER_NEUTRAL_PASSIVE) then
            return
        end

        if t < udg_Unit_ShipEnterCooldown[GetUnitAN(b)] + 8.0 then
            DisplayTextToPlayer(GetOwningPlayer(b), 0, 0,
                "|cFFFF0000Please wait " .. R2S(udg_Unit_ShipEnterCooldown[GetUnitAN(b)] + 8.0 - t) +
                " seconds before entering this ship.")
            return
        end

        udg_Unit_ShipEnterCooldown[GetUnitAN(b)] = t

        if RectContainsUnit(gg_rct_Space, a) == false then
            DisableTrigger(udg_Spaceship_ExitTrig[GetUnitUserData(udg_TempUnit)])
            udg_TempPoint = GetRectCenter(udg_Spaceship_EnterExit[GetUnitUserData(udg_TempUnit)])
            SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint)

            if (GetTriggerUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) then
                if GetOwningPlayer(GetTriggerUnit()) ~= Player(14) then
                    PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0)
                else
                    PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0)
                end
            else
                PingMinimapLocForForceEx(GetPlayersMatching(Condition(Trig_SSGenEnter_Func004Func001001001)),
                    udg_TempPoint, 2.00, bj_MINIMAPPINGSTYLE_SIMPLE, 0.00, 0.00, 100)
            end

            RemoveLocation(udg_TempPoint)
            PolledWait(0.01)
            EnableTrigger(udg_Spaceship_ExitTrig[GetUnitUserData(a)])
        end
    end

    --===========================================================================
    gg_trg_SSGenEnter = CreateTrigger()
    TriggerAddCondition(gg_trg_SSGenEnter, Condition(Trig_SSGenEnter_Conditions))
    TriggerAddAction(gg_trg_SSGenEnter, Trig_SSGenEnter_Actions)
end)
if Debug then Debug.endFile() end
