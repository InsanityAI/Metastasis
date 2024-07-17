if Debug then Debug.beginFile "Game/Abilities/Items/BurstGrenade" end
OnInit.map("BurstGrenade", function(require)
    ---@return boolean
    function Trig_BGrenade_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06O'))) then
            return false
        end
        return true
    end

    function BGrenade_Slide()
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
        --if IsPointPathable(GetLocationX(b), GetLocationY(b), false) == false then
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

    function Trig_BGrenade_Actions()
        local k        = CreateTimer() ---@type timer
        local r ---@type real
        local p        = GetSpellAbilityUnit() ---@type unit
        udg_TempPoint  = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetSpellTargetLoc()
        r              = DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2)
        if r > 900.0 then
            r = 900.0
        end
        SetUnitAnimation(GetSpellAbilityUnit(), "spell throw")
        SaveReal(LS(), GetHandleId(k), StringHash("height"), GetLocationZ(udg_TempPoint))
        SaveReal(LS(), GetHandleId(k), StringHash("force"), r / 900.0 * 225 / 25.0 * GetRandomReal(0.5, 2))
        udg_TempBool = false
        CreateNUnitsAtLoc(1, FourCC('e007'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) + GetRandomReal(-15.0, 15.0))
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
        TimerStart(k, 0.04, true, BGrenade_Slide)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), GetUnitFacing(GetLastCreatedUnit()))
        SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), 500.0 + GetRandomReal(-150.0, 150.0))
        UnitAddAbility(GetLastCreatedUnit(), FourCC('A03G'))
        UnitApplyTimedLife(GetLastCreatedUnit(), FourCC('B000'), 4 + GetRandomReal(-0.6, 0.6))
    end

    function BGrenade()
        local i = 0 ---@type integer
        while i <= 7 do
            Trig_BGrenade_Actions()
            i = i + 1
        end
    end

    --===========================================================================
    gg_trg_BurstGrenade = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_BurstGrenade, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_BurstGrenade, Condition(Trig_BGrenade_Conditions))
    TriggerAddAction(gg_trg_BurstGrenade, BGrenade)
end)
if Debug then Debug.endFile() end
