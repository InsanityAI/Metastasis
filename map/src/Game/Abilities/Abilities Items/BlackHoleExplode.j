//TESH.scrollpos=257
//TESH.alwaysfold=0
function BlackHole_Suck_Enum takes nothing returns nothing
    local location a=GetUnitLoc(GetEnumUnit())
    local real r=DistanceBetweenPoints(a,udg_TempPoint)
    local location b
    
    if GetEnumUnit() == gg_unit_h008_0196 and r <= 1000.0 then
        call DestroyTrigger(gg_trg_PlanetMovement)
    endif
    
    //if udg_TempUnit != GetEnumUnit() then
    if GetUnitTypeId(GetEnumUnit()) != 'e01I' then
        if r <= 15.0 and HaveSavedBoolean(LS(),GetHandleId(GetEnumUnit()),StringHash("BlackHole_SuckingIn")) == false then
            call SaveBoolean(LS(),GetHandleId(GetEnumUnit()),StringHash("BlackHole_SuckingIn"),true)//Remember it killed it already
            call SizeUnitOverTime(GetEnumUnit(),0.5,1.0,0.01,true)
            
            //If CCS -> Remove it
            call DetermineRemoveItemTypeFromUnit(GetEnumUnit(), 'I00L')
            call KillUnit(GetEnumUnit())
        else
            //If space pull
            if udg_TempReal==3000.0 then
                set b=PolarProjectionBJ(a,((udg_TempReal-r)/udg_TempReal)*30/50,AngleBetweenPoints(a,udg_TempPoint))
                if IsUnitExplorer(GetEnumUnit()) then
                    call SetUnitX(GetEnumUnit(),GetLocationX(b))
                    call SetUnitY(GetEnumUnit(),GetLocationY(b))
                else
                    call SetUnitPositionLoc(GetEnumUnit(),b)
                endif
            else//Station/Ground pull
                set b=PolarProjectionBJ(a,((udg_TempReal-r)/udg_TempReal)*600/50,AngleBetweenPoints(a,udg_TempPoint))
                call SetUnitX(GetEnumUnit(),GetLocationX(b))
                call SetUnitY(GetEnumUnit(),GetLocationY(b))
            endif

            //If in pause+flyup range
            if r <= 300 then
                call UnitAddAbility(GetEnumUnit(),'Amrf')
                //call UnitRemoveAbility(GetEnumUnit(),'Amrf')//Credits to Tal
                call PauseUnit(GetEnumUnit(),true)
                call SetUnitFlyHeight(GetEnumUnit(),(300-r)/300.0*550,0)
            else
                call PauseUnit(GetEnumUnit(),false)
            endif
        
            call RemoveLocation(b)
        endif
        call RemoveLocation(a)
    endif
endfunction

function BlackHole_DetermineSpaceUnitDeath takes nothing returns nothing
    local timer deathCheckTimer = GetExpiredTimer()
    local unit spaceunit=LoadUnitHandle(LS(),GetHandleId(deathCheckTimer),StringHash("spaceunit"))
    local unit blackHoleUnit=LoadUnitHandle(LS(),GetHandleId(deathCheckTimer),StringHash("unit"))
    
    local real spaceunitX
    local real spaceunitY
    
    if IsUnitDeadBJ(spaceunit) then
        //call DisplayTextToForce(GetPlayersAll(), "DEAD: " + GetUnitName(spaceunit) + " " + R2S(GetUnitX(spaceunit)))
    
        //Instead of bloat per 0.02s
        //Should do an event register of death on spaceunit...
        if GetUnitX(spaceunit) != 0 and GetUnitY(spaceunit) != 0 then
        
            //More or less a swap. Because if you place into the exact location of dead unit
            //Because of wc3 (or felcode?) can be teleported into 0,0 -_-
            //So, I got to "swap" them by yeeting the DEAD spaceunit top-right lmao
        
            set spaceunitX = GetUnitX(spaceunit)
            set spaceunitY = GetUnitY(spaceunit)
            
            call SetUnitPositionLoc(spaceunit, GetRandomLocInRect(gg_rct_Timeout))
        
            call SetUnitX(blackHoleUnit, spaceunitX)
            call SetUnitY(blackHoleUnit, spaceunitY)
        endif
        
        //Since it moved outside, never check again if the spaceunit is alive/dead.
        call PauseTimer(deathCheckTimer)
        call DestroyTimer(deathCheckTimer)
    endif
endfunction

function BlackHole_Suck takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local unit spaceunit=LoadUnitHandle(LS(),GetHandleId(t),StringHash("spaceunit"))
    local unit blackHoleUnit=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
    local location blackHoleLocalLocation=GetUnitLoc(blackHoleUnit)
    local group g
        
    //call PingMinimapForForce(GetPlayersAll(), GetUnitX(blackHoleUnit), GetUnitY(blackHoleUnit), 0.01)

    //call DisplayTextToForce(GetPlayersAll(), "SpaceUnit is: " + GetUnitName(spaceunit))
    
    //If bugged in 0,0 or Pown
    if RectContainsLoc(gg_rct_MapCenter, blackHoleLocalLocation) or (RectContainsLoc(gg_rct_ST10, blackHoleLocalLocation) and spaceunit != gg_unit_h04V_0253) then
        call SetUnitX(blackHoleUnit, blackholeDebugX)
        call SetUnitY(blackHoleUnit, blackholeDebugY)
        
        set debugSpamCap = debugSpamCap + 1
        
        if (debugSpamCap > 2) then
            set debugSpamCap = 0
            
            call DisplayTextToForce(GetPlayersAll(), "Seems like bhd is stuck into [0,0] or Pown.")
            call DisplayTextToForce(GetPlayersAll(), "Please report this to Thorlar")
            call DisplayTextToForce(GetPlayersAll(), "Killing the bhd so the game is playable and not ruined :)")
        
            call KillUnit(spaceunit)
            call PauseTimer(t)
            call DestroyTimer(t)
            //call DestroyTrigger(GetTriggeringTrigger())//Commented out so a 2nd blackhole can happen
        endif
    endif
    
    //For checking bug of top-right black hole...
    if RectContainsCoords(gg_rct_Timeout, GetUnitX(blackHoleUnit), GetUnitY(blackHoleUnit)) then
        call DisplayTextToForce(GetPlayersAll(), "Black Hole is in the top-right corner!!!")
        call DisplayTextToForce(GetPlayersAll(), "Killing the unit + Killing the timer + Killing the black hole trigger. Killed them all, I hope your game is still playable.")
        call DisplayTextToForce(GetPlayersAll(), "Please report the replay to Thorlar.")
        
        call KillUnit(spaceunit)
        call PauseTimer(t)
        call DestroyTimer(t)
        //call DestroyTrigger(GetTriggeringTrigger())//Commented out so a 2nd blackhole can happen
    endif
    
    //Range to start pulling
    if RectContainsCoords(gg_rct_Space, GetUnitX(blackHoleUnit), GetUnitY(blackHoleUnit)) then
        set udg_TempReal=3000.0
    else
        set udg_TempReal=700.0
    endif
    
    set udg_TempPoint=blackHoleLocalLocation
    set udg_TempUnit=blackHoleUnit
    set g=GetUnitsInRangeOfLocAll(udg_TempReal, blackHoleLocalLocation)
    call ForGroup(g,function BlackHole_Suck_Enum)
    call DestroyGroup(g)
    set g=null
    call RemoveLocation(blackHoleLocalLocation)
    set blackHoleLocalLocation=null
    
    call UnitDamageTarget(blackHoleUnit,spaceunit,80,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)

endfunction

globals
    real blackholeDebugX = 0
    real blackholeDebugY = 0
    
    integer debugSpamCap = 0//Caps at 3
endglobals

function Trig_BlackHoleExplode_Actions takes nothing returns nothing
    local location castPoint=GetUnitLoc(udg_CountupBarTemp)
    local timer t=CreateTimer()
    local timer deathCheckTimer=CreateTimer()
    
    local unit blackHoleUnit
    local unit blackholeSpaceContainer//This is the unit in which the black hole is inside
    local unit blackholeLandContainer//This is the unit in which the black hole is inside - the landed version if it exists
    
    //variables in case the spaceship is docked
    local real spaceshipX
    local real spaceshipY
    
    //Every spaceship is indexed by me, 0 to 12, via this can fetch space/ground unit equivalent and even the rect!
    local integer spaceshipIndex
    
    //Cache which spaceship black hole is used in
    set spaceshipIndex = GetSpaceshipIndexFromPosition(castPoint)
    
    //If an explorer (doesn't include calipea/pown)
    if (spaceshipIndex != -1) then
        set blackholeSpaceContainer = udg_SpaceshipSpace[spaceshipIndex]
        set blackholeLandContainer = udg_SpaceshipGround[spaceshipIndex]
    endif
    

    //Creates the countbar and starts the countdown
    set udg_TempUnit = udg_CountupBarTemp
    call SetUnitAnimation( udg_TempUnit, "decay" )
    
    //Creates the 4 cool rotating green rings vfx
    call CreateNUnitsAtLoc( 1, 'e016', Player(PLAYER_NEUTRAL_PASSIVE), castPoint, GetRandomDirectionDeg() )
    call PolledWait(4.2)
    
    //If the spaceship from the bhd is dead until bhd fully activates, nullify the bhd, aka gtfo/return;
    if spaceshipIndex != -1 and IsUnitDeadBJ(blackholeSpaceContainer)  then
        return
    endif
    
    ///call DisplayTextToForce(GetPlayersAll(), I2S(spaceshipIndex))
    
    //Creates the black hole
    set blackHoleUnit = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), 'e01I', castPoint, GetRandomDirectionDeg())
    
    //Cache the black hole unit to be used later
    call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"), blackHoleUnit)
    call SaveUnitHandle(LS(),GetHandleId(deathCheckTimer),StringHash("unit"), blackHoleUnit)
    
    //If an explorer (doesn't include calipea/pown)
    if (spaceshipIndex != -1) then
        
        //If docked
        if (RectContainsUnit(gg_rct_Space, blackholeSpaceContainer) == false) then
        
            ///call DisplayTextToForce(GetPlayersAll(), "Docked!")
        
            set spaceshipX = GetUnitX(blackholeLandContainer)
            set spaceshipY = GetUnitY(blackholeLandContainer)
            
            //Used for debugging when teleporting onto Pown
            set blackholeDebugX = spaceshipX
            set blackholeDebugY = spaceshipY
            
            
            //Replace the cache of the unit the black hole is inside
            call SaveUnitHandle(LS(),GetHandleId(t),StringHash("spaceunit"), udg_Sector_Space[GetUnitSector(blackholeLandContainer)])
            call SaveUnitHandle(LS(),GetHandleId(deathCheckTimer),StringHash("spaceunit"), udg_Sector_Space[GetUnitSector(blackholeLandContainer)])
            
            
            ///call DisplayTextToForce(GetPlayersAll(), "LandContainerSector is: " + I2S(GetUnitSector(blackholeLandContainer)))
            
            ///call DisplayTextToForce(GetPlayersAll(), "LandContainerName is: " + GetUnitName(blackholeLandContainer))
            
            ///call DisplayTextToForce(GetPlayersAll(), "Land Container X, Y: " + R2S(GetUnitX(blackholeLandContainer)) + ", " + R2S(GetUnitY(blackholeLandContainer)))
            
            ///call DisplayTextToForce(GetPlayersAll(), "SpaceUnit is: " + GetUnitName(udg_Sector_Space[GetUnitSector(blackholeLandContainer)]))
        
            
            //Move the spaceship away, because if you don't do this
            //the dead unit will occupy the position to move into!!
            call SetUnitPositionLoc(blackholeLandContainer, GetRandomLocInRect(gg_rct_Timeout))
            //call SetUnitPosition(blackholeLandContainer, 15500, 15500)
            
            //Move the BHD just outside of the spaceship (on OG location of grounded spaceship)
            call SetUnitX(blackHoleUnit, spaceshipX)
            call SetUnitY(blackHoleUnit, spaceshipY)
            
            ///call DisplayTextToForce(GetPlayersAll(), R2S(GetUnitX(blackHoleUnit)) + ", " + R2S(GetUnitY(blackHoleUnit)))

            
        
        else
        
            ///call DisplayTextToForce(GetPlayersAll(), "Spaced!")
            
            //Move the BHD just outside of the spaceship (on location of grounded spaceship)
            call SetUnitX(blackHoleUnit,GetUnitX(blackholeSpaceContainer)+25)//25 to not spawn atop of it and go 0,0
            call SetUnitY(blackHoleUnit,GetUnitY(blackholeSpaceContainer)+25)
        
            //Replace the cache of the unit the black hole is inside
            call SaveUnitHandle(LS(),GetHandleId(t),StringHash("spaceunit"), blackholeSpaceContainer)
        endif
        
        //Killing it just once is not enough. It does do RectOfDoom, but the equivalent unit is not killed!!
        //Equivalent -> Space equivalent is grounded, and Ground equivalent is space
        call KillUnit(blackholeLandContainer)
        call KillUnit(blackholeSpaceContainer)
        
    else//If a station
        //Cache the unit the black hole is inside
        //Note: This may be a cause of bugs, since GetUnitSector is a fel function and not mine.
        call SaveUnitHandle(LS(),GetHandleId(t),StringHash("spaceunit"), udg_Sector_Space[GetUnitSector(blackHoleUnit)])
        call SaveUnitHandle(LS(),GetHandleId(deathCheckTimer),StringHash("spaceunit"), udg_Sector_Space[GetUnitSector(blackHoleUnit)])
    endif

    //Memory Leak Cleaning
    call RemoveLocation(castPoint)
    
    //Every 0.02 seconds, the black hole logic happens, SUCCing all the performance
    call TimerStart(t,0.02,true,function BlackHole_Suck)
    
    //Checks if the space unit is dead//Because imagine using events -_-
    call TimerStart(deathCheckTimer,0.02,true,function BlackHole_DetermineSpaceUnitDeath)
endfunction

//===========================================================================
function InitTrig_BlackHoleExplode takes nothing returns nothing
    set gg_trg_BlackHoleExplode = CreateTrigger(  )
    call TriggerAddAction( gg_trg_BlackHoleExplode, function Trig_BlackHoleExplode_Actions )
endfunction

