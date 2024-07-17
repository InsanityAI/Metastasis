if Debug then Debug.beginFile "Game/Stations/ST1/ST1Attack" end
OnInit.trig("ST1Attack", function(require)
    ---@return boolean
    function Trig_ST1Attack_Conditions()
        if (not (GetEventDamage() >= 1.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST1Attack_Func004C()
        if (not (udg_ST1_TakingDamage == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST1Attack_Func007Func001Func001C()
        if (not (GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST1Attack_Func007Func001C()
        if (not (GetEnumUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])) then
            return false
        end
        if (not (udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == 0)) then
            return false
        end
        return true
    end

    function Trig_ST1Attack_Func007A()
        if (Trig_ST1Attack_Func007Func001C()) then
            if (Trig_ST1Attack_Func007Func001Func001C()) then
                ForceAddPlayerSimple(udg_Parasite, udg_ST1_PGroup)
                CameraSetEQNoiseForPlayer(udg_Parasite, 3)
            else
                ForceAddPlayerSimple(GetOwningPlayer(GetEnumUnit()), udg_ST1_PGroup)
                CameraSetEQNoiseForPlayer(GetOwningPlayer(GetEnumUnit()), 3)
            end
        else
        end
    end

    function Trig_ST1Attack_Func008A()
        DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 5.00, "TRIGSTR_5330")
    end

    ---@return boolean
    function Trig_ST1Attack_Func010Func001C()
        if (not (udg_Player_TetrabinLevel[GetConvertedPlayerId(GetEnumPlayer())] == 0)) then
            return false
        end
        return true
    end

    function Trig_ST1Attack_Func010A()
        if (Trig_ST1Attack_Func010Func001C()) then
            CameraClearNoiseForPlayer(GetEnumPlayer())
        else
        end
    end

    function Trig_ST1Attack_Actions()
        DisableTrigger(GetTriggeringTrigger())
        if (Trig_ST1Attack_Func004C()) then
            SetStackedSoundBJ(true, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST1)
            udg_ST1_TakingDamage = true
        else
        end
        StartTimerBJ(udg_ST1_ResetAlarm, false, 10.00)
        ForceClear(udg_ST1_PGroup)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_ST1), Trig_ST1Attack_Func007A)
        ForForce(udg_ST1_PGroup, Trig_ST1Attack_Func008A)
        PolledWait(5.00)
        ForForce(udg_ST1_PGroup, Trig_ST1Attack_Func010A)
        EnableTrigger(gg_trg_ST1Attack)
    end

    --===========================================================================
    gg_trg_ST1Attack = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST1Attack, gg_unit_h003_0018, EVENT_UNIT_DAMAGED)
    TriggerAddCondition(gg_trg_ST1Attack, Condition(Trig_ST1Attack_Conditions))
    TriggerAddAction(gg_trg_ST1Attack, Trig_ST1Attack_Actions)
end)
if Debug then Debug.endFile() end
