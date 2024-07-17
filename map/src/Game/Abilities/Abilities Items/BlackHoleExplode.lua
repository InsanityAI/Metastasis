if Debug then Debug.beginFile "Game/Abilities/Items/BlackHoleExplode" end
OnInit.trig("BlackHoleExplode", function(require)
    function BlackHole_Suck_Enum()
        local a = GetUnitLoc(GetEnumUnit()) ---@type location
        local r = DistanceBetweenPoints(a, udg_TempPoint) ---@type real
        local b ---@type location

        if GetEnumUnit() == gg_unit_h008_0196 and r <= 1000.0 then
            DestroyTrigger(gg_trg_PlanetMovement)
        end

        --if udg_TempUnit != GetEnumUnit() then
        if GetUnitTypeId(GetEnumUnit()) ~= FourCC('e01I') then
            if r <= 15.0 and HaveSavedBoolean(LS(), GetHandleId(GetEnumUnit()), StringHash("BlackHole_SuckingIn")) == false then
                SaveBoolean(LS(), GetHandleId(GetEnumUnit()), StringHash("BlackHole_SuckingIn"), true) --Remember it killed it already
                SizeUnitOverTime(GetEnumUnit(), 0.5, 1.0, 0.01, true)

                --If CCS -> Remove it
                DetermineRemoveItemTypeFromUnit(GetEnumUnit(), FourCC('I00L'))
                KillUnit(GetEnumUnit())
            else
                --If space pull
                if udg_TempReal == 3000.0 then
                    b = PolarProjectionBJ(a, ((udg_TempReal - r) // udg_TempReal) * 30 // 50,
                        AngleBetweenPoints(a, udg_TempPoint))
                    if IsUnitExplorer(GetEnumUnit()) then
                        SetUnitX(GetEnumUnit(), GetLocationX(b))
                        SetUnitY(GetEnumUnit(), GetLocationY(b))
                    else
                        SetUnitPositionLoc(GetEnumUnit(), b)
                    end
                else --Station/Ground pull
                    b = PolarProjectionBJ(a, ((udg_TempReal - r) // udg_TempReal) * 600 // 50,
                        AngleBetweenPoints(a, udg_TempPoint))
                    SetUnitX(GetEnumUnit(), GetLocationX(b))
                    SetUnitY(GetEnumUnit(), GetLocationY(b))
                end

                --If in pause+flyup range
                if r <= 300 then
                    UnitAddAbility(GetEnumUnit(), FourCC('Amrf'))
                    --call UnitRemoveAbility(GetEnumUnit(),FourCC('Amrf'))//Credits to Tal
                    PauseUnit(GetEnumUnit(), true)
                    SetUnitFlyHeight(GetEnumUnit(), (300 - r) / 300.0 * 550, 0)
                else
                    PauseUnit(GetEnumUnit(), false)
                end

                RemoveLocation(b)
            end
            RemoveLocation(a)
        end
    end

    function BlackHole_DetermineSpaceUnitDeath()
        local deathCheckTimer = GetExpiredTimer() ---@type timer
        local spaceunit       = LoadUnitHandle(LS(), GetHandleId(deathCheckTimer), StringHash("spaceunit")) ---@type unit
        local blackHoleUnit   = LoadUnitHandle(LS(), GetHandleId(deathCheckTimer), StringHash("unit")) ---@type unit

        local spaceunitX ---@type real
        local spaceunitY ---@type real

        if IsUnitDeadBJ(spaceunit) then
            --call DisplayTextToForce(GetPlayersAll(), "DEAD: " .. GetUnitName(spaceunit) .. " " .. R2S(GetUnitX(spaceunit)))

            --Instead of bloat per 0.02s
            --Should do an event register of death on spaceunit...
            if GetUnitX(spaceunit) ~= 0 and GetUnitY(spaceunit) ~= 0 then
                --More or less a swap. Because if you place into the exact location of dead unit
                --Because of wc3 (or felcode?) can be teleported into 0,0 -_-
                --So, I got to "swap" them by yeeting the DEAD spaceunit top-right lmao

                spaceunitX = GetUnitX(spaceunit)
                spaceunitY = GetUnitY(spaceunit)

                SetUnitPositionLoc(spaceunit, GetRandomLocInRect(gg_rct_Timeout))

                SetUnitX(blackHoleUnit, spaceunitX)
                SetUnitY(blackHoleUnit, spaceunitY)
            end

            --Since it moved outside, never check again if the spaceunit is alive/dead.
            PauseTimer(deathCheckTimer)
            DestroyTimer(deathCheckTimer)
        end
    end

    function BlackHole_Suck()
        local t                      = GetExpiredTimer() ---@type timer
        local spaceunit              = LoadUnitHandle(LS(), GetHandleId(t), StringHash("spaceunit")) ---@type unit
        local blackHoleUnit          = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local blackHoleLocalLocation = GetUnitLoc(blackHoleUnit) ---@type location
        local g ---@type group

        --call PingMinimapForForce(GetPlayersAll(), GetUnitX(blackHoleUnit), GetUnitY(blackHoleUnit), 0.01)

        --call DisplayTextToForce(GetPlayersAll(), "SpaceUnit is: " .. GetUnitName(spaceunit))

        --If bugged in 0,0 or Pown
        if RectContainsLoc(gg_rct_MapCenter, blackHoleLocalLocation) or (RectContainsLoc(gg_rct_ST10, blackHoleLocalLocation) and spaceunit ~= gg_unit_h04V_0253) then
            SetUnitX(blackHoleUnit, blackholeDebugX)
            SetUnitY(blackHoleUnit, blackholeDebugY)

            debugSpamCap = debugSpamCap + 1

            if (debugSpamCap > 2) then
                debugSpamCap = 0

                DisplayTextToForce(GetPlayersAll(), "Seems like bhd is stuck into [0,0] or Pown.")
                DisplayTextToForce(GetPlayersAll(), "Please report this to Thorlar")
                DisplayTextToForce(GetPlayersAll(), "Killing the bhd so the game is playable and not ruined :)")

                KillUnit(spaceunit)
                PauseTimer(t)
                DestroyTimer(t)
                --call DestroyTrigger(GetTriggeringTrigger())//Commented out so a 2nd blackhole can happen
            end
        end

        --For checking bug of top-right black hole...
        if RectContainsCoords(gg_rct_Timeout, GetUnitX(blackHoleUnit), GetUnitY(blackHoleUnit)) then
            DisplayTextToForce(GetPlayersAll(), "Black Hole is in the top-right corner!!!")
            DisplayTextToForce(GetPlayersAll(),
                "Killing the unit + Killing the timer + Killing the black hole trigger. Killed them all, I hope your game is still playable.")
            DisplayTextToForce(GetPlayersAll(), "Please report the replay to Thorlar.")

            KillUnit(spaceunit)
            PauseTimer(t)
            DestroyTimer(t)
            --call DestroyTrigger(GetTriggeringTrigger())//Commented out so a 2nd blackhole can happen
        end

        --Range to start pulling
        if RectContainsCoords(gg_rct_Space, GetUnitX(blackHoleUnit), GetUnitY(blackHoleUnit)) then
            udg_TempReal = 3000.0
        else
            udg_TempReal = 700.0
        end

        udg_TempPoint = blackHoleLocalLocation
        udg_TempUnit = blackHoleUnit
        g = GetUnitsInRangeOfLocAll(udg_TempReal, blackHoleLocalLocation)
        ForGroup(g, BlackHole_Suck_Enum)
        DestroyGroup(g)
        g = nil
        RemoveLocation(blackHoleLocalLocation)
        blackHoleLocalLocation = nil

        UnitDamageTarget(blackHoleUnit, spaceunit, 80, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
            WEAPON_TYPE_WHOKNOWS)
    end

    blackholeDebugX = 0 ---@type real
    blackholeDebugY = 0 ---@type real

    debugSpamCap    = 0 ---@type integer --Caps at 3


    function Trig_BlackHoleExplode_Actions()
        local castPoint       = GetUnitLoc(udg_CountupBarTemp) ---@type location
        local t               = CreateTimer() ---@type timer
        local deathCheckTimer = CreateTimer() ---@type timer

        local blackHoleUnit ---@type unit
        local blackholeSpaceContainer ---@type unit --This is the unit in which the black hole is inside
        local blackholeLandContainer ---@type unit --This is the unit in which the black hole is inside - the landed version if it exists

        --variables in case the spaceship is docked
        local spaceshipX ---@type real
        local spaceshipY ---@type real

        --Every spaceship is indexed by me, 0 to 12, via this can fetch space/ground unit equivalent and even the rect!
        local spaceshipIndex ---@type integer

        --Cache which spaceship black hole is used in
        spaceshipIndex        = GetSpaceshipIndexFromPosition(castPoint)

        --If an explorer (doesn't include calipea/pown)
        if (spaceshipIndex ~= -1) then
            blackholeSpaceContainer = udg_SpaceshipSpace[spaceshipIndex]
            blackholeLandContainer = udg_SpaceshipGround[spaceshipIndex]
        end


        --Creates the countbar and starts the countdown
        udg_TempUnit = udg_CountupBarTemp
        SetUnitAnimation(udg_TempUnit, "decay")

        --Creates the 4 cool rotating green rings vfx
        CreateNUnitsAtLoc(1, FourCC('e016'), Player(PLAYER_NEUTRAL_PASSIVE), castPoint, GetRandomDirectionDeg())
        PolledWait(4.2)

        --If the spaceship from the bhd is dead until bhd fully activates, nullify the bhd, aka gtfo/return;
        if spaceshipIndex ~= -1 and IsUnitDeadBJ(blackholeSpaceContainer) then
            return
        end

        --/call DisplayTextToForce(GetPlayersAll(), I2S(spaceshipIndex))

        --Creates the black hole
        blackHoleUnit = CreateUnitAtLoc(Player(15), FourCC('e01I'), castPoint, GetRandomDirectionDeg())

        --Cache the black hole unit to be used later
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), blackHoleUnit)
        SaveUnitHandle(LS(), GetHandleId(deathCheckTimer), StringHash("unit"), blackHoleUnit)

        --If an explorer (doesn't include calipea/pown)
        if (spaceshipIndex ~= -1) then
            --If docked
            if (RectContainsUnit(gg_rct_Space, blackholeSpaceContainer) == false) then
                --/call DisplayTextToForce(GetPlayersAll(), "Docked!")

                spaceshipX = GetUnitX(blackholeLandContainer)
                spaceshipY = GetUnitY(blackholeLandContainer)

                --Used for debugging when teleporting onto Pown
                blackholeDebugX = spaceshipX
                blackholeDebugY = spaceshipY


                --Replace the cache of the unit the black hole is inside
                SaveUnitHandle(LS(), GetHandleId(t), StringHash("spaceunit"),
                    udg_Sector_Space[GetUnitSector(blackholeLandContainer)])
                SaveUnitHandle(LS(), GetHandleId(deathCheckTimer), StringHash("spaceunit"),
                    udg_Sector_Space[GetUnitSector(blackholeLandContainer)])


                --/call DisplayTextToForce(GetPlayersAll(), "LandContainerSector is: " .. I2S(GetUnitSector(blackholeLandContainer)))

                --/call DisplayTextToForce(GetPlayersAll(), "LandContainerName is: " .. GetUnitName(blackholeLandContainer))

                --/call DisplayTextToForce(GetPlayersAll(), "Land Container X, Y: " .. R2S(GetUnitX(blackholeLandContainer)) .. ", " .. R2S(GetUnitY(blackholeLandContainer)))

                --/call DisplayTextToForce(GetPlayersAll(), "SpaceUnit is: " .. GetUnitName(udg_Sector_Space[GetUnitSector(blackholeLandContainer)]))


                --Move the spaceship away, because if you don't do this
                --the dead unit will occupy the position to move into!!
                SetUnitPositionLoc(blackholeLandContainer, GetRandomLocInRect(gg_rct_Timeout))
                --call SetUnitPosition(blackholeLandContainer, 15500, 15500)

                --Move the BHD just outside of the spaceship (on OG location of grounded spaceship)
                SetUnitX(blackHoleUnit, spaceshipX)
                SetUnitY(blackHoleUnit, spaceshipY)

                --/call DisplayTextToForce(GetPlayersAll(), R2S(GetUnitX(blackHoleUnit)) .. ", " .. R2S(GetUnitY(blackHoleUnit)))
            else
                --/call DisplayTextToForce(GetPlayersAll(), "Spaced!")

                --Move the BHD just outside of the spaceship (on location of grounded spaceship)
                SetUnitX(blackHoleUnit, GetUnitX(blackholeSpaceContainer) + 25) --25 to not spawn atop of it and go 0,0
                SetUnitY(blackHoleUnit, GetUnitY(blackholeSpaceContainer) + 25)

                --Replace the cache of the unit the black hole is inside
                SaveUnitHandle(LS(), GetHandleId(t), StringHash("spaceunit"), blackholeSpaceContainer)
            end

            --Killing it just once is not enough. It does do RectOfDoom, but the equivalent unit is not killed!!
            --Equivalent -> Space equivalent is grounded, and Ground equivalent is space
            KillUnit(blackholeLandContainer)
            KillUnit(blackholeSpaceContainer)
        else --If a station
            --Cache the unit the black hole is inside
            --Note: This may be a cause of bugs, since GetUnitSector is a fel function and not mine.
            SaveUnitHandle(LS(), GetHandleId(t), StringHash("spaceunit"), udg_Sector_Space[GetUnitSector(blackHoleUnit)])
            SaveUnitHandle(LS(), GetHandleId(deathCheckTimer), StringHash("spaceunit"),
                udg_Sector_Space[GetUnitSector(blackHoleUnit)])
        end

        --Memory Leak Cleaning
        RemoveLocation(castPoint)

        --Every 0.02 seconds, the black hole logic happens, SUCCing all the performance
        TimerStart(t, 0.02, true, BlackHole_Suck)

        --Checks if the space unit is dead//Because imagine using events -_-
        TimerStart(deathCheckTimer, 0.02, true, BlackHole_DetermineSpaceUnitDeath)
    end

    --===========================================================================
    gg_trg_BlackHoleExplode = CreateTrigger()
    TriggerAddAction(gg_trg_BlackHoleExplode, Trig_BlackHoleExplode_Actions)
end)
if Debug then Debug.endFile() end
