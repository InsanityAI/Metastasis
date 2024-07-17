if Debug then Debug.beginFile "Game/Abilities/Suits/ForceVortex" end
OnInit.trig("ForceVortex", function(require)
    ---@return boolean
    function Trig_ForceVortex_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06A'))) then
            return false
        end
        return true
    end

    function ForceVortex_PushBack()
        local b = GetUnitLoc(GetEnumUnit()) ---@type location
        if GetUnitPointValue(GetEnumUnit()) ~= 37 and GetUnitAbilityLevel(GetEnumUnit(), FourCC('Aloc')) ~= 1 then
            Push2(GetEnumUnit(), 800.0, 400.0, AngleBetweenPoints(udg_TempPoint, b))
        end
        RemoveLocation(b)
        b = nil
    end

    function ForceVortex_Slide()
        local k         = GetExpiredTimer() ---@type timer
        local l         = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local zvelocity = LoadReal(LS(), GetHandleId(k), StringHash("zvelocity")) ---@type real
        local c         = LoadReal(LS(), GetHandleId(k), StringHash("angle")) ---@type real
        local height    = LoadReal(LS(), GetHandleId(k), StringHash("height")) ---@type real
        local zforce    = LoadReal(LS(), GetHandleId(k), StringHash("force")) ---@type real
        local a         = GetUnitLoc(l) ---@type location
        local b         = PolarProjectionBJ(a, zforce, c) ---@type location
        SetUnitFlyHeight(l, height - GetLocationZ(a), 0)
        if GetLocationZ(b) > height then
            --If the collision is a result of the projectile falling then...
            if GetLocationZ(a) == GetLocationZ(b) then
                height = GetLocationZ(b)
                zvelocity = -0.5 * zvelocity
            else
                if GetTerrainCliffLevelBJ(b) > GetTerrainCliffLevelBJ(a) then
                    KillUnit(l)
                end
            end
        end
        SetUnitPositionLoc(l, b)
        SetUnitFacing(l, c)
        RemoveLocation(b)
        RemoveLocation(a)
        if IsUnitDeadBJ(l) then
            PauseTimer(k)
            DestroyTimer(k)
            udg_TempUnit = l
            udg_TempPoint = GetUnitLoc(l)
            udg_TempUnitGroup = GetUnitsInRangeOfLocAll(220.0, udg_TempPoint)
            ForGroup(udg_TempUnitGroup, ForceVortex_PushBack)
            RemoveLocation(udg_TempPoint)
            DestroyGroup(udg_TempUnitGroup)
            CreateScaledEffect("war3mapImported\\IceSparks.mdx", 1, 6.0, GetUnitX(l), GetUnitY(l))
            SetSoundPosition(gg_snd_BlueFireBurst, GetUnitX(l), GetUnitY(l), 0)
            PlaySoundBJ(gg_snd_BlueFireBurst)
        end
        SaveReal(LS(), GetHandleId(k), StringHash("height"), height + zvelocity / 25.0)
        SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), zvelocity - 40)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), c)
    end

    function Trig_ForceVortex_Actions()
        local k        = CreateTimer() ---@type timer
        local r ---@type real
        udg_TempPoint  = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetSpellTargetLoc()
        r              = DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2)
        if r > 900.0 then
            r = 900.0
        end
        SetUnitAnimation(GetSpellAbilityUnit(), "spell throw")
        SaveReal(LS(), GetHandleId(k), StringHash("height"), GetLocationZ(udg_TempPoint))
        SaveReal(LS(), GetHandleId(k), StringHash("force"), r / 900.0 * 450 / 25.0)
        udg_TempBool = false
        CreateNUnitsAtLoc(1, FourCC('e01S'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, ForceVortex_Slide)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), GetUnitFacing(GetLastCreatedUnit()))
        SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), 600.0)
    end

    --===========================================================================
    gg_trg_ForceVortex = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ForceVortex, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ForceVortex, Condition(Trig_ForceVortex_Conditions))
    TriggerAddAction(gg_trg_ForceVortex, Trig_ForceVortex_Actions)
end)
if Debug then Debug.endFile() end
