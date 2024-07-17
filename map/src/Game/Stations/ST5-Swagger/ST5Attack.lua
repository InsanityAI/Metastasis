if Debug then Debug.beginFile "Game/Stations/ST5/ST5Attack" end
OnInit.map("ST5Attack", function(require)
    ---@return boolean
    function Trig_ST5Attack_Conditions()
        if (not (GetEventDamage() >= 1.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST5Attack_Func004C()
        if (not (udg_ST5_TakingDamage == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST5Attack_Func007Func001Func001C()
        if (not (GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST5Attack_Func007Func001C()
        if (not (GetEnumUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])) then
            return false
        end
        if (not (udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == 0)) then
            return false
        end
        return true
    end

    function Trig_ST5Attack_Func007A()
        if (Trig_ST5Attack_Func007Func001C()) then
            if (Trig_ST5Attack_Func007Func001Func001C()) then
                ForceAddPlayerSimple(udg_Parasite, udg_ST5_PGroup)
                CameraSetEQNoiseForPlayer(udg_Parasite, 3)
            else
                ForceAddPlayerSimple(GetOwningPlayer(GetEnumUnit()), udg_ST5_PGroup)
                CameraSetEQNoiseForPlayer(GetOwningPlayer(GetEnumUnit()), 3)
            end
        else
        end
    end

    function Trig_ST5Attack_Func008A()
        DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 5.00, "|cffFF0000U.S.I. Swagger under attack!|r")
    end

    ---@return boolean
    function Trig_ST5Attack_Func010Func001C()
        if (not (udg_Player_TetrabinLevel[GetConvertedPlayerId(GetEnumPlayer())] == 0)) then
            return false
        end
        return true
    end

    function Trig_ST5Attack_Func010A()
        if (Trig_ST5Attack_Func010Func001C()) then
            CameraClearNoiseForPlayer(GetEnumPlayer())
        else
        end
    end

    function Trig_ST5Attack_Actions()
        DisableTrigger(GetTriggeringTrigger())
        if (Trig_ST5Attack_Func004C()) then
            SetStackedSoundBJ(true, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST5)
            udg_ST5_TakingDamage = true
        else
        end
        StartTimerBJ(udg_ST5_ResetAlarm, false, 10.00)
        ForceClear(udg_ST5_PGroup)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_ST5), Trig_ST5Attack_Func007A)
        ForForce(udg_ST5_PGroup, Trig_ST5Attack_Func008A)
        PolledWait(5.00)
        ForForce(udg_ST5_PGroup, Trig_ST5Attack_Func010A)
        EnableTrigger(gg_trg_ST5Attack)
    end

    --===========================================================================
    gg_trg_ST5Attack = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST5Attack, gg_unit_h00X_0049, EVENT_UNIT_DAMAGED)
    TriggerAddCondition(gg_trg_ST5Attack, Condition(Trig_ST5Attack_Conditions))
    TriggerAddAction(gg_trg_ST5Attack, Trig_ST5Attack_Actions)
end)
if Debug then Debug.endFile() end
