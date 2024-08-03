//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_SSGenDock_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A001' ) ) then
        return false
    endif
    return true
endfunction



function EvaluateDock takes integer a, integer b returns integer
    if GetRandomInt(1,a) == a then
        set udg_TempDestruct=udg_All_Dock[b]
        set udg_TempInt=b
    endif
    return a+1
endfunction

function Trig_SSGenDock_Actions takes nothing returns nothing
local unit a=GetSpellAbilityUnit()
local unit b=GetSpellTargetUnit()
local player q=GetOwningPlayer(a)
local integer i=1
local string onr
call UnitAddAbilityForPeriod(a,'Avul',0.2)
call PolledWait(0.1)
    set udg_TempUnit = udg_SS_Landed[GetUnitUserData(a)]
    set a=udg_TempUnit
    set udg_TempUnit2=b
    set udg_TempDestruct = null
    set udg_SS_Harbor[GetUnitUserData(udg_TempUnit)] = b
    if udg_TempUnit2 == gg_unit_h003_0018 then
    //Arbitress
        set udg_TempBool = false
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 4
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
            set i=EvaluateDock(i,GetForLoopIndexA())
              //  set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    else
        if udg_TempUnit2 == gg_unit_h005_0024 then
        //Defunct
            set udg_TempBool = false
            set bj_forLoopAIndex = 5
            set bj_forLoopAIndexEnd = 6
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                set i=EvaluateDock(i,GetForLoopIndexA())
                   // set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                else
                endif
                set bj_forLoopAIndex = bj_forLoopAIndex + 1
            endloop
        else
            if udg_TempUnit2 == gg_unit_h007_0027 then
            //Kyo station
                set udg_TempBool = false
                set bj_forLoopAIndex = 7
                set bj_forLoopAIndexEnd = 8
                loop
                    exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                    if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                    set i=EvaluateDock(i,GetForLoopIndexA())
                        //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                    endif
                    set bj_forLoopAIndex = bj_forLoopAIndex + 1
                endloop
                set bj_forLoopAIndex=34
                if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                set i=EvaluateDock(i,GetForLoopIndexA())
                       // set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                endif
            else
                if udg_TempUnit2 == gg_unit_h009_0029 then
                //U.S.I. Queen Niffy
                    set udg_TempBool = false
                    set bj_forLoopAIndex = 29
                    set bj_forLoopAIndexEnd = 33
                    loop
                        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                        if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                            //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                            set i=EvaluateDock(i,GetForLoopIndexA())
                        else
                        endif
                        set bj_forLoopAIndex = bj_forLoopAIndex + 1
                    endloop
                    set bj_forLoopAIndex = 9
                    set bj_forLoopAIndexEnd = 16
                    if udg_TempDestruct == null then
                    loop
                        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                        if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                            //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                            set i=EvaluateDock(i,GetForLoopIndexA())
                        else
                        endif
                        set bj_forLoopAIndex = bj_forLoopAIndex + 1
                    endloop
                    endif
                else
                    if udg_TempUnit2 == gg_unit_h00X_0049 then
                    //U.S.I. Swagger
                        set udg_TempBool = false
                        set bj_forLoopAIndex = 17
                        set bj_forLoopAIndexEnd = 20
                        loop
                            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                            if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                set i=EvaluateDock(i,GetForLoopIndexA())
                            else
                            endif
                            set bj_forLoopAIndex = bj_forLoopAIndex + 1
                        endloop
                        set bj_forLoopAIndex = 39
                        set bj_forLoopAIndexEnd = 40
                        loop
                            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                            if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                set i=EvaluateDock(i,GetForLoopIndexA())
                            else
                            endif
                            set bj_forLoopAIndex = bj_forLoopAIndex + 1
                        endloop
                    else
                        if udg_TempUnit2 == gg_unit_h008_0196 then
                        //Minertha
                            set udg_TempBool = false
                            set bj_forLoopAIndex = 35
                            set bj_forLoopAIndexEnd = 38
                            loop
                                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                                if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                    //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                    set i=EvaluateDock(i,GetForLoopIndexA())
                                else
                                endif
                                set bj_forLoopAIndex = bj_forLoopAIndex + 1
                            endloop

                            set bj_forLoopAIndex = 21
                            set bj_forLoopAIndexEnd = 24
                            loop
                                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                                if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                    //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                    set i=EvaluateDock(i,GetForLoopIndexA())
                                else
                                endif
                                set bj_forLoopAIndex = bj_forLoopAIndex + 1
                            endloop
                        
                        else
                            if udg_TempUnit2 == gg_unit_h029_0114 then
                            //Lost station
                                set udg_TempBool = false
                                set bj_forLoopAIndex = 25
                                set bj_forLoopAIndexEnd = 26
                                loop
                                    exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                                    if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                        //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                        set i=EvaluateDock(i,GetForLoopIndexA())
                                    else
                                    endif
                                    set bj_forLoopAIndex = bj_forLoopAIndex + 1
                                endloop
                            else
                                if udg_TempUnit2 == gg_unit_h02B_0116 then
                                //Pirate vessel
                                    set udg_TempBool = false
                                    set bj_forLoopAIndex = 27
                                    set bj_forLoopAIndexEnd = 28
                                    loop
                                        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                                        if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                            //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                            set i=EvaluateDock(i,GetForLoopIndexA())
                                        else
                                        endif
                                        set bj_forLoopAIndex = bj_forLoopAIndex + 1
                                    endloop
                                    set bj_forLoopAIndex = 45
                                    set bj_forLoopAIndexEnd = 46
                                    loop
                                        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                                        if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                            //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                            set i=EvaluateDock(i,GetForLoopIndexA())
                                        else
                                        endif
                                        set bj_forLoopAIndex = bj_forLoopAIndex + 1
                                    endloop
                                else
                                if ( udg_TempUnit2 == gg_unit_h03T_0209 ) then
                                //Errun
                                    set udg_TempBool = false
                                    set bj_forLoopAIndex = 41
                                    set bj_forLoopAIndexEnd = 44
                                    loop
                                        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                                        if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                            //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                            set i=EvaluateDock(i,GetForLoopIndexA())
                                        else
                                        endif
                                        set bj_forLoopAIndex = bj_forLoopAIndex + 1
                                    endloop
                                else
                                if udg_TempUnit2==gg_unit_h04T_0265 then
                                //Syllus
                                    set udg_TempBool = false
                                    set bj_forLoopAIndex = 47
                                    set bj_forLoopAIndexEnd = 52
                                    loop
                                        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                                        if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                            //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                            set i=EvaluateDock(i,GetForLoopIndexA())
                                        endif
                                        set bj_forLoopAIndex = bj_forLoopAIndex + 1
                                    endloop
                                else
                                
                                if GetUnitTypeId(udg_TempUnit2) == 'h04G' then
                                    //MRZCODE: IF OVERLORD
                                    set udg_TempBool = false
                                    set bj_forLoopAIndex = 53
                                    set bj_forLoopAIndexEnd = 58
                                    loop
                                        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                                        if udg_All_Dock_Filled[GetForLoopIndexA()] != true then
                                            //set udg_TempDestruct = udg_All_Dock[GetForLoopIndexA()]
                                            set i=EvaluateDock(i,GetForLoopIndexA())
                                        endif
                                        set bj_forLoopAIndex = bj_forLoopAIndex + 1
                                    endloop
                                    
                                    
                                endif
                                
                                endif
                                endif
                                endif
                            endif
                        endif
                    endif
                endif
            endif
        endif
    endif
    
    if udg_TempDestruct != null then
        set udg_SS_LaunchCountdown[GetUnitUserData(udg_TempUnit)] = true
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1379" )
        set udg_TempPoint = GetDestructableLoc(udg_TempDestruct)
        call UnitAddAbility(udg_SS_Space[GetUnitUserData(udg_TempUnit)], 'Avul')
        call SetUnitPositionLoc( udg_SS_Space[GetUnitUserData(udg_TempUnit)], udg_HoldZone )
                call UnitRemoveAbility(udg_SS_Space[GetUnitUserData(udg_TempUnit)], 'Avul')
        call SetUnitPositionLoc( udg_SS_Landed[GetUnitUserData(udg_TempUnit)], udg_TempPoint )
        call ChangeElevatorHeight( udg_TempDestruct, 3 )
        call ChangeElevatorWalls( false, bj_ELEVATOR_WALL_TYPE_ALL, udg_TempDestruct )
        call SetUnitFlyHeightBJ( udg_SS_Landed[GetUnitUserData(udg_TempUnit)], 100.00, 500.00 )
        set udg_SS_DockGroundedAt[GetUnitUserData(udg_TempUnit)] = udg_TempInt
        set udg_All_Dock_Filled[udg_SS_DockGroundedAt[GetUnitUserData(udg_TempUnit)]] = true
        call SetUnitOwner( udg_SS_Space[GetUnitUserData(udg_TempUnit)], Player(PLAYER_NEUTRAL_PASSIVE), false )
        call RemoveLocation( udg_TempPoint )
        set udg_TempPoint = GetRectCenter(udg_Spaceship_Rect[GetUnitUserData(udg_TempUnit)])
        if q == Player(bj_PLAYER_NEUTRAL_EXTRA) then
            call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint, 0 )
        else
            call PanCameraToTimedLocForPlayer( q, udg_TempPoint, 0 )
        endif
        
        call RemoveLocation( udg_TempPoint )
        set udg_TempUnit3 = udg_TempUnit
        call PolledWait( 4.00 )
        call SetUnitLifePercentBJ( a, GetUnitLifePercent(udg_SS_Space[GetUnitAN(a)]) )
        set udg_TempUnit = a
        call ChangeElevatorHeight( udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(udg_TempUnit)]], 1 )
        call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(udg_TempUnit)]] )
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1380" )
        set udg_SS_LaunchCountdown[GetUnitUserData(udg_TempUnit)] = false
    else
        set onr="|cffFF0000No landing pads are available.|r"
        if GetUnitTypeId(b)=='h04V' or GetUnitTypeId(b)=='h04E' then
            set onr="|cffFF0000This station does not use standard docking procedures; please apply standard boarding procedures instead.|r"
        endif
        if q == Player(bj_PLAYER_NEUTRAL_EXTRA) then
            call DisplayTextToPlayer(udg_Parasite, 0,0,onr)
        else
            call DisplayTextToPlayer(q, 0,0,onr)
        endif
        
        set udg_TempPoint=GetUnitLoc(a)
        call SetUnitPositionLoc(a, udg_TempPoint)
        call RemoveLocation(udg_TempPoint)
    endif
endfunction

//===========================================================================
function InitTrig_SSGenDock takes nothing returns nothing
    set gg_trg_SSGenDock = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SSGenDock, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_SSGenDock, Condition( function Trig_SSGenDock_Conditions ) )
    call TriggerAddAction( gg_trg_SSGenDock, function Trig_SSGenDock_Actions )
endfunction

