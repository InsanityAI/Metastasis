//TESH.scrollpos=147
//TESH.alwaysfold=0
function Trig_PlayerDeath_Func001C takes nothing returns boolean
    if   udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] != GetDyingUnit()   then
        return true
            endif
    if GetOwningPlayer(GetDyingUnit()) == Player(14) then
    return true

    endif
    return false
endfunction

function Trig_PlayerDeath_Func002Func002Func002Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_SpawnType == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerDeath_Func002Func002Func002Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetDyingUnit()) != udg_HiddenAndroid ) ) then
        return false
    endif
    if ( not ( udg_SpawnTemp == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerDeath_Func002Func002Func002Func001Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerDeath_Func002Func002Func002Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerDeath_Func002Func002Func002C takes nothing returns boolean
    if ( not ( udg_HiddenAndroid_Risen == true ) ) then
        return false
    endif
    if ( not ( udg_HiddenAndroid == GetOwningPlayer(GetDyingUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerDeath_Func002Func002C takes nothing returns boolean
    if ( not ( udg_Parasite == GetOwningPlayer(GetDyingUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerDeath_Func002C takes nothing returns boolean
    if ( not ( udg_Mutant == GetOwningPlayer(GetDyingUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerDeath_Func007Func007A takes nothing returns nothing
    call SetPlayerAllianceStateBJ( GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED_VISION )
     call SetPlayerAllianceStateBJ( udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED )
endfunction

function Trig_PlayerDeath_Func007Func010A takes nothing returns nothing
    call SetUnitOwner( GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true )
endfunction

function Trig_PlayerDeath_Func007C takes nothing returns boolean
    if ( not ( GetOwningPlayer(udg_TempUnit) == udg_HiddenAndroid ) ) then
        return false
    endif
    if ( not ( udg_HiddenAndroid_Risen == false ) ) then
        return false
    endif
    if ( not ( GetPlayerSlotState(GetOwningPlayer(udg_TempUnit)) == PLAYER_SLOT_STATE_PLAYING ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerDeath_Actions takes nothing returns nothing
local unit a=GetDyingUnit()
local player k=GetOwningPlayer(a)
    if ( Trig_PlayerDeath_Func001C() ) then
        set udg_SpawnTemp = false
        return
    endif
    set udg_DeadPlayer_Cash[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = GetPlayerState(GetOwningPlayer(GetDyingUnit()), PLAYER_STATE_RESOURCE_GOLD)
    if ( Trig_PlayerDeath_Func002C() ) then
        call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1046" )
        call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0.00, 100.00, 0, 50.00 )
        call PlaySoundBJ( gg_snd_AbominationAlternateDeath1 )

        call DestroyTrigger( gg_trg_MutantUpgrade )
    else
        if ( Trig_PlayerDeath_Func002Func002C() ) then
            call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1045" )
            call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0.00, 0.00, 100.00, 50.00 )
            call PlaySoundBJ( gg_snd_WarlockDeath1 )
  
        else
            if ( Trig_PlayerDeath_Func002Func002Func002C() ) then
                call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
                call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1044" )
                call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 100.00, 100.00, 50.00 )
                call PlaySoundBJ( gg_snd_RockGolemDeath1 )
            else
                if ( Trig_PlayerDeath_Func002Func002Func002Func001C() ) then
                    call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
                    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1043" )
                    call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0.00, 0.00, 100.00, 50.00 )
                    call PlaySoundBJ( gg_snd_PitFiendDeath1 )
                else
                    if ( Trig_PlayerDeath_Func002Func002Func002Func001Func001C() ) then
                        call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
                        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1042" )
                        call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0.00, 100.00, 100.00, 50.00 )
                        call PlaySoundBJ( gg_snd_BansheeDeath )
                    else
                        if ( Trig_PlayerDeath_Func002Func002Func002Func001Func001Func001C() ) then
                            if ( Trig_PlayerDeath_Func002Func002Func002Func001Func001Func001Func001C() ) then
                                set udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = true
                                call ForceAddPlayerSimple( udg_Mutant, udg_SentryGunAllies[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] )
                                set udg_TempPoint = GetUnitLoc(GetDyingUnit())
                                call CreateNUnitsAtLoc( 1, udg_MutantChildInfectee, GetOwningPlayer(GetDyingUnit()), udg_TempPoint, bj_UNIT_FACING )
                                call AdjustPlayerStateBJ( 120, udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER )
                                call RemoveLocation( udg_TempPoint )
                                set udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = GetLastCreatedUnit()
                                call DisplayTextToPlayer( GetOwningPlayer(GetDyingUnit()), 0, 0, "TRIGSTR_1594" )
                                call TriggerExecute( gg_trg_WinCheck )
                                return
                            else
                                set udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = true
                                call ForceAddPlayerSimple( udg_Parasite, udg_SentryGunAllies[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] )
                                set udg_TempPoint = GetUnitLoc(GetDyingUnit())
                                call CreateNUnitsAtLoc( 1, udg_ParasiteChildInfectee, GetOwningPlayer(GetDyingUnit()), udg_TempPoint, bj_UNIT_FACING )
                                call AdjustPlayerStateBJ( 120, udg_Parasite, PLAYER_STATE_RESOURCE_LUMBER )
                                call RemoveLocation( udg_TempPoint )
                                set udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = GetLastCreatedUnit()
                                call DisplayTextToPlayer( GetOwningPlayer(GetDyingUnit()), 0, 0, "TRIGSTR_1595" )
                                set udg_TempPlayer=GetOwningPlayer(GetDyingUnit())
                                    call TriggerExecute( gg_trg_ParasiteSpawnCreateSpell )
                                call TriggerExecute( gg_trg_WinCheck )
                                return
                            endif
                        else
                            call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
                            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1041" )
                            call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 0.00, 0.00, 50.00 )
                            call PlaySoundBJ( gg_snd_PeasantDeath )

                        endif
                    endif
                endif
            endif
        endif
    endif
    set udg_SpawnTemp = false
    call TriggerSleepAction( 4.00 )
    if ( Trig_PlayerDeath_Func007C() ) then
        set udg_HiddenAndroid_Risen = true
        set udg_HiddenAndroid_Rising=true
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1048" )
        set udg_HiddenAndroidTempPoint = GetUnitLoc(a)
        call TriggerSleepAction( 5.00 )
        call CreateNUnitsAtLoc( 1, 'e002', Player(PLAYER_NEUTRAL_PASSIVE), udg_HiddenAndroidTempPoint, bj_UNIT_FACING )
        call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 2, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 100.00, 100.00, 0 )
        if UnitHasItemOfTypeBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], 'I013') then
        call CreateNUnitsAtLoc( 1, 'h02U', udg_HiddenAndroid, udg_HiddenAndroidTempPoint, bj_UNIT_FACING )
        else
        call CreateNUnitsAtLoc( 1, 'h02F', udg_HiddenAndroid, udg_HiddenAndroidTempPoint, bj_UNIT_FACING )
        endif
        set udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))] = GetLastCreatedUnit()
        call DisplayTimedTextToPlayer( udg_HiddenAndroid, 0, 0, 30, "TRIGSTR_1049" )
        call DisplayTimedTextToForce( GetPlayersEnemies(udg_HiddenAndroid), 30, "TRIGSTR_1050" )
        call RemoveLocation( udg_HiddenAndroidTempPoint )
        set udg_HiddenAndroid_Rising=false
        call TriggerExecute( gg_trg_WinCheck )
        return
    else
    set udg_TempPoint=GetUnitLoc(a)
        call CreateItemLoc( 'I00P', udg_TempPoint )
        call SetItemUserData( GetLastCreatedItem(), GetConvertedPlayerId(k) )
        call RemoveLocation( udg_TempPoint )
        call DisplayTextToPlayer( GetOwningPlayer(udg_TempUnit), 0, 0, "TRIGSTR_1367" )
        set udg_Player_Spectating[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))] = true
        set udg_TempPlayer=k
        call SetPlayerAllianceStateBJ( Player(14), k, bj_ALLIANCE_ALLIED_VISION )
        call ForForce( GetPlayersAll(), function Trig_PlayerDeath_Func007Func007A )

        call ForceAddPlayerSimple( k, udg_DeadGroup )
        set udg_Player_NameBeforeDead[GetConvertedPlayerId(k)]=GetPlayerName(k)
        call SetPlayerName( k, GetPlayerName(k) + (( ( ( ( "                                                                                                                                                                                                                                                " + "                                                                                                                                                                                                                                                " ) + "                                                                                                                                                                                                                                                " ) + "                                                                                                                                                                                                                                                " ) + "                                                                                                                                                                                                                                                " ) ) )
        call ForGroupBJ( GetUnitsOfPlayerAll(k), function Trig_PlayerDeath_Func007Func010A )
    endif
    call TriggerExecute( gg_trg_WinCheck )
endfunction

//===========================================================================
function InitTrig_PlayerDeath takes nothing returns nothing
    set gg_trg_PlayerDeath = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_PlayerDeath, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddAction( gg_trg_PlayerDeath, function Trig_PlayerDeath_Actions )
endfunction

