if Debug then Debug.beginFile "Game/Abilities/Suits/LightningStorm" end
OnInit.trig("LightningStorm", function(require)
    ---@return boolean
    function Trig_LightningStorm_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A092'))) then
            return false
        end
        return true
    end

    ---@param q unit
    ---@param consider unit
    ---@return real
    function LightningAI_ScoreUnit(q, consider)
        local retz = 0.0 ---@type real
        retz       = retz - DistanceBetweenUnits(consider, q) / 600.0
        retz       = retz - 5 * B2I(IsUnitType(consider, UNIT_TYPE_STRUCTURE))
        return retz
    end

    ---@param q unit
    ---@return unit
    function LightningRange_ConsiderTargets(q)
        --Considers all groups within a range of acquirerange and returns the best target, will return null if none
        local g ---@type group
        local m ---@type group
        local acquirerange = 350.0 ---@type real
        local target       = nil ---@type unit
        local consider ---@type unit
        local score ---@type real
        local a ---@type location
        a                  = GetUnitLoc(q)
        g                  = GetUnitsInRangeOfLocAll(acquirerange, a)
        RemoveLocation(a)
        m = CreateGroup()
        while not (FirstOfGroup(g) == nil) do
            consider = FirstOfGroup(g)
            if consider ~= q and GetUnitAbilityLevel(consider, FourCC('Avul')) == 0 and IsUnitAliveBJ(consider) and GetUnitTypeId(consider) ~= FourCC('n00A') then
                GroupAddUnit(m, consider)
            end
            GroupRemoveUnit(g, consider)
        end
        DestroyGroup(g)
        if CountUnitsInGroup(m) > 0 then
            if CountUnitsInGroup(m) > 1 then
                score = -999
                while not (FirstOfGroup(m) == nil) do
                    consider = FirstOfGroup(m)
                    if score <= LightningAI_ScoreUnit(q, consider) then
                        target = consider
                        score = LightningAI_ScoreUnit(q, consider)
                    end
                    GroupRemoveUnit(m, consider)
                end
            else
                target = FirstOfGroup(m)
            end
        end
        DestroyGroup(m)
        return target
    end

    function LightningStorm_Callback()
        local t          = GetExpiredTimer() ---@type timer
        local target     = nil ---@type unit
        local lasttarget = LoadUnitHandle(LS(), GetHandleId(t), StringHash("lt")) ---@type unit
        local l          = LoadUnitHandle(LS(), GetHandleId(t), StringHash("l")) ---@type unit
        if IsUnitDeadBJ(l) then
            PauseTimer(t)
            FlushChildHashtable(LS(), GetHandleId(t))
            DestroyTimer(t)
            PolledWait(4.0)
            RemoveUnit(l)
        else
            target = LightningRange_ConsiderTargets(l)
            if target ~= lasttarget then
                IssueTargetOrder(l, "attack", target)
                lasttarget = target
                SaveUnitHandle(LS(), GetHandleId(t), StringHash("lt"), lasttarget)
            end
        end
    end

    ---@param l unit
    function LightningStorm(l)
        local target     = nil ---@type unit
        local lasttarget = nil ---@type unit
        local t          = CreateTimer() ---@type timer
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("l"), l)
        TimerStart(t, 0.5, true, LightningStorm_Callback)
    end

    function LightningStorm_Slide()
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
                zvelocity = -1.0 * zvelocity
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
            bj_lastCreatedUnit = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('h01Q'), udg_TempPoint,
                GetRandomDirectionDeg())
            LightningStorm(GetLastCreatedUnit())
            RemoveLocation(udg_TempPoint)
            DestroyGroup(udg_TempUnitGroup)
            CreateScaledEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl", 4.0, 4.0, GetUnitX(l), GetUnitY(l))
            return
        end
        SaveReal(LS(), GetHandleId(k), StringHash("height"), height + zvelocity / 25.0)
        SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), zvelocity - 50)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), c)
    end

    function Trig_LightningStorm_Actions()
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
        SaveReal(LS(), GetHandleId(k), StringHash("force"), r / 900.0 * 675 / 25.0)
        udg_TempBool = false
        CreateNUnitsAtLoc(1, FourCC('e037'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, LightningStorm_Slide)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), GetUnitFacing(GetLastCreatedUnit()))
        SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), 450.0)
    end

    --===========================================================================
    gg_trg_LightningStorm = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_LightningStorm, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_LightningStorm, Condition(Trig_LightningStorm_Conditions))
    TriggerAddAction(gg_trg_LightningStorm, Trig_LightningStorm_Actions)
end)
if Debug then Debug.endFile() end
