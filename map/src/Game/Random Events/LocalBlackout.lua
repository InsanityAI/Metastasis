if Debug then Debug.beginFile "Game/RandomEvents/LocalBlackout" end
OnInit.trig("LocalBlackout", function(require)
    function Trig_LocalBlackout_Func014A()
        FogModifierStop(udg_SpaceVisibility[GetConvertedPlayerId(GetEnumPlayer())])
    end

    ---@return boolean
    function Trig_LocalBlackout_Func015Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('h04G'))) then
            return false
        end
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('h031'))) then
            return false
        end
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('h032'))) then
            return false
        end
        return true
    end

    function Trig_LocalBlackout_Func015A()
        if (Trig_LocalBlackout_Func015Func001C()) then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true)
        else
        end
    end

    function Trig_LocalBlackout_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[13] = true
        RemoveLocation(udg_TempPoint)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5195")
        PolledWait(5.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2568")
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 1200.00))
        StartTimerBJ(udg_BlackoutTimer, false, GetRandomReal(60.00, 60.00))
        CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_2569")
        udg_BlackoutTimerWindow = GetLastCreatedTimerDialogBJ()
        TimerDialogDisplayBJ(true, udg_BlackoutTimerWindow)
        udg_Blackout = true
        PlaySoundBJ(gg_snd_Warning01)
        ForForce(GetPlayersAll(), Trig_LocalBlackout_Func014A)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Space), Trig_LocalBlackout_Func015A)
        PolledWait(1.50)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2572")
        PolledWait(1.50)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2573")
        PolledWait(1.50)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2574")
        PolledWait(1.50)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2575")
        PolledWait(3.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2947")
        PolledWait(3.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2576")
        PolledWait(7.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2577")
        PolledWait(5.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2578")
        PolledWait(10.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2579")
        PolledWait(10.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2580")
    end

    --===========================================================================
    gg_trg_LocalBlackout = CreateTrigger()
    DisableTrigger(gg_trg_LocalBlackout)
    TriggerAddAction(gg_trg_LocalBlackout, Trig_LocalBlackout_Actions)
end)
if Debug then Debug.endFile() end
