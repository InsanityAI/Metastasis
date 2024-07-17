if Debug then Debug.beginFile "Game/Stations/ST3/ST3CannonProjectile" end
OnInit.map("ST3CannonProjectile", function(require)
    ---@return boolean
    function Trig_Cannon_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A005'))) then
            return false
        end
        return true
    end

    function Cannon_Slide()
        local k  = GetExpiredTimer() ---@type timer
        local l  = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a  = GetUnitLoc(l) ---@type location
        local oq = LoadUnitHandle(LS(), GetHandleId(k), StringHash("target")) ---@type unit
        local i  = GetUnitLoc(oq) ---@type location
        local q  = AngleBetweenPoints(a, i) ---@type real
        local b  = PolarProjectionBJ(a, 4.8, GetUnitFacing(l)) ---@type location
        if RectContainsUnit(gg_rct_Space, oq) == false then
            SaveUnitHandle(LS(), GetHandleId(k), StringHash("target"), gg_unit_h008_0196)
        end
        if IsUnitDeadBJ(oq) then
            oq = gg_unit_h008_0196
            SaveUnitHandle(LS(), GetHandleId(k), StringHash("target"), oq)
        end

        SetUnitX(l, GetLocationX(b))
        SetUnitY(l, GetLocationY(b))
        SetUnitFacingTimed(l, q, 0.75)
        RemoveLocation(b)
        RemoveLocation(a)
        RemoveLocation(i)
        if IsUnitDeadBJ(l) then
            PauseTimer(k)
            DestroyTimer(k)
        end
    end

    function Cannon_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local i = 0 ---@type integer
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local b = GetTriggerUnit() ---@type unit
        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitStation(GetTriggerUnit()) == true and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() and udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == false then
            SetUnitAnimation(a, "death")
            SizeUnitOverTime(a, 5.5, 3.0, 0.1, true)
            DestroyTrigger(t)
            DamageUnitOverTime(b, a, 5.0, 200000)
        end
    end

    function Cannon_Dies()
        local q = GetTriggeringTrigger() ---@type trigger
        local t = LoadTriggerHandle(LS(), GetHandleId(q), StringHash("t")) ---@type trigger
        local o = LoadTriggerHandle(LS(), GetHandleId(q), StringHash("o")) ---@type trigger
        FlushChildHashtable(LS(), GetHandleId(GetTriggerUnit()))
        FlushChildHashtable(LS(), GetHandleId(q))
        FlushChildHashtable(LS(), GetHandleId(t))
        FlushChildHashtable(LS(), GetHandleId(o))
        DestroyTrigger(q)
        DestroyTrigger(t)
        DestroyTrigger(o)
    end

    function Trig_Cannon_Actions()
        local k           = CreateTimer() ---@type timer
        local t           = CreateTrigger() ---@type trigger
        local q           = CreateTrigger() ---@type trigger
        local b           = GetSpellTargetUnit() ---@type unit
        local c           = GetSpellAbilityUnit() ---@type unit
        local kyoBallOfDoomUnit ---@type unit
        udg_TempPoint2    = GetUnitLoc(GetSpellTargetUnit())
        udg_TempPoint     = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint3    = PolarProjectionBJ(udg_TempPoint, 0.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        udg_TempBool      = false
        kyoBallOfDoomUnit = CreateUnitAtLoc(Player(15), FourCC('e00Z'), udg_TempPoint3,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        SetUnitFlyHeight(kyoBallOfDoomUnit, 60.0, 100.0)
        SaveReal(LS(), GetHandleId(kyoBallOfDoomUnit), StringHash("angle"),
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))

        TriggerRegisterUnitEvent(q, kyoBallOfDoomUnit, EVENT_UNIT_DEATH)
        TriggerAddAction(q, Cannon_Dies)
        SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t)
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), kyoBallOfDoomUnit)
        TimerStart(k, 0.04, true, Cannon_Slide)
        TriggerRegisterUnitInRangeSimple(t, 100.0, kyoBallOfDoomUnit)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("target"), b)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), kyoBallOfDoomUnit)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), c)
        TriggerAddAction(t, Cannon_Damage)
        SetUnitPathing(kyoBallOfDoomUnit, false)

        -- Who the fuck added these 4 lines, not only does the KYO missile hang in the air for 40 seconds
        -- before firing off, but also it makes HP Bars disappear! And because of the condition it activates only for 1.29+ versions!
        -- if (JASS_MAX_ARRAY_SIZE > 8200) then
        --     call PolledWait(40.0)//Ytrec, this line literally crashes reforge. I hope you notice it :P
        --     call EnablePreSelect( false, false )
        -- endif
    end

    --===========================================================================
    gg_trg_ST3CannonProjectile = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ST3CannonProjectile, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ST3CannonProjectile, Condition(Trig_Cannon_Conditions))
    TriggerAddAction(gg_trg_ST3CannonProjectile, Trig_Cannon_Actions)
end)
if Debug then Debug.endFile() end
