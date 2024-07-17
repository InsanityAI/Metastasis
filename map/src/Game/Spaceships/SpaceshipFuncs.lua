if Debug then Debug.beginFile "Game/Spaceships/SpaceshipFuncs" end
OnInit.map("SpaceshipFuncs", function(require)
    require "ArrayDat"
    function SSEnter()
        --set udg_TempUnit=GetHandleUnit(GetTriggeringTrigger(), "q")
        udg_TempUnit = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("q"))
        ConditionalTriggerExecute(gg_trg_SSGenEnter)
    end

    function SSControl()
        udg_TempUnit = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("q"))
        ConditionalTriggerExecute(gg_trg_SSGenControl)
    end

    function SSControlLoss()
        udg_TempUnit = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("q"))
        ConditionalTriggerExecute(gg_trg_SSGenControlLoss)
    end

    function SSExit()
        udg_TempUnit = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("q"))
        ConditionalTriggerExecute(gg_trg_SSGenExit)
    end

    function SSDeath()
        udg_TempUnit = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("q"))
        ConditionalTriggerExecute(gg_trg_SSGenDeath)
    end

    function SSDamage_Reset()
        local t      = GetExpiredTimer() ---@type timer
        local m      = LoadTriggerHandle(LS(), GetHandleId(t), StringHash("trig")) ---@type trigger
        udg_TempUnit = LoadUnitHandle(LS(), GetHandleId(m), StringHash("q"))
        SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, udg_SpaceObject_Rect[GetUnitAN(udg_TempUnit)])
        SaveBoolean(LS(), GetHandleId(m), StringHash("underattack"), false)
    end

    function SSDamage()
        local m      = GetTriggeringTrigger() ---@type trigger
        local t      = LoadTimerHandle(LS(), GetHandleId(m), StringHash("timer")) ---@type timer
        udg_TempUnit = LoadUnitHandle(LS(), GetHandleId(m), StringHash("q"))
        DisableTrigger(m)
        if LoadBoolean(LS(), GetHandleId(m), StringHash("underattack")) == false then
            SetStackedSoundBJ(true, gg_snd_WWII_submarine_dive_klaxon, udg_SpaceObject_Rect[GetUnitAN(udg_TempUnit)])
            SaveBoolean(LS(), GetHandleId(m), StringHash("underattack"), true)
        end
        TimerStart(t, 10.0, false, SSDamage_Reset)
        PolledWait(5.00)
        EnableTrigger(m)
    end

    SpaceshipID = 0 ---@type integer


    ---@param landed unit
    ---@param space unit
    ---@param console unit
    ---@param mainsrect rect
    ---@param enterexit rect
    ---@param controlrect rect
    ---@param sector integer
    function Spaceship_Build(landed, space, console, mainsrect, enterexit, controlrect, sector)
        local enter                        = CreateTrigger() ---@type trigger
        local exit                         = CreateTrigger() ---@type trigger
        local control                      = CreateTrigger() ---@type trigger
        local controlLoss                  = CreateTrigger() ---@type trigger
        local death                        = CreateTrigger() ---@type trigger
        local i ---@type integer
        local damage                       = CreateTrigger() ---@type trigger
        local DamageTimer                  = CreateTimer() ---@type timer

        udg_Sector_Space[sector]           = space
        SpaceshipID                        = SpaceshipID + 1
        udg_SpaceshipID_Space[SpaceshipID] = space

        TriggerRegisterUnitInRangeSimple(enter, 128.00, landed)
        TriggerRegisterEnterRectSimple(control, controlrect)
        TriggerRegisterLeaveRectSimple(controlLoss, controlrect)
        TriggerRegisterEnterRectSimple(exit, enterexit)
        TriggerRegisterUnitEvent(death, landed, EVENT_UNIT_DEATH)
        TriggerRegisterUnitEvent(death, space, EVENT_UNIT_DEATH)
        TriggerRegisterUnitEvent(damage, landed, EVENT_UNIT_DAMAGED)
        TriggerRegisterUnitEvent(damage, space, EVENT_UNIT_DAMAGED)
        TriggerAddAction(enter, SSEnter)
        TriggerAddAction(control, SSControl)
        TriggerAddAction(controlLoss, SSControlLoss)
        TriggerAddAction(exit, SSExit)
        TriggerAddAction(death, SSDeath)
        TriggerAddAction(damage, SSDamage)

        --call SetHandleHandle(enter, "q", landed)
        --call SetHandleHandle(exit, "q", landed)
        --call SetHandleHandle(control, "q", landed)
        --call SetHandleHandle(controlLoss, "q", landed)
        --call SetHandleHandle(death, "q", landed)

        SaveUnitHandle(LS(), GetHandleId(enter), StringHash("q"), landed)
        SaveUnitHandle(LS(), GetHandleId(exit), StringHash("q"), landed)
        SaveUnitHandle(LS(), GetHandleId(control), StringHash("q"), landed)
        SaveUnitHandle(LS(), GetHandleId(controlLoss), StringHash("q"), landed)
        SaveUnitHandle(LS(), GetHandleId(death), StringHash("q"), landed)
        SaveUnitHandle(LS(), GetHandleId(damage), StringHash("q"), landed)
        SaveBoolean(LS(), GetHandleId(damage), StringHash("underattack"), false)
        SaveTimerHandle(LS(), GetHandleId(damage), StringHash("timer"), DamageTimer)
        SaveTriggerHandle(LS(), GetHandleId(DamageTimer), StringHash("trig"), damage)

        --NewUnitRegister, gives the spaceship its own new and unique custom unit value!
        NewUnitRegister(landed)
        NewUnitRegister(space)

        --Note that the custom value for each spaceship is different
        --Landed and Space equivalent, have different custom values!

        i = GetUnitAN(landed) --Literally i = GetUnitUserData(landed)
        udg_SpaceObject_Rect[i] = mainsrect
        udg_SpaceObject_Rect[GetUnitAN(space)] = mainsrect
        udg_Spaceship_Console[i] = console
        udg_Spaceship_ControlLossTrig[i] = controlLoss
        udg_Spaceship_ControlRect[i] = controlrect
        udg_Spaceship_ControlTrig[i] = control
        udg_Spaceship_Death[i] = death
        udg_Spaceship_EnterExit[i] = enterexit
        udg_Spaceship_EnterTrig[i] = enter
        udg_Spaceship_ExitTrig[i] = exit
        udg_Spaceship_Rect[i] = mainsrect
        udg_SS_Landed[i] = landed
        udg_SS_Space[i] = space

        i = GetUnitAN(space) --Literally i = GetUnitUserData(space)
        udg_Spaceship_Console[i] = console
        udg_Spaceship_ControlLossTrig[i] = controlLoss
        udg_Spaceship_ControlRect[i] = controlrect
        udg_Spaceship_ControlTrig[i] = control
        udg_Spaceship_Death[i] = death
        udg_Spaceship_EnterExit[i] = enterexit
        udg_Spaceship_EnterTrig[i] = enter
        udg_Spaceship_ExitTrig[i] = exit
        udg_Spaceship_Rect[i] = mainsrect
        udg_SS_Landed[i] = landed
        udg_SS_Space[i] = space

        SetUnitTimeScalePercent(landed, 0.00)
    end
end)
if Debug then Debug.endFile() end
