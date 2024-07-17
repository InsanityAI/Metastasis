if Debug then Debug.beginFile "Game/Abilities/Mutant/Charge" end
OnInit.trig("Charge", function(require)
    ---@return boolean
    function Trig_Charge_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A08R'))) then
            return false
        end
        return true
    end

    function Charge_DragAlong()
        local x ---@type real
        local y ---@type real
        if LoadBoolean(LS(), GetHandleId(GetEnumUnit()), StringHash("DragGroupDraggable_" .. I2S(GetUnitAN(udg_TempUnit2)))) then
            x = GetUnitX(udg_TempUnit2) +
                LoadReal(LS(), GetHandleId(GetEnumUnit()),
                    StringHash("DragGroupXOffset_" .. I2S(GetUnitAN(udg_TempUnit2))))
            y = GetUnitY(udg_TempUnit2) +
                LoadReal(LS(), GetHandleId(GetEnumUnit()),
                    StringHash("DragGroupYOffset_" .. I2S(GetUnitAN(udg_TempUnit2))))
            if IsTerrainWalkable(x, y) then
                SetUnitX(GetEnumUnit(), x)
                SetUnitY(GetEnumUnit(), y)
            else
                UnitDamageTarget(udg_TempUnit2, GetEnumUnit(), 155, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                    WEAPON_TYPE_WHOKNOWS)
                bj_lastCreatedEffect = AddSpecialEffectTarget(
                    "Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", GetEnumUnit(), "origin")
                SFXThreadClean()
                SaveBoolean(LS(), GetHandleId(GetEnumUnit()),
                    StringHash("DragGroupDraggable_" .. I2S(GetUnitAN(udg_TempUnit2))), false)
            end
        end
    end

    function Charge_Slide()
        local k = GetExpiredTimer() ---@type timer
        local l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) ---@type unit
        local a = GetUnitLoc(l) ---@type location
        local b = PolarProjectionBJ(a, 25.0, GetUnitFacing(l)) ---@type location
        local g = LoadGroupHandle(LS(), GetHandleId(k), StringHash("draggroup")) ---@type group
        local i = LoadInteger(LS(), GetHandleId(k), StringHash("i")) ---@type integer
        --local integer r=LoadInteger(LS(),GetHandleId(k),StringHash("r"))
        PauseUnit(l, true)
        if i == 0 then
            PlaySound3D("Sound\\Units\\Footsteps\\Step1.wav", GetLocationX(b), GetLocationY(b))
            i = 10
        end
        --if r == 0 then

        --et r=12
        --endif
        SaveInteger(LS(), GetHandleId(k), StringHash("i"), i - 1)
        --call SaveInteger(LS(),GetHandleId(k),StringHash("r"),r-1)
        EnumDestructablesInCircleBJ(150.0, b, RubbleDestroy)

        if IsTerrainWalkable(GetLocationX(b), GetLocationY(b)) == false or LoadBoolean(LS(), GetHandleId(k), StringHash("over")) then
            DestroyTrigger(LoadTriggerHandle(LS(), GetHandleId(k), StringHash("trig")))
            FlushChildHashtable(LS(), GetHandleId(k))
            PauseTimer(k)
            DestroyTimer(k)
            DestroyGroup(g)
            PauseUnit(l, false)
            SetUnitTimeScale(l, 1.0)
            SetUnitAnimation(l, "stand")
        end

        RemoveLocation(a)
        SetUnitX(l, GetLocationX(b))
        SetUnitY(l, GetLocationY(b))
        RemoveLocation(b)
        udg_TempUnit2 = l
        ForGroup(g, Charge_DragAlong)
    end

    function Charge_Damage()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local b = GetTriggerUnit() ---@type unit
        local g = LoadGroupHandle(LS(), GetHandleId(t), StringHash("draggroup")) ---@type group
        if not (IsUnitInGroup(b, g)) and GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 then
            UnitDamageTarget(a, GetTriggerUnit(), 155, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
            GroupAddUnit(g, b)
            SaveReal(LS(), GetHandleId(b), StringHash("DragGroupXOffset_" .. I2S(GetUnitAN(a))),
                GetUnitX(b) - GetUnitX(a))
            SaveReal(LS(), GetHandleId(b), StringHash("DragGroupYOffset_" .. I2S(GetUnitAN(a))),
                GetUnitY(b) - GetUnitY(a))
            SaveBoolean(LS(), GetHandleId(b), StringHash("DragGroupDraggable_" .. I2S(GetUnitAN(a))), true)
            bj_lastCreatedEffect = AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl",
                b, "origin")
            SFXThreadClean()
        end
    end

    function Trig_Charge_Actions()
        local b        = GetSpellAbilityUnit() ---@type unit
        local k        = CreateTimer() ---@type timer
        local t        = CreateTrigger() ---@type trigger
        local g        = CreateGroup() ---@type group
        udg_TempPoint  = GetUnitLoc(b)
        udg_TempPoint2 = GetSpellTargetLoc()
        udg_TempBool   = false
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
        SaveInteger(LS(), GetHandleId(k), StringHash("i"), 0)
        -- call SaveInteger(LS(),GetHandleId(k),StringHash("r"),0)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), b)
        SaveGroupHandle(LS(), GetHandleId(k), StringHash("draggroup"), g)
        SaveGroupHandle(LS(), GetHandleId(t), StringHash("draggroup"), g)
        TimerStart(k, 0.04, true, Charge_Slide)
        SaveTriggerHandle(LS(), GetHandleId(k), StringHash("trig"), t)
        TriggerRegisterUnitInRangeSimple(t, 100.0, b)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), b)
        TriggerAddAction(t, Charge_Damage)
        SaveBoolean(LS(), GetHandleId(k), StringHash("over"), false)
        PauseUnitForPeriod(b, 3.5)
        SetUnitTimeScale(b, 2.0)
        SetUnitAnimationByIndex(b, 3)
        PolledWait(3.5)
        SaveBoolean(LS(), GetHandleId(k), StringHash("over"), true)
    end

    --===========================================================================
    gg_trg_Charge = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Charge, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Charge, Condition(Trig_Charge_Conditions))
    TriggerAddAction(gg_trg_Charge, Trig_Charge_Actions)
end)
if Debug then Debug.endFile() end
