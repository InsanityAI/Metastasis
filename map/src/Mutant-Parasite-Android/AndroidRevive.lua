//TESH.scrollpos=27
//TESH.alwaysfold=0

function Trig_AndroidRevive_Func001Func014A takes nothing returns nothing
    call SetPlayerAllianceStateBJ( GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED )
    call SetPlayerAllianceStateBJ( udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED )
endfunction

function Trig_AndroidRevive_Func001Func017A takes nothing returns nothing
    call SetPlayerAllianceStateBJ( GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_UNALLIED )
    call SetPlayerAllianceStateBJ( udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION )
endfunction

function Trig_AndroidRevive_Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01H' ) ) then//android card
        return false
    endif
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_AndroidRevive_Actions takes nothing returns nothing
local location a
local effect r
local integer i=1
local integer b=GetInventoryIndexOfItemTypeBJ(GetTriggerUnit(),'I01H')//android card
local item k=UnitItemInSlot(GetTriggerUnit(),b-1)
local unit l=GetTriggerUnit()
local item z

if IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) then
    if b>0 then
   // call UnitDropItem(l,'I01H')
        call RemoveItem( k )
        call DisableTrigger( gg_trg_AndroidUpgradeDialogClick )
        call DisableTrigger(GetTriggeringTrigger())
                call DisableTrigger(gg_trg_AndroidCardVision)
                        call DisableTrigger( gg_trg_AndroidChat )
    call ChangeElevatorWalls( false, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642 )
    call ChangeElevatorHeight( gg_dest_DTrx_0642, 1 )
        set a=GetUnitLoc(gg_unit_h03Z_0188)
        set z=UnitAddItemById(l,'I01I')
        set udg_AndroidRemoteID=GetRandomInt(1,999999999)
        call SetItemUserData(z,udg_AndroidRemoteID)
        call RemoveLocation(a)
        set a = GetRectCenter(gg_rct_AndroidUpgrade)
        loop
            exitwhen i > 60
            set r= AddSpecialEffectLocBJ( a, "war3mapImported\\AncientExplode.mdx" )
            call PolledWait( 0.50 )
            call DestroyEffectBJ(r )
            set i=i+ 1
        endloop
        set udg_TempPoint=a
        set udg_TempPlayer = udg_HiddenAndroid
        if  udg_UpgradePointsAndroid >= 2000.00  then
            call CreateNUnitsAtLoc( 1, udg_Android_Preference, udg_TempPlayer, udg_TempPoint, bj_UNIT_FACING )
        else
            call CreateNUnitsAtLoc( 1, 'h00H', udg_TempPlayer, udg_TempPoint, bj_UNIT_FACING )
        endif
                            call ShowInterfaceForceOn( GetForceOfPlayer(udg_HiddenAndroid), 0.01 )
        set udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit()
        call SetPlayerName( udg_TempPlayer, udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)] )
        call PanCameraToTimedLocForPlayer( udg_TempPlayer, udg_TempPoint, 0 )
        call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_TempPlayer )
        call ForceRemovePlayerSimple( udg_TempPlayer, udg_DeadGroup )
        call ForForce( GetPlayersAll(), function Trig_AndroidRevive_Func001Func014A )
        call SetPlayerAllianceStateBJ( Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPlayer, bj_ALLIANCE_ALLIED )
        call SetPlayerAllianceStateBJ( udg_TempPlayer, Player(bj_PLAYER_NEUTRAL_EXTRA), bj_ALLIANCE_ALLIED )
        call ForForce( udg_DeadGroup, function Trig_AndroidRevive_Func001Func017A )
        call RemoveLocation( udg_TempPoint )
                call EnableTrigger( gg_trg_AndroidUpgradeDialogClick )
        call RemoveLocation(udg_TempPoint)
            call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642 )
    call ChangeElevatorHeight( gg_dest_DTrx_0642, 1 )
    call EnableTrigger(gg_trg_AndroidRevive)
    
    if udg_PlayerRole[GetConvertedPlayerId(udg_HiddenAndroid)]==7 then
    set udg_TempPlayer=udg_HiddenAndroid
        call CreateNUnitsAtLoc( 1, 'H046', udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING )
    set udg_TempUnit = GetLastCreatedUnit()
    set udg_TempUnit2 = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]
    call ExecuteFunc( "RoboButler" )
    endif
    endif
    endif
endfunction

//===========================================================================
function InitTrig_AndroidRevive takes nothing returns nothing
    set gg_trg_AndroidRevive = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_AndroidRevive, gg_rct_Fabricate )
    call TriggerAddAction( gg_trg_AndroidRevive, function Trig_AndroidRevive_Actions )
endfunction

