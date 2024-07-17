if Debug then Debug.beginFile "Game/Stations/ST4/NiffyLockdown" end
OnInit.map("NiffyLockdown", function(require)
    ---@return boolean
    function Trig_Niffy_Lockdown_Func002C()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_Niffy_Lockdown_Func003Func013A()
        SetUnitPositionLoc(GetEnumUnit(), GetRectCenter(gg_rct_ST10))
    end

    function Trig_Niffy_Lockdown_Func003Func017A()
        SetUnitPositionLoc(GetEnumUnit(), GetRectCenter(gg_rct_ST10))
    end

    function Trig_Niffy_Lockdown_Func003Func021A()
        SetUnitPositionLoc(GetEnumUnit(), GetRectCenter(gg_rct_ST10))
    end

    function Trig_Niffy_Lockdown_Func003Func035A()
        SetUnitPositionLoc(GetEnumUnit(), GetRandomLocInRect(gg_rct_Niffy_Lockdown_Start))
        PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()), GetUnitLoc(GetEnumUnit()), 0)
    end

    function Trig_Niffy_Lockdown_Func003Func039A()
        SetPlayerTechMaxAllowedSwap(FourCC('h031'), 0, GetEnumPlayer())
        SetPlayerTechMaxAllowedSwap(FourCC('h04G'), 0, GetEnumPlayer())
        FogModifierStop(udg_SpaceVisibility[GetConvertedPlayerId(GetEnumPlayer())])
    end

    ---@return boolean
    function Trig_Niffy_Lockdown_Func003C()
        if (not (CountPlayersInForceBJ(GetPlayersAll()) <= 5)) then
            return false
        end
        return true
    end

    function Trig_Niffy_Lockdown_Actions()
        if (Trig_Niffy_Lockdown_Func002C()) then
            return
        else
        end
        if (Trig_Niffy_Lockdown_Func003C()) then
            -- Niffy Lockdown!
            udg_IsNiffyLockdownActive = true
            -- ---
            -- Max Evil EP
            udg_UpgradePointsAlien = 4000.00
            udg_UpgradePointsMutant = 4000.00
            -- Create Solace Shop
            udg_TempPoint = Location(-14550.00, -7510.00)
            CreateNUnitsAtLoc(1, FourCC('h017'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
            RemoveLocation(udg_TempPoint)
            -- Move all space pods away
            udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('h02O'))
            ForGroupBJ(udg_TempUnitGroup, Trig_Niffy_Lockdown_Func003Func013A)
            DestroyGroup(udg_TempUnitGroup)
            -- Move all raptors away
            udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('h001'))
            ForGroupBJ(udg_TempUnitGroup, Trig_Niffy_Lockdown_Func003Func017A)
            DestroyGroup(udg_TempUnitGroup)
            -- Move all obdas away
            udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('h02K'))
            ForGroupBJ(udg_TempUnitGroup, Trig_Niffy_Lockdown_Func003Func021A)
            DestroyGroup(udg_TempUnitGroup)
            -- Random Events not triggering
            udg_RandomEvent_On[2] = true
            udg_RandomEvent_On[4] = true
            udg_RandomEvent_On[5] = true
            udg_RandomEvent_On[9] = true
            udg_RandomEvent_On[10] = true
            udg_RandomEvent_On[12] = true
            udg_RandomEvent_On[13] = true
            -- Wipe blood tests
            BloodTestingWipe()
            -- Move players to starting location (and move camera there)
            udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('h00H'))
            ForGroupBJ(udg_TempUnitGroup, Trig_Niffy_Lockdown_Func003Func035A)
            DestroyGroup(udg_TempUnitGroup)
            -- Disable Space Alien and Space Overlord
            -- Credits to tal for this
            ForForce(GetPlayersAll(), Trig_Niffy_Lockdown_Func003Func039A)
            -- Say to players that its niffy lockdown
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5194")
        else
        end
    end

    --===========================================================================
    gg_trg_Niffy_Lockdown = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Niffy_Lockdown, 2.00)
    TriggerAddAction(gg_trg_Niffy_Lockdown, Trig_Niffy_Lockdown_Actions)
end)
if Debug then Debug.endFile() end
