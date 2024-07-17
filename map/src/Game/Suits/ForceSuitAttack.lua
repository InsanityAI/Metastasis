if Debug then Debug.beginFile "Game/Suits/ForceSuitAttack" end
OnInit.trig("ForceSuitAttack", function(require)
    ---@return boolean
    function Trig_ForceSuitAttack_Conditions()
        return GetUnitTypeId(GetAttacker()) == FourCC('h03L') and
            not udg_ForceSuit_LastAttackTime[GetUnitUserData(GetAttacker())]
    end

    function ForceSuitAttack_Slide()
        local k = GetExpiredTimer() ---@type timer
        local l = LoadUnitHandle((udg_hash), GetHandleId(k), StringHash("slide")) ---@type unit -- INLINED!!
        local a = GetUnitLoc(l) ---@type location
        local b = PolarProjectionBJ(a, 45.0, GetUnitFacing(l)) ---@type location
        local c = LoadReal((udg_hash), GetHandleId(l), StringHash("angle")) ---@type real -- INLINED!!
        local s = LoadInteger((udg_hash), GetHandleId(l), StringHash("sector")) ---@type integer -- INLINED!!

        if GetLocationZ(b) > GetLocationZ(a) + 60.0 then
            KillUnit(l)
        end
        --if IsTerrainWalkable(GetLocationX(b), GetLocationY(b)) == false then
        --call KillUnit(l)
        --endif
        if not (LocInSector(b, s)) then
            KillUnit(l)
        else
            SetUnitX(l, GetLocationX(b))
            SetUnitY(l, GetLocationY(b))
            --call SetUnitPositionLoc(l,b)
            SetUnitFacing(l, c)
        end
        RemoveLocation(b)
        RemoveLocation(a)
        if IsUnitDeadBJ(l) then
            PauseTimer(k)
            DestroyTimer(k)
        end
    end

    function ForceSuitAttack_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle((udg_hash), GetHandleId(t), StringHash("unit")) ---@type unit -- INLINED!!

        if GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 and LoadUnitHandle((udg_hash), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit() then -- INLINED!!
            KillUnit(a)
            UnitDamageTarget(a, GetTriggerUnit(), 30.0, true, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)

            --Apply Corporal buff
            if (GetUnitAbilityLevel(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(a))], udg_RoleAbility[10]) == 1) then
                UnitDamageTarget(a, GetTriggerUnit(), 5.0, true, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                    WEAPON_TYPE_WHOKNOWS)
            end

            if (GetUnitAbilityLevel(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(a))], FourCC('A097')) == 1) then
                Push2(GetTriggerUnit(), 300.0, 230.0, GetUnitFacing(a))
            else
                Push2(GetTriggerUnit(), 300.0, 230.0,
                    AngleBetweenUnits(GetTriggerUnit(), udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(a))]))
            end

            DestroyTrigger(t)
        end
    end

    function ForceSuitAttack_Dies()
        local q = GetTriggeringTrigger() ---@type trigger
        local t = LoadTriggerHandle((udg_hash), GetHandleId(q), StringHash("t")) ---@type trigger -- INLINED!!
        FlushChildHashtable((udg_hash), GetHandleId(GetTriggerUnit())) -- INLINED!!
        FlushChildHashtable((udg_hash), GetHandleId(q))                -- INLINED!!
        FlushChildHashtable((udg_hash), GetHandleId(t))                -- INLINED!!
        DestroyTrigger(q)
        DestroyTrigger(t)
    end

    function ForceSuitAttack_EnableAttack()
        local om                             = GetExpiredTimer() ---@type timer
        local unitId                         = LoadInteger((udg_hash), GetHandleId(om), StringHash("t")) ---@type integer
        udg_ForceSuit_LastAttackTime[unitId] = false
        om                                   = nil
    end

    function Trig_ForceSuitAttack_Actions()
        local k        = CreateTimer() ---@type timer
        local t        = CreateTrigger() ---@type trigger
        local q        = CreateTrigger() ---@type trigger
        local om       = CreateTimer() ---@type timer
        local ob ---@type location
        udg_TempPoint  = GetUnitLoc(GetAttacker())
        udg_TempPoint2 = GetUnitLoc(GetAttackedUnitBJ())
        udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint, -30.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        ob             = PolarProjectionBJ(udg_TempPoint3, 22.5,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) - 90.0)
        RemoveLocation(udg_TempPoint3)
        udg_TempPoint3 = ob
        udg_TempBool = false
        CreateNUnitsAtLoc(1, FourCC('e01J'), GetOwningPlayer(GetAttacker()), udg_TempPoint3,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        SaveInteger((udg_hash), GetHandleId(GetLastCreatedUnit()), StringHash("sector"), GetSector(udg_TempPoint)) -- INLINED!!
        SaveReal((udg_hash), GetHandleId(GetLastCreatedUnit()), StringHash("angle"),
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))                                                     -- INLINED!!
        TriggerRegisterUnitEvent(q, GetLastCreatedUnit(), EVENT_UNIT_DEATH)
        TriggerAddAction(q, ForceSuitAttack_Dies)
        SaveTriggerHandle((udg_hash), GetHandleId(q), StringHash("t"), t)                     -- INLINED!!
        SaveUnitHandle((udg_hash), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit()) -- INLINED!!
        TimerStart(k, 0.04, true, ForceSuitAttack_Slide)
        TriggerRegisterUnitInRangeSimple(t, 80.0, GetLastCreatedUnit())
        SaveUnitHandle((udg_hash), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit()) -- INLINED!!
        SaveUnitHandle((udg_hash), GetHandleId(t), StringHash("caster"), GetAttacker())      -- INLINED!!
        TriggerAddAction(t, ForceSuitAttack_Damage)
        SetUnitPathing(GetLastCreatedUnit(), false)
        SetUnitPositionLoc(GetLastCreatedUnit(), udg_TempPoint3)
        SetUnitX(GetLastCreatedUnit(), GetLocationX(udg_TempPoint3))
        SetUnitY(GetLastCreatedUnit(), GetLocationY(udg_TempPoint3))
        SaveInteger((udg_hash), GetHandleId(om), StringHash("t"), GetUnitUserData(GetAttacker())) -- INLINED!!
        SaveUnitHandle((udg_hash), GetHandleId(om), StringHash("a"), GetLastCreatedUnit())        -- INLINED!!
        TimerStart(om, 1.0, false, ForceSuitAttack_EnableAttack)
        udg_ForceSuit_LastAttackTime[(GetUnitUserData((GetAttacker())))] = true
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
    end

    --===========================================================================
    gg_trg_ForceSuitAttack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ForceSuitAttack, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_ForceSuitAttack, Condition(Trig_ForceSuitAttack_Conditions))
    TriggerAddAction(gg_trg_ForceSuitAttack, Trig_ForceSuitAttack_Actions)
end)
if Debug then Debug.endFile() end
