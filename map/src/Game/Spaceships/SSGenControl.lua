if Debug then Debug.beginFile "Game/Spaceships/SSGenControl" end
OnInit.trig("SSGenControl", function(require)
    ---@return boolean
    function Trig_SSGenControl_Conditions()
        if (not (GetOwningPlayer(udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)]) == Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (IsUnitIllusionBJ(GetTriggerUnit()) == false)) then
            return false
        end
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        return true
    end

    --function CheckMaintainSpaceshipControl_Child takes nothing returns nothing
    --if GetOwningPlayer(GetEnumUnit())==GetOwningPlayer(udg_TempUnit) and SubStringBJ(I2S(GetUnitPointValue(GetEnumUnit())), 1, 1) == "2" and IsUnitIllusion(GetEnumUnit()) == false then
    --set udg_TempBool=true
    --endif
    --endfunction

    --function CheckMaintainSpaceshipControl takes nothing returns nothing
    --local timer t=GetExpiredTimer()
    --local unit p=LoadUnitHandle(LS(),GetHandleId(t),StringHash("ship"))
    --local rect r=udg_Spaceship_ControlRect[GetUnitAN(p)]
    --local group g=GetUnitsInRectAll(r)
    --set udg_TempBool=false
    --set udg_TempUnit=p
    --call ForGroup(g,function CheckMaintainSpaceshipControl_Child)
    --call DestroyGroup(g)
    --if udg_TempBool==false then
    --call FlushChildHashtable(LS(),GetHandleId(t))
    --call PauseTimer(t)
    --call DestroyTimer(t)
    --call SetUnitOwner( udg_Spaceship_Console[GetUnitUserData(p)], Player(PLAYER_NEUTRAL_PASSIVE), false )
    --call SetUnitOwner( udg_SS_Space[GetUnitUserData(p)], Player(PLAYER_NEUTRAL_PASSIVE), false )
    --endif
    --endfunction


    function CheckLaunchProceed()
        if SubStringBJ(I2S(GetUnitPointValue(GetEnumUnit())), 1, 1) == "2" and IsUnitIllusion(GetEnumUnit()) == false then
            udg_TempBool = true
        end
    end

    function Trig_SSGenControl_Actions()
        local a ---@type unit
        local d = GetTriggerUnit() ---@type unit
        local k ---@type group

        if udg_Blackout then
            return
        end

        if (SubStringBJ(I2S(GetUnitPointValue(GetTriggerUnit())), 1, 1) == "1") then
            DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10.00, "TRIGSTR_1376")
            return
        end

        if (RectContainsUnit(gg_rct_Space, udg_SS_Space[GetUnitUserData(udg_TempUnit)]) == true) then
            if GetOwningPlayer(GetTriggerUnit()) ~= Player(14) then
                CheckConsoleControl(udg_Spaceship_Console[GetUnitAN(udg_TempUnit)], udg_SS_Space
                    [GetUnitAN(udg_TempUnit)], udg_Spaceship_Rect[GetUnitAN(udg_TempUnit)])
                SetUnitOwner(udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()),
                    false)
                DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, ("|cff8000FFU.S.I. Explorer Class|r" .. ""))
                DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, (" |cff00FF00Access Granted|r" .. ""))
                SelectUnitForPlayerSingle(udg_SS_Space[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()))
                SetUnitOwner(udg_SS_Space[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()), false)
                udg_TempPoint = GetUnitLoc(udg_SS_Space[GetUnitUserData(udg_TempUnit)])
                if udg_Unit_VendorDisabling[GetUnitAN(GetTriggerUnit())] == false then
                    PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0)
                end
                RemoveLocation(udg_TempPoint)

                --If Ace, add Ace attack speed ability
                if (GetUnitAbilityLevel(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], udg_RoleAbility[11]) == 1) then
                    UnitAddAbility(udg_SS_Space[GetUnitUserData(udg_TempUnit)], FourCC('A0A5'))
                end
            else
                SetUnitOwner(udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()),
                    false)
                DisplayTextToPlayer(udg_Parasite, 0, 0, ("|cff8000FFU.S.I. Explorer Class|r" .. ""))
                DisplayTextToPlayer(udg_Parasite, 0, 0, (" |cff00FF00Access Granted|r" .. ""))
                SelectUnitForPlayerSingle(udg_SS_Space[GetUnitUserData(udg_TempUnit)], udg_Parasite)
                SetUnitOwner(udg_SS_Space[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()), false)
                udg_TempPoint = GetUnitLoc(udg_SS_Space[GetUnitUserData(udg_TempUnit)])
                if udg_Unit_VendorDisabling[GetUnitAN(GetTriggerUnit())] == false then
                    PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0)
                end
                RemoveLocation(udg_TempPoint)
            end
        else
            if IsTriggerEnabled(gg_trg_SwaggerTeleportToPlanet) and udg_SS_Harbor[GetUnitUserData(udg_TempUnit)] == gg_unit_h00X_0049 then
                return
            end
            a = udg_TempUnit
            DisableTrigger(udg_Spaceship_ControlTrig[GetUnitUserData(a)])
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1370")

            udg_TempUnit = udg_SS_Landed[GetUnitUserData(udg_TempUnit)]
            udg_TempInt = 80
            udg_TempReal = 1 / 8.0
            udg_TempString = "DoNothing"

            udg_CountUpBarColor = "|cff80FFFF"
            ExecuteFunc("BarLocal_RunDummy")
            SaveBoolean(LS(), GetHandleId(udg_TempUnit), StringHash("LaunchCleared"), true)

            PolledWait(7.00)
            k = GetUnitsInRectAll(udg_Spaceship_Rect[GetUnitUserData(a)])
            udg_TempBool = false
            ForGroup(k, CheckLaunchProceed)
            DestroyGroup(k)
            k = nil
            if LoadBoolean(LS(), GetHandleId(udg_SS_Landed[GetUnitUserData(a)]), StringHash("LaunchCleared")) == false then
                udg_TempBool = false
            end
            if udg_TempBool == false then
                DisplayTextToForce(GetPlayersAll(), "|cff008040Explorer launch cancelled.|r")
                EnableTrigger(udg_Spaceship_ControlTrig[GetUnitUserData(a)])
                return
            else
                udg_SS_LaunchCountdown[GetUnitUserData(a)] = true
            end

            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1373")
            PolledWait(1.00)
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1377")
            ChangeElevatorWalls(false, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock
                [udg_SS_DockGroundedAt[GetUnitUserData(a)]])
            PolledWait(0.20)
            ChangeElevatorHeight(udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(a)]], 3)
            PolledWait(1.20)
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1378")
            SetUnitFlyHeightBJ(udg_SS_Landed[GetUnitUserData(a)], 2000.00, 1500.00)
            PolledWait(1.00)

            if GetUnitState(a, UNIT_STATE_LIFE) == 0 then
                DisplayTextToForce(GetPlayersAll(), "ERROR: Explorer vessel not responsive.")
                return
            end

            if RectContainsUnit(udg_Spaceship_ControlRect[GetUnitUserData(a)], d) then
                udg_TempPoint = GetUnitLoc(d)
                SetUnitPositionLoc(d, udg_HoldZone)
                SetUnitPositionLoc(d, udg_TempPoint)
                RemoveLocation(udg_TempPoint)
            end

            SetUnitLifePercentBJ(udg_SS_Space[GetUnitAN(a)], GetUnitLifePercent(a))
            udg_SS_LaunchCountdown[GetUnitUserData(a)] = false
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1374")
            udg_TempPoint = GetUnitLoc(udg_SS_Harbor[GetUnitUserData(a)])
            SetUnitPositionLoc(udg_SS_Space[GetUnitUserData(a)], udg_TempPoint)
            SetUnitPositionLoc(udg_SS_Landed[GetUnitUserData(a)], udg_HoldZone)
            RemoveLocation(udg_TempPoint)
            RemoveLocation(udg_TempPoint2)
            ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(a)]])
            ChangeElevatorHeight(udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(a)]], 1)
            udg_All_Dock_Filled[udg_SS_DockGroundedAt[GetUnitUserData(a)]] = false
            udg_SS_DockGroundedAt[GetUnitUserData(a)] = 0
            EnableTrigger(udg_Spaceship_ControlTrig[GetUnitUserData(a)])
        end
    end

    --===========================================================================
    gg_trg_SSGenControl = CreateTrigger()
    TriggerAddCondition(gg_trg_SSGenControl, Condition(Trig_SSGenControl_Conditions))
    TriggerAddAction(gg_trg_SSGenControl, Trig_SSGenControl_Actions)
end)
if Debug then Debug.endFile() end
