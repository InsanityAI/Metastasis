if Debug then Debug.beginFile "Game/Stations/Moon/MoonAttack" end
OnInit.map("MoonAttack", function(require)
    ---@return boolean
    function Trig_MoonAttack_Conditions()
        if (not (GetEventDamage() >= 1.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MoonAttack_Func004C()
        if (not (udg_Moon_TakingDamage == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MoonAttack_Func008Func001C()
        if (not (GetEnumUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])) then
            return false
        end
        if (not (udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == 0)) then
            return false
        end
        return true
    end

    function Trig_MoonAttack_Func008A()
        if (Trig_MoonAttack_Func008Func001C()) then
            ForceAddPlayerSimple(GetOwningPlayer(GetEnumUnit()), udg_Moon_PGroup)
            CameraSetEQNoiseForPlayer(GetOwningPlayer(GetEnumUnit()), 3)
        else
        end
    end

    function Trig_MoonAttack_Func010A()
        DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 5.00, "|cffFF0000Errun under attack!|r")
    end

    ---@return boolean
    function Trig_MoonAttack_Func012Func001C()
        if (not (udg_Player_TetrabinLevel[GetConvertedPlayerId(GetEnumPlayer())] == 0)) then
            return false
        end
        return true
    end

    function Trig_MoonAttack_Func012A()
        if (Trig_MoonAttack_Func012Func001C()) then
            CameraClearNoiseForPlayer(GetEnumPlayer())
        else
        end
    end

    function Trig_MoonAttack_Actions()
        DisableTrigger(GetTriggeringTrigger())
        if (Trig_MoonAttack_Func004C()) then
            SetStackedSoundBJ(true, gg_snd_WWII_submarine_dive_klaxon, gg_rct_MoonRect)
            udg_Moon_TakingDamage = true
        else
        end
        StartTimerBJ(udg_Moon_ResetAlarm, false, 10.00)
        ForceClear(udg_Moon_PGroup)
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_MoonRect)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_MoonRect), Trig_MoonAttack_Func008A)
        DestroyGroup(udg_TempUnitGroup)
        ForForce(udg_Moon_PGroup, Trig_MoonAttack_Func010A)
        PolledWait(5.00)
        ForForce(udg_Moon_PGroup, Trig_MoonAttack_Func012A)
        EnableTrigger(gg_trg_MoonAttack)
    end

    --===========================================================================
    gg_trg_MoonAttack = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_MoonAttack, gg_unit_h03T_0209, EVENT_UNIT_DAMAGED)
    TriggerAddCondition(gg_trg_MoonAttack, Condition(Trig_MoonAttack_Conditions))
    TriggerAddAction(gg_trg_MoonAttack, Trig_MoonAttack_Actions)
end)
if Debug then Debug.endFile() end
