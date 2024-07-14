//TESH.scrollpos=33
//TESH.alwaysfold=0
globals
    boolean hasRevivedAsPacificationBot = false
endglobals

function Trig_AndroidPacificationRevive_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A094' ) ) then
    return false
    endif
    if GetSpellTargetUnit() != gg_unit_h04A_0144 then
    return false
    endif
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_AndroidPacificationRevive_Actions takes nothing returns nothing
    local item z
    local unit q=GetSpellAbilityUnit()
    local integer i=0
    loop
        exitwhen i>5
        if GetItemTypeId(UnitItemInSlot(q,i))=='I01H' then//Android Card
            call RemoveItem(UnitItemInSlot(q,i))
            set i=10//endloop ;)
        endif
        set i=i+1
    endloop
    
    set udg_TempPlayer=udg_HiddenAndroid
    set udg_TempPoint=GetUnitLoc(gg_unit_h04A_0144)
    //set udg_TempPoint2=PolarProjectionBJ(udg_TempPoint,45.0,GetRandomDirectionDeg())
    //set udg_TempUnit=ReplaceUnitBJ(gg_unit_h04A_0144,GetUnitTypeId(gg_unit_h04A_0144),bj_UNIT_STATE_METHOD_RELATIVE)
    call UnitAddAbility(gg_unit_h04A_0144,'AInv')//Inventory(Hero)
    //set z=CreateItemLoc('I01I',udg_TempPoint2)
    set z=UnitAddItemById(q,'I01I')//Remote Control
    
    //Make the remote control unique/final
    set udg_AndroidRemoteID=GetRandomInt(1,999999999)
    call SetItemUserData(z,udg_AndroidRemoteID)
    
    //Change ownership of the pacification bot, to the android
    call SetUnitOwner(gg_unit_h04A_0144,udg_TempPlayer,true)
    call ShowInterfaceForceOn( GetForceOfPlayer(udg_HiddenAndroid), 0.01 )
    
    //Set pacification bot as the playerhero of the android
    set udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = gg_unit_h04A_0144
    
    //Rename the player to his name before death
    call SetPlayerName( udg_TempPlayer, udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)] )
    
    //Set the boolean so we know he died as pacification bot
    set hasRevivedAsPacificationBot = true
        
        call DisableTrigger( gg_trg_AndroidUpgradeDialogClick )
        call DisableTrigger(GetTriggeringTrigger())
        call DisableTrigger(gg_trg_AndroidCardVision)
        call DisableTrigger( gg_trg_AndroidChat )
        
        call PanCameraToTimedLocForPlayer( udg_TempPlayer, udg_TempPoint, 0 )
        call SelectUnitForPlayerSingle( gg_unit_h04A_0144, udg_TempPlayer )
        call ForceRemovePlayerSimple( udg_TempPlayer, udg_DeadGroup )
        call ForForce( GetPlayersAll(), function Trig_AndroidRevive_Func001Func014A )
        call SetPlayerAllianceStateBJ( Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPlayer, bj_ALLIANCE_ALLIED )
        call SetPlayerAllianceStateBJ( udg_TempPlayer, Player(bj_PLAYER_NEUTRAL_EXTRA), bj_ALLIANCE_ALLIED )
        call ForForce( udg_DeadGroup, function Trig_AndroidRevive_Func001Func017A )
                
        //Clean Memory Leaks
        call RemoveLocation(udg_TempPoint)
        //call PauseUnitForPeriod(udg_TempUnit,4.0)
        call RemoveLocation(udg_TempPoint2)
                
        //If CEO -> Create Robo-Butler unit
        if udg_PlayerRole[GetConvertedPlayerId(udg_HiddenAndroid)]==7 then//If Android == CEO
            set udg_TempPlayer=udg_HiddenAndroid
            call CreateNUnitsAtLoc( 1, 'H046', udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING )
            set udg_TempUnit = GetLastCreatedUnit()
            set udg_TempUnit2 = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]
            call ExecuteFunc( "RoboButler" )
        endif
endfunction

//===========================================================================
function InitTrig_AndroidPacificationRevive takes nothing returns nothing
    set gg_trg_AndroidPacificationRevive = CreateTrigger(  )
     call TriggerRegisterAnyUnitEventBJ( gg_trg_AndroidPacificationRevive, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    //call TriggerRegisterUnitEvent( gg_trg_AndroidPacificationRevive, gg_unit_h04A_0144, EVENT_UNIT_PICKUP_ITEM )
    call TriggerAddCondition( gg_trg_AndroidPacificationRevive, Condition( function Trig_AndroidPacificationRevive_Conditions ) )
    call TriggerAddAction( gg_trg_AndroidPacificationRevive, function Trig_AndroidPacificationRevive_Actions )
endfunction

