if Debug then Debug.beginFile "Game/Abilities/Items/MotionSensor" end
OnInit.trig("MotionSensor", function(require)
    ---@return boolean
    function Trig_MotionSensor_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A062'))) then
            return false
        end
        return true
    end

    function MotionSensor_Clean()
        local d = GetTriggeringTrigger() ---@type trigger
        local k = LoadTriggerHandle(LS(), GetHandleId(d), StringHash("k")) ---@type trigger
        FlushChildHashtable(LS(), GetHandleId(k))
        DestroyTrigger(k)
        FlushChildHashtable(LS(), GetHandleId(d))
        DestroyTrigger(d)
    end

    function MotionSensor_Trigger()
        local k = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(k), StringHash("u")) ---@type unit
        local q = GetUnitLoc(a) ---@type location

        if GetUnitPointValue(GetTriggerUnit()) ~= 37 and GetOwningPlayer(GetTriggerUnit()) ~= GetOwningPlayer(a) then
            SetSoundPositionLocBJ(gg_snd_WayPointBling, q, 100.0)
            PlaySoundBJ(gg_snd_WayPointBling)
            PingMinimapForPlayer(GetOwningPlayer(a), GetLocationX(q), GetLocationY(q), 4.0)
            DisplayTextToPlayer(GetOwningPlayer(a), 0, 0, "|cff0000FFSensors have detected an intruder.")
            StartSoundForPlayerBJ(GetOwningPlayer(a), gg_snd_Hint)
            DisableTrigger(k)
            PolledWait(4.0)
            EnableTrigger(k)
        end
        RemoveLocation(q)
        q = nil
    end

    function Trig_MotionSensor_Actions()
        local k  = CreateTrigger() ---@type trigger
        local d  = CreateTrigger() ---@type trigger
        local om = GetSpellTargetLoc() ---@type location
        local a  = CreateUnitAtLoc(GetOwningPlayer(GetSpellAbilityUnit()), FourCC('h045'), om, GetRandomDirectionDeg()) ---@type unit
        RemoveLocation(om)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("u"), a)
        SaveTriggerHandle(LS(), GetHandleId(d), StringHash("k"), k)
        TriggerAddAction(d, MotionSensor_Clean)
        TriggerRegisterDeathEvent(d, a)
        TriggerRegisterUnitInRangeSimple(k, 325.0, a)
        TriggerAddAction(k, MotionSensor_Trigger)
        SetUnitColor(a, ConvertPlayerColor(12))
    end

    --===========================================================================
    gg_trg_MotionSensor = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MotionSensor, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_MotionSensor, Condition(Trig_MotionSensor_Conditions))
    TriggerAddAction(gg_trg_MotionSensor, Trig_MotionSensor_Actions)
end)
if Debug then Debug.endFile() end
