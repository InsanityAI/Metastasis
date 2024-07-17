if Debug then Debug.beginFile "Libraries/Genstation/GenStation" end
OnInit.map("Libraries/Genstation/GenStation", function(require)
    ---@param console unit
    function ConsoleDisable(console)
        if HaveSavedHandle(LS(), GetHandleId(console), StringHash("EnterTrigger")) then
            DisableTrigger(LoadTriggerHandle(LS(), GetHandleId(console), StringHash("EnterTrigger")))
        end

        SetUnitOwner(console, Player(PLAYER_NEUTRAL_PASSIVE), true)
        SetUnitOwner(LoadUnitHandle(LS(), GetHandleId(console), StringHash("space")), Player(PLAYER_NEUTRAL_PASSIVE),
            true)
    end

    ---@param console unit
    function ConsoleEnable(console)
        if IsUnitAliveBJ(console) then
            EnableTrigger(LoadTriggerHandle(LS(), GetHandleId(console), StringHash("EnterTrigger")))
        end
    end

    function ConsoleCleanup()
        local k           = GetTriggeringTrigger() ---@type trigger
        local m           = LoadTriggerHandle(LS(), GetHandleId(k), StringHash("EnterTrigger")) ---@type trigger
        local console     = LoadUnitHandle(LS(), GetHandleId(k), StringHash("console")) ---@type unit
        local space       = LoadUnitHandle(LS(), GetHandleId(k), StringHash("space")) ---@type unit
        local consolerect = LoadRectHandle(LS(), GetHandleId(k), StringHash("consolerect")) ---@type rect
        local destroyed   = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), GetUnitTypeId(console), GetUnitX(console),
            GetUnitY(console), GetUnitFacing(console)) ---@type unit

        if IsUnitAliveBJ(space) or space == console then
            --If the console has no associated space (IE space=console) then we do not check to see if the space is alive before proceeding.
            SetUnitX(destroyed, GetUnitX(console))
            SetUnitY(destroyed, GetUnitY(console))
            UnitAddAbility(destroyed, FourCC('Avul'))
            SetUnitVertexColor(destroyed, 50, 50, 50, 255)
            SetUnitOwner(console, Player(PLAYER_NEUTRAL_PASSIVE), false)
            SetUnitOwner(space, Player(PLAYER_NEUTRAL_PASSIVE), false)
            SaveUnitHandle(LS(), GetHandleId(k), StringHash("console"), destroyed)
            SaveUnitHandle(LS(), GetHandleId(m), StringHash("console"), destroyed)
            DisableTrigger(k)
            DisableTrigger(m)
            RemoveUnit(console)
            UnitAddAbility(destroyed, FourCC('A06R'))
            SetUnitLifeBJ(destroyed, 1)
            SaveTriggerHandle(LS(), GetHandleId(destroyed), StringHash("console_k"), k)
            SaveTriggerHandle(LS(), GetHandleId(destroyed), StringHash("console_m"), m)
            TriggerRegisterUnitEvent(k, destroyed, EVENT_UNIT_DEATH)
        else
            RemoveRect(consolerect)
            FlushChildHashtable(LS(), GetHandleId(k))
            FlushChildHashtable(LS(), GetHandleId(m))
            DestroyTrigger(GetTriggeringTrigger())
            DestroyTrigger(GetTriggeringTrigger())
        end
    end

    function ConsoleLoopCheck_Child()
        local k           = GetExpiredTimer() ---@type timer
        local console     = LoadUnitHandle(LS(), GetHandleId(k), StringHash("console")) ---@type unit
        local space       = LoadUnitHandle(LS(), GetHandleId(k), StringHash("space")) ---@type unit
        local r           = LoadUnitHandle(LS(), GetHandleId(k), StringHash("r")) ---@type unit
        local consolerect = LoadRectHandle(LS(), GetHandleId(k), StringHash("consolerect")) ---@type rect

        if RectContainsUnit(consolerect, r) == false or r == nil or IsUnitDeadBJ(r) or GetOwningPlayer(r) ~= GetOwningPlayer(console) then
            FlushChildHashtable(LS(), GetHandleId(k))
            DestroyTimer(k)

            SetUnitOwner(console, Player(PLAYER_NEUTRAL_PASSIVE), false)
            SetUnitOwner(space, Player(PLAYER_NEUTRAL_PASSIVE), false)
        end
    end

    ---@param console unit
    ---@param r unit
    ---@param consolerect rect
    ---@param space unit
    function ConsoleLoopCheck(console, r, consolerect, space)
        local k = CreateTimer() ---@type timer

        SaveUnitHandle(LS(), GetHandleId(k), StringHash("console"), console)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("space"), space)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("r"), r)
        SaveRectHandle(LS(), GetHandleId(k), StringHash("consolerect"), consolerect)
        TimerStart(k, 0.3, true, ConsoleLoopCheck_Child)
    end

    function ConsoleControl()
        local m           = GetTriggeringTrigger() ---@type trigger
        local console     = LoadUnitHandle(LS(), GetHandleId(m), StringHash("console")) ---@type unit
        local space       = LoadUnitHandle(LS(), GetHandleId(m), StringHash("space")) ---@type unit
        local consolerect = LoadRectHandle(LS(), GetHandleId(m), StringHash("consolerect")) ---@type rect
        local r           = GetTriggerUnit() ---@type unit
        local om          = GetOwningPlayer(r) ---@type player

        if IsUnitIllusion(r) == false and GetOwningPlayer(console) == Player(PLAYER_NEUTRAL_PASSIVE) and GetUnitPointValue(r) ~= 37 and udg_Blackout == false and SubStringBJ(I2S(GetUnitPointValue(r)), 1, 1) ~= "1" then
            SetUnitOwner(space, om, false)
            SetUnitOwner(console, om, false)
            if om == Player(bj_PLAYER_NEUTRAL_EXTRA) then
                om = udg_Parasite
            end
            DisplayTextToPlayer(om, 0, 0, (GetUnitName(space)))
            DisplayTextToPlayer(om, 0, 0, (" |cff00FF00Access Granted|r" + ""))
            SelectUnitForPlayerSingle(console, om)
            ConsoleLoopCheck(console, r, consolerect, space)
        end
    end

    ---@param console unit
    ---@param space unit
    ---@param consolerect rect
    function GenConsole(console, space, consolerect)
        local t            = CreateTrigger() ---@type trigger
        local EnterTrigger = CreateTrigger() ---@type trigger

        TriggerRegisterUnitEvent(t, console, EVENT_UNIT_DEATH)
        --call TriggerRegisterUnitEvent(t,space,EVENT_UNIT_DEATH)
        TriggerAddAction(t, ConsoleCleanup)
        TriggerRegisterEnterRectSimple(EnterTrigger, consolerect)
        TriggerAddAction(EnterTrigger, ConsoleControl)
        SaveTriggerHandle(LS(), GetHandleId(t), StringHash("EnterTrigger"), EnterTrigger)
        SaveRectHandle(LS(), GetHandleId(EnterTrigger), StringHash("consolerect"), consolerect)
        SaveUnitHandle(LS(), GetHandleId(EnterTrigger), StringHash("console"), console)
        SaveUnitHandle(LS(), GetHandleId(EnterTrigger), StringHash("space"), space)
        SaveRectHandle(LS(), GetHandleId(t), StringHash("consolerect"), consolerect)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("console"), console)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("space"), space)
        SaveUnitHandle(LS(), GetHandleId(console), StringHash("space"), space)
        SaveTriggerHandle(LS(), GetHandleId(console), StringHash("EnterTrigger"), EnterTrigger)
    end

    --Arbitress
    GenConsole(gg_unit_h000_0013, gg_unit_h003_0018, gg_rct_ST1Control)
    --Kyo
    GenConsole(gg_unit_h006_0026, gg_unit_h007_0027, gg_rct_ST3Control)
    --Niffeh
    GenConsole(gg_unit_h00A_0030, gg_unit_h009_0029, gg_rct_ST4Control)
    --Swaggah
    GenConsole(gg_unit_h00Y_0050, gg_unit_h00X_0049, gg_rct_ST5Control)
    --Niffeh powar
    GenConsole(gg_unit_h048_0143, gg_unit_h048_0143, gg_rct_NiffyPowerControl)
    --Errun assembly
    GenConsole(gg_unit_h04B_0165, gg_unit_h04B_0165, gg_rct_AssemblyControl)
end)
if Debug then Debug.endFile() end
