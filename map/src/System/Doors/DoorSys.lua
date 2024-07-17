if Debug then Debug.beginFile "System/Doors/DoorSys" end
OnInit.map("DoorSys", function(require)
    require "LS"
    ---@param d destructable
    function DoorOpen_Malfunction(d)
        local dp             = LoadDestructableHandle(LS(), GetHandleId(d), StringHash("doorpath")) ---@type destructable
        local destroytrigger = LoadTriggerHandle(LS(), GetHandleId(d), StringHash("destroytrigger")) ---@type trigger
        SaveBoolean(LS(), GetHandleId(d), StringHash("isopen"), true)
        SaveReal(LS(), GetHandleId(d), StringHash("life"), GetDestructableLife(d))
        DisableTrigger(destroytrigger)
        KillDestructable(d)
        EnableTrigger(destroytrigger)
        KillDestructable(dp)
        SetDestructableAnimationSpeed(d, 0.5)
        SetDestructableAnimation(d, "morph")
    end

    function DoorSlam_Knockback()
        local a = GetUnitLoc(GetEnumUnit()) ---@type location
        local b ---@type boolean
        if udg_TempInt == 1 then
            --Horizontal door
            b = RAbsBJ(GetLocationY(a) - GetLocationY(udg_TempPoint)) < 55.0
        else
            --Vertical door
            b = RAbsBJ(GetLocationX(a) - GetLocationX(udg_TempPoint)) < 55.0
        end
        if b then
            if GetUnitState(GetEnumUnit(), UNIT_STATE_LIFE) <= 175.0 then
                SetUnitState(GetEnumUnit(), UNIT_STATE_LIFE, 1.0)
            else
                UnitDamageTarget(udg_TheNullUnit, GetEnumUnit(), 225.0, false, false, ATTACK_TYPE_NORMAL,
                    DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            end
            Push2(GetEnumUnit(), 625.0, 525.0, AngleBetweenPoints(udg_TempPoint, a))
            AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl",
                GetEnumUnit(), "origin")
            SFXThreadClean()
            RemoveLocation(a)
        end
    end

    ---@param d destructable
    function DoorClose_Malfunction(d)
        local dp     = LoadDestructableHandle(LS(), GetHandleId(d), StringHash("doorpath")) ---@type destructable
        local o      = GetDestructableLoc(d) ---@type location
        local g      = GetUnitsInRangeOfLocAll(125.0, o) ---@type group
        local isopen = LoadBoolean(LS(), GetHandleId(d), StringHash("isopen")) ---@type boolean
        local life   = LoadReal(LS(), GetHandleId(d), StringHash("life")) ---@type real
        if isopen then
            if life == 0 then
                life = GetDestructableMaxLife(d)
            end
            SaveBoolean(LS(), GetHandleId(d), StringHash("isopen"), false)
            SetDestructableAnimationSpeed(d, 2.0)
            DestructableRestoreLife(d, GetDestructableMaxLife(d), true)
            SetDestructableLife(d, life)
            DestructableRestoreLife(dp, GetDestructableMaxLife(dp), true)
            SetDestructableAnimation(d, "morph alternate")
            udg_TempPoint = o
            PlaySound3D("Sound\\Units\\Combat\\MetalHeavyBashMetal1.wav", GetLocationX(o), GetLocationY(o))
            if (GetDestructableTypeId(d) == FourCC('B000')) then
                udg_TempInt = 1
            else
                udg_TempInt = 0
            end
            ForGroup(g, DoorSlam_Knockback)
        end
        RemoveLocation(o)
        DestroyGroup(g)
    end

    function DoorOpen()
        local t              = GetTriggeringTrigger() ---@type trigger
        --local integer clearance = GetHandleInt(t, "clearance")
        local clearance      = LoadInteger(LS(), GetHandleId(t), StringHash("clearance")) ---@type integer
        --local destructable door = GetHandleDestructable(t, "door")
        local door           = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("door")) ---@type destructable
        --local destructable doorpath=GetHandleDestructable(t, "doorpath")
        local doorpath       = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("doorpath")) ---@type destructable
        --local trigger destroytrigger= GetHandleTrigger(t, "destroytrigger")
        local destroytrigger = LoadTriggerHandle(LS(), GetHandleId(t), StringHash("destroytrigger")) ---@type trigger
        if GetDestructableLife(door) <= 0 then
            return
        end
        if clearance ~= 0 then
            if UnitHasItemOfTypeBJ(GetTriggerUnit(), clearance) or GetUnitTypeId(GetTriggerUnit()) == FourCC('h037') or GetUnitTypeId(GetTriggerUnit()) == FourCC('h039') then
                --call SetHandleReal(door, "life", GetDestructableLife(door))
                SaveReal(LS(), GetHandleId(door), StringHash("life"), GetDestructableLife(door))
                --call SetHandleBoolean(door, "isopen", true)
                SaveBoolean(LS(), GetHandleId(door), StringHash("isopen"), true)
                DisableTrigger(destroytrigger)
                KillDestructable(door)
                EnableTrigger(destroytrigger)
                KillDestructable(doorpath)
                SetDestructableAnimation(door, "morph")
            end
        else
            --call SetHandleBoolean(door, "isopen", true)
            SaveBoolean(LS(), GetHandleId(door), StringHash("isopen"), true)
            --call SetHandleReal(door, "life", GetDestructableLife(door))
            SaveReal(LS(), GetHandleId(door), StringHash("life"), GetDestructableLife(door))
            DisableTrigger(destroytrigger)
            KillDestructable(door)
            EnableTrigger(destroytrigger)
            SetDestructableAnimation(door, "morph")
        end
    end

    function DoorClose()
        local t              = GetTriggeringTrigger() ---@type trigger
        --local rect r=GetHandleRect(t, "rect")
        local r              = LoadRectHandle(LS(), GetHandleId(t), StringHash("rect")) ---@type rect
        --local integer clearance = GetHandleInt(t, "clearance")
        local clearance      = LoadInteger(LS(), GetHandleId(t), StringHash("clearance")) ---@type integer
        --local destructable door = GetHandleDestructable(t, "door")
        local door           = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("door")) ---@type destructable
        --local destructable doorpath=GetHandleDestructable(t, "doorpath")
        local doorpath       = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("doorpath")) ---@type destructable
        --local trigger destroytrigger= GetHandleTrigger(t, "destroytrigger")
        local destroytrigger = LoadTriggerHandle(LS(), GetHandleId(t), StringHash("destroytrigger")) ---@type trigger
        local z              = GetUnitsInRectAll(r) ---@type group
        --local boolean isopen=GetHandleBoolean(door, "isopen")
        local isopen         = LoadBoolean(LS(), GetHandleId(door), StringHash("isopen")) ---@type boolean
        if (CountUnitsInGroup(z) == 0 or udg_TempDoorHack) and isopen then
            --call SetHandleBoolean(door, "isopen", false)
            SaveBoolean(LS(), GetHandleId(door), StringHash("isopen"), false)
            DestructableRestoreLife(door, GetDestructableMaxLife(door), true)
            SetDestructableLife(door, LoadReal(LS(), GetHandleId(door), StringHash("life")))
            SetDestructableAnimation(door, "morph alternate")
            if clearance ~= 0 then
                DestructableRestoreLife(doorpath, GetDestructableMaxLife(doorpath), true)
            end
        end
    end

    function DoorBustDown()
        local t         = GetTriggeringTrigger() ---@type trigger
        local door      = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("door")) ---@type destructable
        local doorpath  = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("doorpath")) ---@type destructable
        local dooropen  = LoadTriggerHandle(LS(), GetHandleId(t), StringHash("t1")) ---@type trigger
        local doorclose = LoadTriggerHandle(LS(), GetHandleId(t), StringHash("t2")) ---@type trigger
        DestroyTimer(LoadTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer")))
        DestroyTimer(LoadTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer2")))
        DestroyTrigger(GetTriggeringTrigger())
        KillDestructable(doorpath)
        DestroyTrigger(dooropen)
        DestroyTrigger(doorclose)
    end

    ---@param door destructable
    ---@param clearance integer
    function DoorRegisterClearance(door, clearance)
        local t = LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t1")) ---@type trigger
        local k = LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t2")) ---@type trigger
        SaveInteger(LS(), GetHandleId(t), StringHash("clearance"), clearance)
        SaveInteger(LS(), GetHandleId(k), StringHash("clearance"), clearance)
        udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t2"))
        udg_TempDoorHack = true
        TriggerExecute(udg_TempTrigger)
        udg_TempDoorHack = false
        if clearance ~= 0 then
            DestructableRestoreLife(
                LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")),
                999999, true)
        else
            KillDestructable(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger),
                StringHash("doorpath")))
        end
    end

    ---@param door destructable
    ---@param where rect
    ---@param clearance integer
    function RegisterSecurityDoor(door, where, clearance)
        local t = CreateTrigger() ---@type trigger
        local k = CreateTrigger() ---@type trigger
        local m = CreateTrigger() ---@type trigger
        local doorpath ---@type destructable
        if GetDestructableTypeId(door) == FourCC('B000') then
            doorpath = CreateDestructable(FourCC('B002'), GetDestructableX(door), GetDestructableY(door), 0,
                1.0, 1)
        else
            doorpath = CreateDestructable(FourCC('B004'), GetDestructableX(door), GetDestructableY(door), 0,
                1.0, 1)
        end

        if clearance == 0 then
            KillDestructable(doorpath)
        end
        TriggerRegisterEnterRectSimple(t, where)
        TriggerAddAction(t, DoorOpen)
        TriggerRegisterLeaveRectSimple(k, where)
        TriggerAddAction(k, DoorClose)
        TriggerRegisterDeathEvent(m, door)
        TriggerAddAction(m, DoorBustDown)
        SaveDestructableHandle(LS(), GetHandleId(t), StringHash("door"), door)
        SaveDestructableHandle(LS(), GetHandleId(t), StringHash("doorpath"), doorpath)
        SaveRectHandle(LS(), GetHandleId(t), StringHash("rect"), where)
        SaveInteger(LS(), GetHandleId(t), StringHash("clearance"), clearance)
        SaveDestructableHandle(LS(), GetHandleId(door), StringHash("doorpath"), doorpath)
        --I hate patch 1.24.
        SaveDestructableHandle(LS(), GetHandleId(k), StringHash("door"), door)
        SaveDestructableHandle(LS(), GetHandleId(k), StringHash("doorpath"), doorpath)
        SaveRectHandle(LS(), GetHandleId(k), StringHash("rect"), where)
        SaveInteger(LS(), GetHandleId(k), StringHash("clearance"), clearance)
        SaveDestructableHandle(LS(), GetHandleId(m), StringHash("door"), door)
        SaveDestructableHandle(LS(), GetHandleId(m), StringHash("doorpath"), doorpath)
        SaveRectHandle(LS(), GetHandleId(m), StringHash("rect"), where)
        SaveInteger(LS(), GetHandleId(m), StringHash("clearance"), clearance)
        SaveTriggerHandle(LS(), GetHandleId(m), StringHash("t1"), t)
        SaveTriggerHandle(LS(), GetHandleId(m), StringHash("t2"), k)
        SaveTriggerHandle(LS(), GetHandleId(door), StringHash("t1"), t)
        SaveTriggerHandle(LS(), GetHandleId(door), StringHash("t2"), k)
        SaveTriggerHandle(LS(), GetHandleId(t), StringHash("destroytrigger"), m)
        SaveTriggerHandle(LS(), GetHandleId(k), StringHash("destroytrigger"), m)
        SaveTriggerHandle(LS(), GetHandleId(door), StringHash("destroytrigger"), m)
    end

    function DoorMalfunction_Open()
        local k = GetExpiredTimer() ---@type timer
        local d = LoadDestructableHandle(LS(), GetHandleId(k), StringHash("d")) ---@type destructable
        DoorOpen_Malfunction(d)
        TimerStart(k, 2.25, false, DoorMalfunction_Open)
    end

    function DoorMalfunction_Slam()
        local k = GetExpiredTimer() ---@type timer
        local d = LoadDestructableHandle(LS(), GetHandleId(k), StringHash("d")) ---@type destructable
        DoorClose_Malfunction(d)
        TimerStart(k, 2.25, false, DoorMalfunction_Slam)
    end

    ---@param door destructable
    function DoorMalfunction_End(door)
        EnableTrigger(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t1")))
        EnableTrigger(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t2")))
        DestroyTimer(LoadTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer")))
        DestroyTimer(LoadTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer2")))
    end

    ---@param door destructable
    function DoorMalfunction(door)
        local k = CreateTimer() ---@type timer
        local j = CreateTimer() ---@type timer
        local o = GetDestructableLoc(door) ---@type location
        if LoadInteger(LS(), GetHandleId(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t1"))), StringHash("clearance")) ~= 0 then
            DestroyTimer(k)
            DestroyTimer(j)
            RemoveLocation(o)
            return
        end
        CreateNUnitsAtLoc(1, FourCC('e039'), Player(PLAYER_NEUTRAL_PASSIVE), o, bj_UNIT_FACING)
        RemoveLocation(o)
        DisableTrigger(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t1")))
        DisableTrigger(LoadTriggerHandle(LS(), GetHandleId(door), StringHash("t2")))
        SaveTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer"), k)
        SaveTimerHandle(LS(), GetHandleId(door), StringHash("malfunction_timer2"), j)
        SaveDestructableHandle(LS(), GetHandleId(k), StringHash("d"), door)
        SaveDestructableHandle(LS(), GetHandleId(j), StringHash("d"), door)
        SaveReal(LS(), GetHandleId(door), StringHash("life"), GetDestructableLife(door))
        TimerStart(k, 1.75, false, DoorMalfunction_Slam)
        TimerStart(j, 0.25, false, DoorMalfunction_Open)
    end
end)
if Debug then Debug.endFile() end
