if Debug then Debug.beginFile "Game/Spaceships/SSGenDock" end
OnInit.trig("SSGenDock", function(require)
    ---@return boolean
    function Trig_SSGenDock_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A001'))) then
            return false
        end
        return true
    end

    ---@param a integer
    ---@param b integer
    ---@return integer
    function EvaluateDock(a, b)
        if GetRandomInt(1, a) == a then
            udg_TempDestruct = udg_All_Dock[b]
            udg_TempInt = b
        end
        return a + 1
    end

    function Trig_SSGenDock_Actions()
        local a = GetSpellAbilityUnit() ---@type unit
        local b = GetSpellTargetUnit() ---@type unit
        local q = GetOwningPlayer(a) ---@type player
        local i = 1 ---@type integer
        local onr ---@type string
        UnitAddAbilityForPeriod(a, FourCC('Avul'), 0.2)
        PolledWait(0.1)
        udg_TempUnit = udg_SS_Landed[GetUnitUserData(a)]
        a = udg_TempUnit
        udg_TempUnit2 = b
        udg_TempDestruct = nil
        udg_SS_Harbor[GetUnitUserData(udg_TempUnit)] = b
        if udg_TempUnit2 == gg_unit_h003_0018 then
            --Arbitress
            udg_TempBool = false
            bj_forLoopAIndex = 1
            bj_forLoopAIndexEnd = 4
            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                    i = EvaluateDock(i, GetForLoopIndexA())
                    --  set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                end
                bj_forLoopAIndex = bj_forLoopAIndex + 1
            end
        else
            if udg_TempUnit2 == gg_unit_h005_0024 then
                --Defunct
                udg_TempBool = false
                bj_forLoopAIndex = 5
                bj_forLoopAIndexEnd = 6
                while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                    if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                        i = EvaluateDock(i, GetForLoopIndexA())
                        -- set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                    else
                    end
                    bj_forLoopAIndex = bj_forLoopAIndex + 1
                end
            else
                if udg_TempUnit2 == gg_unit_h007_0027 then
                    --Kyo station
                    udg_TempBool = false
                    bj_forLoopAIndex = 7
                    bj_forLoopAIndexEnd = 8
                    while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                        if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                            i = EvaluateDock(i, GetForLoopIndexA())
                            --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                        end
                        bj_forLoopAIndex = bj_forLoopAIndex + 1
                    end
                    bj_forLoopAIndex = 34
                    if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                        i = EvaluateDock(i, GetForLoopIndexA())
                        -- set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                    end
                else
                    if udg_TempUnit2 == gg_unit_h009_0029 then
                        --U.S.I. Queen Niffy
                        udg_TempBool = false
                        bj_forLoopAIndex = 29
                        bj_forLoopAIndexEnd = 33
                        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                            if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                i = EvaluateDock(i, GetForLoopIndexA())
                            else
                            end
                            bj_forLoopAIndex = bj_forLoopAIndex + 1
                        end
                        bj_forLoopAIndex = 9
                        bj_forLoopAIndexEnd = 16
                        if udg_TempDestruct == nil then
                            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                    --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                    i = EvaluateDock(i, GetForLoopIndexA())
                                else
                                end
                                bj_forLoopAIndex = bj_forLoopAIndex + 1
                            end
                        end
                    else
                        if udg_TempUnit2 == gg_unit_h00X_0049 then
                            --U.S.I. Swagger
                            udg_TempBool = false
                            bj_forLoopAIndex = 17
                            bj_forLoopAIndexEnd = 20
                            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                    --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                    i = EvaluateDock(i, GetForLoopIndexA())
                                else
                                end
                                bj_forLoopAIndex = bj_forLoopAIndex + 1
                            end
                            bj_forLoopAIndex = 39
                            bj_forLoopAIndexEnd = 40
                            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                    --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                    i = EvaluateDock(i, GetForLoopIndexA())
                                else
                                end
                                bj_forLoopAIndex = bj_forLoopAIndex + 1
                            end
                        else
                            if udg_TempUnit2 == gg_unit_h008_0196 then
                                --Minertha
                                udg_TempBool = false
                                bj_forLoopAIndex = 35
                                bj_forLoopAIndexEnd = 38
                                while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                    if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                        --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                        i = EvaluateDock(i, GetForLoopIndexA())
                                    else
                                    end
                                    bj_forLoopAIndex = bj_forLoopAIndex + 1
                                end

                                bj_forLoopAIndex = 21
                                bj_forLoopAIndexEnd = 24
                                while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                    if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                        --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                        i = EvaluateDock(i, GetForLoopIndexA())
                                    else
                                    end
                                    bj_forLoopAIndex = bj_forLoopAIndex + 1
                                end
                            else
                                if udg_TempUnit2 == gg_unit_h029_0114 then
                                    --Lost station
                                    udg_TempBool = false
                                    bj_forLoopAIndex = 25
                                    bj_forLoopAIndexEnd = 26
                                    while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                        if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                            --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                            i = EvaluateDock(i, GetForLoopIndexA())
                                        else
                                        end
                                        bj_forLoopAIndex = bj_forLoopAIndex + 1
                                    end
                                else
                                    if udg_TempUnit2 == gg_unit_h02B_0116 then
                                        --Pirate vessel
                                        udg_TempBool = false
                                        bj_forLoopAIndex = 27
                                        bj_forLoopAIndexEnd = 28
                                        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                            if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                                --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                                i = EvaluateDock(i, GetForLoopIndexA())
                                            else
                                            end
                                            bj_forLoopAIndex = bj_forLoopAIndex + 1
                                        end
                                        bj_forLoopAIndex = 45
                                        bj_forLoopAIndexEnd = 46
                                        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                            if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                                --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                                i = EvaluateDock(i, GetForLoopIndexA())
                                            else
                                            end
                                            bj_forLoopAIndex = bj_forLoopAIndex + 1
                                        end
                                    else
                                        if (udg_TempUnit2 == gg_unit_h03T_0209) then
                                            --Errun
                                            udg_TempBool = false
                                            bj_forLoopAIndex = 41
                                            bj_forLoopAIndexEnd = 44
                                            while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                                if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                                    --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                                    i = EvaluateDock(i, GetForLoopIndexA())
                                                else
                                                end
                                                bj_forLoopAIndex = bj_forLoopAIndex + 1
                                            end
                                        else
                                            if udg_TempUnit2 == gg_unit_h04T_0265 then
                                                --Syllus
                                                udg_TempBool = false
                                                bj_forLoopAIndex = 47
                                                bj_forLoopAIndexEnd = 52
                                                while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                                    if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                                        --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                                        i = EvaluateDock(i, GetForLoopIndexA())
                                                    end
                                                    bj_forLoopAIndex = bj_forLoopAIndex + 1
                                                end
                                            else
                                                if GetUnitTypeId(udg_TempUnit2) == FourCC('h04G') then
                                                    --MRZCODE: IF OVERLORD
                                                    udg_TempBool = false
                                                    bj_forLoopAIndex = 53
                                                    bj_forLoopAIndexEnd = 58
                                                    while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
                                                        if udg_All_Dock_Filled[GetForLoopIndexA()] ~= true then
                                                            --set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                                            i = EvaluateDock(i, GetForLoopIndexA())
                                                        end
                                                        bj_forLoopAIndex = bj_forLoopAIndex + 1
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if udg_TempDestruct ~= nil then
            udg_SS_LaunchCountdown[GetUnitUserData(udg_TempUnit)] = true
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1379")
            udg_TempPoint = GetDestructableLoc(udg_TempDestruct)
            UnitAddAbility(udg_SS_Space[GetUnitUserData(udg_TempUnit)], FourCC('Avul'))
            SetUnitPositionLoc(udg_SS_Space[GetUnitUserData(udg_TempUnit)], udg_HoldZone)
            UnitRemoveAbility(udg_SS_Space[GetUnitUserData(udg_TempUnit)], FourCC('Avul'))
            SetUnitPositionLoc(udg_SS_Landed[GetUnitUserData(udg_TempUnit)], udg_TempPoint)
            ChangeElevatorHeight(udg_TempDestruct, 3)
            ChangeElevatorWalls(false, bj_ELEVATOR_WALL_TYPE_ALL, udg_TempDestruct)
            SetUnitFlyHeightBJ(udg_SS_Landed[GetUnitUserData(udg_TempUnit)], 100.00, 500.00)
            udg_SS_DockGroundedAt[GetUnitUserData(udg_TempUnit)] = udg_TempInt
            udg_All_Dock_Filled[udg_SS_DockGroundedAt[GetUnitUserData(udg_TempUnit)]] = true
            SetUnitOwner(udg_SS_Space[GetUnitUserData(udg_TempUnit)], Player(PLAYER_NEUTRAL_PASSIVE), false)
            RemoveLocation(udg_TempPoint)
            udg_TempPoint = GetRectCenter(udg_Spaceship_Rect[GetUnitUserData(udg_TempUnit)])
            PanCameraToTimedLocForPlayer(GetOwningPlayer(a), udg_TempPoint, 0)
            RemoveLocation(udg_TempPoint)
            udg_TempUnit3 = udg_TempUnit
            PolledWait(4.00)
            SetUnitLifePercentBJ(a, GetUnitLifePercent(udg_SS_Space[GetUnitAN(a)]))
            udg_TempUnit = a
            ChangeElevatorHeight(udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(udg_TempUnit)]], 1)
            ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL,
                udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(udg_TempUnit)]])
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1380")
            udg_SS_LaunchCountdown[GetUnitUserData(udg_TempUnit)] = false
        else
            onr = "|cffFF0000No landing pads are available.|r"
            if GetUnitTypeId(b) == FourCC('h04V') or GetUnitTypeId(b) == FourCC('h04E') then
                onr =
                "|cffFF0000This station does not use standard docking procedures; please apply standard boarding procedures instead.|r"
            end
            if q == Player(14) then
                DisplayTextToPlayer(udg_Parasite, 0, 0, onr)
            else
                DisplayTextToPlayer(q, 0, 0, onr)
            end

            udg_TempPoint = GetUnitLoc(a)
            SetUnitPositionLoc(a, udg_TempPoint)
            RemoveLocation(udg_TempPoint)
        end
    end

    --===========================================================================
    gg_trg_SSGenDock = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SSGenDock, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SSGenDock, Condition(Trig_SSGenDock_Conditions))
    TriggerAddAction(gg_trg_SSGenDock, Trig_SSGenDock_Actions)
end)
if Debug then Debug.endFile() end
