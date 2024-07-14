//TESH.scrollpos=132
//TESH.alwaysfold=0
function Trig_SSGenControl_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)]) == Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    if ( not ( IsUnitIllusionBJ(GetTriggerUnit()) == false ) ) then
        return false
    endif
    if ( not ( GetUnitPointValue(GetTriggerUnit()) != 37 ) ) then
        return false
    endif
    return true
endfunction


//function CheckMaintainSpaceshipControl_Child takes nothing returns nothing
//if GetOwningPlayer(GetEnumUnit())==GetOwningPlayer(udg_TempUnit) and SubStringBJ(I2S(GetUnitPointValue(GetEnumUnit())), 1, 1) == "2" and IsUnitIllusion(GetEnumUnit()) == false then
//set udg_TempBool=true
//endif
//endfunction

//function CheckMaintainSpaceshipControl takes nothing returns nothing
//local timer t=GetExpiredTimer()
//local unit p=LoadUnitHandle(LS(),GetHandleId(t),StringHash("ship"))
//local rect r=udg_Spaceship_ControlRect[GetUnitAN(p)]
//local group g=GetUnitsInRectAll(r)
//set udg_TempBool=false
//set udg_TempUnit=p
//call ForGroup(g,function CheckMaintainSpaceshipControl_Child)
//call DestroyGroup(g)
//if udg_TempBool==false then
//call FlushChildHashtable(LS(),GetHandleId(t))
//call PauseTimer(t)
//call DestroyTimer(t)
//call SetUnitOwner( udg_Spaceship_Console[GetUnitUserData(p)], Player(PLAYER_NEUTRAL_PASSIVE), false )
//call SetUnitOwner( udg_SS_Space[GetUnitUserData(p)], Player(PLAYER_NEUTRAL_PASSIVE), false )
//endif
//endfunction


function CheckLaunchProceed takes nothing returns nothing
    if SubStringBJ(I2S(GetUnitPointValue(GetEnumUnit())), 1, 1) == "2" and IsUnitIllusion(GetEnumUnit()) == false then
        set udg_TempBool=true
    endif
endfunction

function Trig_SSGenControl_Actions takes nothing returns nothing
    local unit a
    local unit d=GetTriggerUnit()
    local group k

    if udg_Blackout then
        return
    endif

    if ( SubStringBJ(I2S(GetUnitPointValue(GetTriggerUnit())), 1, 1) == "1"  ) then
        call DisplayTimedTextToPlayer( GetOwningPlayer(GetTriggerUnit()), 0, 0, 10.00, "TRIGSTR_1376" )
        return
    endif
    
    if ( RectContainsUnit(gg_rct_Space, udg_SS_Space[GetUnitUserData(udg_TempUnit)]) == true ) then
        if GetOwningPlayer(GetTriggerUnit()) != Player(14) then
            call CheckConsoleControl(udg_Spaceship_Console[GetUnitAN(udg_TempUnit)],udg_SS_Space[GetUnitAN(udg_TempUnit)],udg_Spaceship_Rect[GetUnitAN(udg_TempUnit)])
            call SetUnitOwner( udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()), false )
            call DisplayTextToPlayer( GetOwningPlayer(GetTriggerUnit()), 0, 0, ( "|cff8000FFU.S.I. Explorer Class|r" + "" ) )
            call DisplayTextToPlayer( GetOwningPlayer(GetTriggerUnit()), 0, 0, ( " |cff00FF00Access Granted|r" + "" ) )
            call SelectUnitForPlayerSingle( udg_SS_Space[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()) )
            call SetUnitOwner( udg_SS_Space[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()), false )
            set udg_TempPoint = GetUnitLoc(udg_SS_Space[GetUnitUserData(udg_TempUnit)])
            if udg_Unit_VendorDisabling[GetUnitAN(GetTriggerUnit())]==false then
                call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0 )
            endif
            call RemoveLocation( udg_TempPoint )
            
            //If Ace, add Ace attack speed ability
            if (GetUnitAbilityLevel(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], udg_RoleAbility[11]) == 1 ) then
                call UnitAddAbility(udg_SS_Space[GetUnitUserData(udg_TempUnit)],  'A0A5' )
            endif
        else
            call SetUnitOwner( udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()), false )
            call DisplayTextToPlayer( udg_Parasite, 0, 0, ( "|cff8000FFU.S.I. Explorer Class|r" + "" ) )
            call DisplayTextToPlayer( udg_Parasite, 0, 0, ( " |cff00FF00Access Granted|r" + "" ) )
            call SelectUnitForPlayerSingle( udg_SS_Space[GetUnitUserData(udg_TempUnit)], udg_Parasite )
            call SetUnitOwner( udg_SS_Space[GetUnitUserData(udg_TempUnit)], GetOwningPlayer(GetTriggerUnit()), false )
            set udg_TempPoint = GetUnitLoc(udg_SS_Space[GetUnitUserData(udg_TempUnit)])
            if udg_Unit_VendorDisabling[GetUnitAN(GetTriggerUnit())]==false then
                call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint, 0 )
            endif
            call RemoveLocation( udg_TempPoint )
        endif
    else
        if IsTriggerEnabled(gg_trg_SwaggerTeleportToPlanet) and udg_SS_Harbor[GetUnitUserData(udg_TempUnit)] == gg_unit_h00X_0049 then
            return
        endif
        set a=udg_TempUnit
        call DisableTrigger( udg_Spaceship_ControlTrig[GetUnitUserData(a)] )
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1370" )
        
            set udg_TempUnit = udg_SS_Landed[GetUnitUserData(udg_TempUnit)]
            set udg_TempInt=80
            set udg_TempReal=1/8.0
            set udg_TempString="DoNothing"
            
        set udg_CountUpBarColor = "|cff80FFFF"
        call ExecuteFunc("BarLocal_RunDummy")
        call SaveBoolean(LS(),GetHandleId(udg_TempUnit),StringHash("LaunchCleared"),true)
        
        call PolledWait( 7.00 )
        set k=GetUnitsInRectAll(udg_Spaceship_Rect[GetUnitUserData(a)])
        set udg_TempBool=false
        call ForGroup(k,function CheckLaunchProceed)
        call DestroyGroup(k)
        set k=null
        if LoadBoolean(LS(),GetHandleId(udg_SS_Landed[GetUnitUserData(a)]),StringHash("LaunchCleared"))==false then
            set udg_TempBool=false
        endif
        if udg_TempBool==false then
            call DisplayTextToForce( GetPlayersAll(), "|cff008040Explorer launch cancelled.|r" )
            call EnableTrigger( udg_Spaceship_ControlTrig[GetUnitUserData(a)] )
            return
        else
            set udg_SS_LaunchCountdown[GetUnitUserData(a)] = true
        endif
        
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1373" )
        call PolledWait( 1.00 )
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1377" )
        call ChangeElevatorWalls( false, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(a)]] )
        call PolledWait( 0.20 )
        call ChangeElevatorHeight( udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(a)]], 3 )
        call PolledWait( 1.20 )
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1378" )
        call SetUnitFlyHeightBJ( udg_SS_Landed[GetUnitUserData(a)], 2000.00, 1500.00 )
        call PolledWait( 1.00 )
        
        if GetUnitState(a,UNIT_STATE_LIFE) == 0 then
            call DisplayTextToForce(GetPlayersAll(), "ERROR: Explorer vessel not responsive.")
            return
        endif
        
        if RectContainsUnit(udg_Spaceship_ControlRect[GetUnitUserData(a)], d) then
            set udg_TempPoint=GetUnitLoc(d)
            call SetUnitPositionLoc(d,udg_HoldZone)
            call SetUnitPositionLoc(d,udg_TempPoint)
            call RemoveLocation(udg_TempPoint)
        endif
        
        call SetUnitLifePercentBJ( udg_SS_Space[GetUnitAN(a)], GetUnitLifePercent(a) )
        set udg_SS_LaunchCountdown[GetUnitUserData(a)] = false
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1374" )
        set udg_TempPoint = GetUnitLoc(udg_SS_Harbor[GetUnitUserData(a)])
        call SetUnitPositionLoc( udg_SS_Space[GetUnitUserData(a)], udg_TempPoint )
        call SetUnitPositionLoc( udg_SS_Landed[GetUnitUserData(a)], udg_HoldZone )
        call RemoveLocation( udg_TempPoint )
        call RemoveLocation( udg_TempPoint2 )
        call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(a)]] )
        call ChangeElevatorHeight( udg_All_Dock[udg_SS_DockGroundedAt[GetUnitUserData(a)]], 1 )
        set udg_All_Dock_Filled[udg_SS_DockGroundedAt[GetUnitUserData(a)]] = false
        set udg_SS_DockGroundedAt[GetUnitUserData(a)] = 0
        call EnableTrigger( udg_Spaceship_ControlTrig[GetUnitUserData(a)] )
    endif
endfunction

//===========================================================================
function InitTrig_SSGenControl takes nothing returns nothing
    set gg_trg_SSGenControl = CreateTrigger(  )
    call TriggerAddCondition( gg_trg_SSGenControl, Condition( function Trig_SSGenControl_Conditions ) )
    call TriggerAddAction( gg_trg_SSGenControl, function Trig_SSGenControl_Actions )
endfunction

