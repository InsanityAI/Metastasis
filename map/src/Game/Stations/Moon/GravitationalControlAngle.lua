if Debug then Debug.beginFile "Game/Stations/Moon/GravitationalControlAngle" end
OnInit.trig("GravitationalControlAngle", function(require)
    ---@return boolean
    function Trig_GravitationalControlTarget_Copy_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A052'))) then
            return false
        end
        return true
    end

    function GC_Move()
        local i         = GetExpiredTimer() ---@type timer
        local angle     = LoadReal(LS(), GetHandleId(i), StringHash("angle")) ---@type real
        local handofgod = LoadLightningHandle(LS(), GetHandleId(i), StringHash("lightning")) ---@type lightning
        local tforce    = LoadReal(LS(), GetHandleId(i), StringHash("force")) ---@type real
        local target    = LoadUnitHandle(LS(), GetHandleId(i), StringHash("target")) ---@type unit

        udg_TempPoint   = GetUnitLoc(target)
        udg_TempPoint2  = PolarProjectionBJ(udg_TempPoint, tforce, angle)
        SetUnitPositionLoc(target, udg_TempPoint2)
        RemoveLocation(udg_TempPoint)
        udg_TempPoint = GetUnitLoc(gg_unit_h03T_0209)
        if RectContainsLoc(gg_rct_Space, udg_TempPoint) == true then
            MoveLightningEx(handofgod, false, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint), 0.0,
                GetLocationX(udg_TempPoint2), GetLocationY(udg_TempPoint2), 0.0)
        end
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        SaveReal(LS(), GetHandleId(i), StringHash("force"), tforce + 0.25)
    end

    function Trig_GravitationalControlTarget_Copy_Actions()
        local i ---@type timer
        local handofgod ---@type lightning
        local duration ---@type real
        if udg_GravitationalControl_Target ~= nil then
            i = CreateTimer()
            SaveUnitHandle(LS(), GetHandleId(i), StringHash("target"), udg_GravitationalControl_Target)
            udg_TempPoint = GetUnitLoc(gg_unit_h03T_0209)
            udg_TempPoint2 = GetUnitLoc(udg_GravitationalControl_Target)
            handofgod = AddLightningEx("LEAS", false, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint), 0,
                GetLocationX(udg_TempPoint2), GetLocationY(udg_TempPoint2), 0)
            SaveLightningHandle(LS(), GetHandleId(i), StringHash("lightning"), handofgod)
            SaveReal(LS(), GetHandleId(i), StringHash("force"), 0)
            RemoveLocation(udg_TempPoint)
            udg_TempPoint = GetSpellTargetLoc()
            SaveReal(LS(), GetHandleId(i), StringHash("angle"), AngleBetweenPoints(udg_TempPoint2, udg_TempPoint))
            duration = 4
            if GetUnitTypeId(udg_GravitationalControl_Target) ~= FourCC('h031') and GetUnitTypeId(udg_GravitationalControl_Target) ~= FourCC('h032') then
                --The point value of units in space divided by 100 is the factor by which they can be pushed. For space alien, special exception.
                --Lower point values = harder to push
                duration = duration * I2R(GetUnitPointValue(udg_GravitationalControl_Target)) / 100.0
            end
            RemoveLocation(udg_TempPoint)
            RemoveLocation(udg_TempPoint2)
            RemoveUnit(GetSpellAbilityUnit())
            DisplayTextToForce(GetPlayersAll(),
                "|cffFF8000GRAVITATIONAL CORRECTIONS ACTIVATED FOR " ..
                StringCase(GetUnitName(udg_GravitationalControl_Target), true) .. ".|r")
            PlaySoundBJ(gg_snd_CharmTarget1)
            -- call PolledWait(2.0)

            TimerStart(i, 0.04, true, GC_Move)


            PolledWait(duration)
            FlushChildHashtable(LS(), GetHandleId(i))
            PauseTimer(i)
            DestroyTimer(i)
            DestroyLightning(handofgod)
        end
    end

    --===========================================================================
    gg_trg_GravitationalControlAngle = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GravitationalControlAngle, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_GravitationalControlAngle, Condition(Trig_GravitationalControlTarget_Copy_Conditions))
    TriggerAddAction(gg_trg_GravitationalControlAngle, Trig_GravitationalControlTarget_Copy_Actions)
end)
if Debug then Debug.endFile() end
