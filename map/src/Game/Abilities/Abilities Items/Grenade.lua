if Debug then Debug.beginFile "Game/Abilities/Items/Grenade" end
OnInit.trig("Grenade", function(require)
    require "IsTerrainWalkable"
    ---@return boolean
    function Trig_Grenade_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A01D'))) then
            return false
        end
        return true
    end

    ---@param x1 real
    ---@param y1 real
    ---@param offsetx real
    ---@param offsety real
    ---@param height real
    ---@return real
    function DetermineNormal(x1, y1, offsetx, offsety, height)
        local a = Location(x1, y1 + offsety) ---@type location
        --local location b=Location(x1+offsetx,y1)

        if GetLocationZ(a) > height then
            RemoveLocation(a)
            a = nil
            return 0.0
        else
            RemoveLocation(a)
            a = nil
            return 90.0
        end
    end

    function Grenade_Slide()
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

                --Else the collision is a result of the terrain
                --set height=GetLocationZ(b)
                --set zvelocity=-0.5*zvelocity
                --set c= 360+2*DetermineNormal(GetUnitX(l),GetUnitY(l),zforce*Cos(GetUnitFacing(l)*bj_DEGTORAD),zforce*Sin(GetUnitFacing(l)*bj_DEGTORAD),height)-c
            end
        end

        --if IsTerrainWalkable(GetLocationX(b), GetLocationY(b)) == false then
        --call KillUnit(l)
        --endif

        SetUnitPositionLoc(l, b)
        SetUnitFacing(l, c)
        RemoveLocation(b)
        RemoveLocation(a)

        if IsUnitDeadBJ(l) then
            PauseTimer(k)
            DestroyTimer(k)
        end

        SaveReal(LS(), GetHandleId(k), StringHash("height"), height + zvelocity / 25.0)
        SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), zvelocity - 40)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), c)
    end

    function Trig_Grenade_Actions()
        local k = CreateTimer() ---@type timer
        local r ---@type real
        local p = GetSpellAbilityUnit() ---@type unit

        if TimerGetElapsed(udg_GameTimer) - udg_Unit_LastGrenadeTime[GetUnitAN(p)] < 1.0 then
            DestroyTimer(k)
            return
        end

        udg_Unit_LastGrenadeTime[GetUnitAN(p)] = TimerGetElapsed(udg_GameTimer)
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetSpellTargetLoc()
        r = DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2)
        if r > 900.0 then
            r = 900.0
            udg_TempPoint4 = PolarProjectionBJ(udg_TempPoint, 900.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
            BasicAI_IssueDangerArea(udg_TempPoint4, 220.0, 2.1)
            RemoveLocation(udg_TempPoint4)
        else
            BasicAI_IssueDangerArea(udg_TempPoint2, 220.0, 2.1)
        end

        SetUnitAnimation(GetSpellAbilityUnit(), "spell throw")
        SaveReal(LS(), GetHandleId(k), StringHash("height"), GetLocationZ(udg_TempPoint))
        SaveReal(LS(), GetHandleId(k), StringHash("force"), r / 900.0 * 450 / 25.0)
        udg_TempBool = false
        CreateNUnitsAtLoc(1, FourCC('e007'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, Grenade_Slide)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), GetUnitFacing(GetLastCreatedUnit()))
        SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), 500.0)
    end

    --===========================================================================
    gg_trg_Grenade = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Grenade, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Grenade, Condition(Trig_Grenade_Conditions))
    TriggerAddAction(gg_trg_Grenade, Trig_Grenade_Actions)
end)
if Debug then Debug.endFile() end
