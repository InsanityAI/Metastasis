//TESH.scrollpos=172
//TESH.alwaysfold=0
function Trig_EscapePod_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetSoldItem()) == 'I010' ) ) then
        return false
    endif
    return true
endfunction

function Trig_EscapePod_Func002Func001C takes nothing returns boolean
    if ( not ( udg_EscapePodVendor_Harbor[GetUnitUserData(GetSellingUnit())] == gg_unit_h00X_0049 ) ) then
        return false
    endif
    if ( not ( IsTriggerEnabled(gg_trg_SwaggerTeleportToPlanet) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_EscapePod_Func002C takes nothing returns boolean
    if ( not Trig_EscapePod_Func002Func001C() ) then
        return false
    endif
    if (udg_Blackout == true) then
        return true
    endif
    return true
endfunction

function Trig_EscapePod_Func003Func029Func001C takes nothing returns boolean
    if ( ( udg_Parasite == GetOwningPlayer(udg_TempUnit) ) ) then
        return true
    endif
    if ( ( Player(bj_PLAYER_NEUTRAL_EXTRA) == GetOwningPlayer(udg_TempUnit) ) ) then
        return true
    endif
    return false
endfunction

function Trig_EscapePod_Func003Func029C takes nothing returns boolean
    if ( not Trig_EscapePod_Func003Func029Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_EscapePod_Func003Func033C takes nothing returns boolean
    if ( ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetBuyingUnit()))] != GetBuyingUnit() ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetBuyingUnit()) == 'h01Q' ) ) then
        return true
    endif
    if ( ( GetOwningPlayer(GetBuyingUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return true
    endif
    return false
endfunction

function Trig_EscapePod_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetBuyingUnit()) != 'e00L' ) ) then
        return false
    endif
    if ( not Trig_EscapePod_Func003Func033C() ) then
        return false
    endif
    return true
endfunction

function PodDamageCheck takes nothing returns nothing
local trigger om=GetTriggeringTrigger()
local real damage=LoadReal(LS(),GetHandleId(om),StringHash("damagetaken"))+GetEventDamage()
local unit b= LoadUnitHandle(LS(),GetHandleId(om),StringHash("b"))
local unit c=LoadUnitHandle(LS(),GetHandleId(om),StringHash("c"))
if udg_ShieldHP[GetUnitAN(GetTriggerUnit())]>0.0 then
set damage=300.0
endif
call SaveReal(LS(),GetHandleId(om),StringHash("damagetaken"),damage)
if damage >= 35.0 then
call ShowUnitHide(b)
call ShowUnitHide(c)
call SetUnitPosition(b,GetLocationX(udg_HoldZone),GetLocationY(udg_HoldZone))
call SetUnitPosition(c,GetLocationX(udg_HoldZone),GetLocationY(udg_HoldZone))
endif
endfunction

function Trig_EscapePod_Actions takes nothing returns nothing
local unit b
local unit c
local unit d=GetBuyingUnit()
local location e
local unit q=GetSellingUnit()
local trigger om

    if GetUnitTypeId(d)=='e00L' then
        set d=udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(d))]
    endif
    
    call RemoveItem( GetSoldItem() )
    if TimerGetElapsed(udg_GameTimer)-udg_Player_LastPodTime[GetConvertedPlayerId(GetOwningPlayer(d))]<100.0 then
        call DisplayTextToPlayer( GetOwningPlayer(d), 0, 0, "|cffFF0000We're sorry, but you may not use a pod at this time. Please wait " + R2S(100-(TimerGetElapsed(udg_GameTimer)-udg_Player_LastPodTime[GetConvertedPlayerId(GetOwningPlayer(d))])) +" seconds." )   
        return
    endif
    if ( Trig_EscapePod_Func002C() ) or GetUnitAbilityLevel(d,'A07E')>0 then
        call DisplayTextToPlayer( GetOwningPlayer(d), 0, 0, "TRIGSTR_2849" )
        //call AdjustPlayerStateBJ( 2000, GetOwningPlayer(d), PLAYER_STATE_RESOURCE_GOLD )
        return
    endif
    if GetUnitTypeId(d)=='h02X' then
        call DisplayTextToPlayer( GetOwningPlayer(d), 0, 0, "TRIGSTR_2849" )
        return
    endif
    
    if ( Trig_EscapePod_Func003C() ) then
        call DisplayTextToPlayer( GetOwningPlayer(d), 0, 0, "TRIGSTR_2852" )
        //call AdjustPlayerStateBJ( 2000, GetOwningPlayer(d), PLAYER_STATE_RESOURCE_GOLD )
    else
  
        set udg_TempPoint3 = GetUnitLoc(d)
        call CreateNUnitsAtLoc( 1, 'e01F', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint3, GetRandomDirectionDeg() )
        call SetUnitFlyHeightBJ( GetLastCreatedUnit(), 180.00, 45.00 )
        set b=GetLastCreatedUnit()
        call CreateNUnitsAtLoc( 1, 'e01F', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint3, GetRandomDirectionDeg() )
        call SetUnitFlyHeightBJ( GetLastCreatedUnit(), 180.00, 0.00 )
        call SetUnitFlyHeightBJ( GetLastCreatedUnit(), 0.00, 45.00 )
        set c=GetLastCreatedUnit()
        set om=CreateTrigger()
        call TriggerRegisterUnitEvent(om,d,EVENT_UNIT_DAMAGED)
        call TriggerAddAction(om,function PodDamageCheck)
        call SaveReal(LS(),GetHandleId(om),StringHash("damagetaken"),0)
        call SaveUnitHandle(LS(),GetHandleId(om),StringHash("b"),b)
        call SaveUnitHandle(LS(),GetHandleId(om),StringHash("c"),c)
        set udg_TempUnit = c
        set udg_CountUpBarColor = "|cff00FF00"
        call DisplayTextToPlayer( GetOwningPlayer(d), 0, 0, "TRIGSTR_2850" )
        call RemoveLocation( udg_TempPoint3 )
        set e=GetUnitLoc(d)
        call CountUpBar(udg_TempUnit, 40, 0.1, "DoNothing")
        if GetUnitAbilityLevel(d,'A07E')>0 then
           call DisplayTextToPlayer( GetOwningPlayer(d), 0, 0, "TRIGSTR_2849" )
        return
        endif
        set udg_TempUnit = d
        if ( GetUnitTypeId(udg_TempUnit) == 'e00L' ) then
            set udg_TempUnit = udg_AlienForm_Alien
        else
        endif
        set udg_TempPoint3=GetUnitLoc(d)
        if GetUnitAbilityLevel(udg_TempUnit,'A07E')>=1 or LoadReal(LS(),GetHandleId(om),StringHash("damagetaken"))>=35.0 or IsUnitDeadBJ(udg_TempUnit) == true or DistanceBetweenPoints(udg_TempPoint3,e) >= 90.0 then
            call DisplayTextToPlayer( GetOwningPlayer(d), 0, 0, "TRIGSTR_2851" )
          //  call AdjustPlayerStateBJ( 2000, GetOwningPlayer(udg_TempUnit), PLAYER_STATE_RESOURCE_GOLD )
              call RemoveLocation(e)
        call RemoveLocation(udg_TempPoint3)
                call FlushChildHashtable(LS(),GetHandleId(om))
        call DestroyTrigger(om)
        call ShowUnitHide(b)
        call ShowUnitHide(c)
            return
        else
                call FlushChildHashtable(LS(),GetHandleId(om))
        call DestroyTrigger(om)
        call ShowUnitHide(b)
        call ShowUnitHide(c)
        call RemoveLocation(e)
        call RemoveLocation(udg_TempPoint3)
        endif
          set udg_Player_LastPodTime[GetConvertedPlayerId(GetOwningPlayer(d))]=TimerGetElapsed(udg_GameTimer)
        call ShowUnitHide( udg_TempUnit )
        call PauseUnitBJ( true, udg_TempUnit )
        call UnitAddAbilityBJ( 'A04V', udg_TempUnit )
        call SetUnitPositionLoc( udg_TempUnit, udg_HoldZone )
        set udg_TempPoint = GetUnitLoc(udg_EscapePodVendor_Harbor[GetUnitUserData(q)])
        call CreateNUnitsAtLoc( 1, 'h02P', GetOwningPlayer(udg_TempUnit), udg_TempPoint, bj_UNIT_FACING )
        call NewUnitRegister(GetLastCreatedUnit())
        call SaveInteger(LS(),GetHandleId(GetLastCreatedUnit()),StringHash("PushTolerance"),0)
        set udg_EscapePod_LifeReset[GetUnitUserData(GetLastCreatedUnit())] = GetUnitLifePercent(udg_TempUnit)
        set udg_EscapePod_Owner[GetUnitUserData(GetLastCreatedUnit())] = GetOwningPlayer(udg_TempUnit)
        if ( udg_TempUnit == udg_AlienForm_Alien ) then
            call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Parasite )
            call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint, 1 )
        else
            call SelectUnitForPlayerSingle( GetLastCreatedUnit(), GetOwningPlayer(udg_TempUnit) )
            call PanCameraToTimedLocForPlayer( GetOwningPlayer(udg_TempUnit), udg_TempPoint, 0 )
        endif
        call RemoveLocation( udg_TempPoint )
        call RemoveLocation( udg_TempPoint2 )
        if ( udg_Mutant == GetOwningPlayer(udg_TempUnit) ) then
            call DisableTrigger( gg_trg_MutantUpgrade )
        endif
        if ( Trig_EscapePod_Func003Func029C() ) then
            call DisableTrigger( gg_trg_ParasiteUpgrade )
        endif
    endif
endfunction

//===========================================================================
function InitTrig_EscapePod takes nothing returns nothing
    set gg_trg_EscapePod = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_EscapePod, EVENT_PLAYER_UNIT_SELL_ITEM )
    call TriggerAddCondition( gg_trg_EscapePod, Condition( function Trig_EscapePod_Conditions ) )
    call TriggerAddAction( gg_trg_EscapePod, function Trig_EscapePod_Actions )
endfunction

