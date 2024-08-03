function Trig_Chooser_Func004A takes nothing returns nothing
    set udg_Player_OriginalName[GetConvertedPlayerId(GetEnumPlayer())] = GetPlayerName(GetEnumPlayer())
    if GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING then
        call ForceAddPlayerSimple( GetEnumPlayer(), udg_ChooseGroup )
        set udg_TempInt = udg_TempInt + 1
    endif
endfunction

function Trig_Chooser_Func005Func001Func001C takes nothing returns boolean
    if ( not ( CountPlayersInForceBJ(udg_ChooseGroup) < 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func005Func001Func003C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 2) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func005Func001C takes nothing returns boolean
    if ( not ( CountPlayersInForceBJ(udg_ChooseGroup) <= 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func005C takes nothing returns boolean
    if ( not ( CountPlayersInForceBJ(udg_ChooseGroup) <= 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func006Func001C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 1) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func006C takes nothing returns boolean
    if ( not ( udg_Allow_Android == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func007C takes nothing returns boolean
    if ( not ( udg_Allow_Parasite == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func008C takes nothing returns boolean
    if ( not ( udg_Allow_Mutant == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func009Func001Func003Func001C takes nothing returns boolean
    if ( not ( GetEnumPlayer() == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func009Func001Func003C takes nothing returns boolean
    if ( not ( GetEnumPlayer() == udg_Parasite ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func009Func001C takes nothing returns boolean
    if ( not ( GetEnumPlayer() == udg_Mutant ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func009A takes nothing returns nothing
    if ( Trig_Chooser_Func009Func001C() ) then
        call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "|cffFF00FFYOU ARE THE MUTANT|r")
        call SetPlayerStateBJ( GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 100 )
    else
        if ( Trig_Chooser_Func009Func001Func003C() ) then
            call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "|cffFF8000YOU ARE THE ALIEN|r")
            call SetPlayerStateBJ( GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 100 )
        else
            if ( Trig_Chooser_Func009Func001Func003Func001C() ) then
                call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "|cffFF8000YOU ARE THE ANDROID|r")
                call SetPlayerStateBJ( GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 100 )
            else
                call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "|cff808000YOU ARE HUMAN|r")
            endif
        endif
    endif
endfunction

function Trig_Chooser_Func012Func001C takes nothing returns boolean
    if ( not ( GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func012A takes nothing returns nothing
    if ( Trig_Chooser_Func012Func001C() ) then
        call ForceAddPlayerSimple( GetEnumPlayer(), udg_ChooseGroup )
    else
    endif
endfunction

function Trig_Chooser_Func015Func001C takes nothing returns boolean
    if ( not ( GetLocationX(udg_InitialSpawnPoint[GetConvertedPlayerId(GetEnumPlayer())]) == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func015Func002Func003C takes nothing returns boolean
    if ( ( udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] == 1 ) ) then
        return true
    endif
    if ( ( udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] == 2 ) ) then
        return true
    endif
    return false
endfunction

function Trig_Chooser_Func015Func002C takes nothing returns boolean
    if ( not Trig_Chooser_Func015Func002Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func015Func006C takes nothing returns boolean
    if ( not ( udg_Parasite == GetEnumPlayer() ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func015Func007C takes nothing returns boolean
    if ( not ( udg_Mutant == GetEnumPlayer() ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func015Func008C takes nothing returns boolean
    if ( not ( udg_HiddenAndroid == GetEnumPlayer() ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func015A takes nothing returns nothing
    if ( Trig_Chooser_Func015Func001C() ) then
        set udg_TempUnit = GroupPickRandomUnit(udg_ChooseRoles_SpawnGroup)
        set udg_TempPoint = GetUnitLoc(udg_TempUnit)
        call GroupRemoveUnitSimple( udg_TempUnit, udg_ChooseRoles_SpawnGroup )
        call RemoveUnit( udg_TempUnit )
        set udg_InitialSpawnPoint[GetConvertedPlayerId(GetEnumPlayer())] = udg_TempPoint
    endif
    if ( Trig_Chooser_Func015Func002C() ) then
        call UnitAddAbilityBJ( udg_Dr_RoleAbility[udg_Researcher_PhD[GetConvertedPlayerId(GetEnumPlayer())]], udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())] )
    else
        call UnitAddAbilityBJ( udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())]], udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())] )
    endif
    call SetUnitPositionLoc( udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())], udg_InitialSpawnPoint[GetConvertedPlayerId(GetEnumPlayer())] )
    call PanCameraToTimedLocForPlayer( GetEnumPlayer(), udg_InitialSpawnPoint[GetConvertedPlayerId(GetEnumPlayer())], 0 )
    call SelectUnitForPlayerSingle( udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())], GetEnumPlayer() )
    if ( Trig_Chooser_Func015Func006C() ) then
        call UnitAddAbilityBJ( 'A02O', udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())] )
    endif
    if ( Trig_Chooser_Func015Func007C() ) then
        call UnitAddAbilityBJ( 'A05M', udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())] )
        call CreateNUnitsAtLoc( 1, 'e031', GetEnumPlayer(), udg_HoldZone, bj_UNIT_FACING )
    endif
    if ( Trig_Chooser_Func015Func008C() ) then
        call UnitAddAbilityBJ( 'A05Z', udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())] )
    endif
endfunction

function Trig_Chooser_Func026Func001C takes nothing returns boolean
    if ( not ( udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] == 11 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Func026A takes nothing returns nothing
    if ( Trig_Chooser_Func026Func001C() ) then
        set udg_TempBool = false
    endif
endfunction

function Trig_Chooser_Func027C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chooser_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call ForceClear( udg_ChooseGroup )
    set udg_TempInt = 0
    call ForForce( GetPlayersAll(), function Trig_Chooser_Func004A )
    call StateGrid_Initialize(udg_TempInt)
    if ( Trig_Chooser_Func005C() ) then
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_520" )
        return
    else
        if ( Trig_Chooser_Func005Func001C() ) then
            set udg_Allow_Android = false
            if ( Trig_Chooser_Func005Func001Func003C() ) then
                set udg_Allow_Mutant = false
            else
                set udg_Allow_Parasite = false
            endif
        else
            if ( Trig_Chooser_Func005Func001Func001C() ) then
                set udg_Allow_Android = false
            else
                set udg_ExtraStation = GetRandomInt(1, 3)
            endif
        endif
    endif
    if ( Trig_Chooser_Func006C() ) then
        if ( Trig_Chooser_Func006Func001C() ) then
            call StateGrid_SetPlayerRole(ForcePickRandomPlayer(udg_ChooseGroup), StateGrid_ROLE_ANDROID)
            call ForceRemovePlayerSimple( udg_HiddenAndroid, udg_ChooseGroup )
        else
            set udg_Allow_Android = false
        endif
    endif
    if ( Trig_Chooser_Func007C() ) then
        call StateGrid_SetPlayerRole(ForcePickRandomPlayer(udg_ChooseGroup), StateGrid_ROLE_ALIEN)
        call SetPlayerAllianceStateBJ( Player(bj_PLAYER_NEUTRAL_EXTRA), udg_Parasite, bj_ALLIANCE_ALLIED_ADVUNITS )
        call ForceRemovePlayerSimple( udg_Parasite, udg_ChooseGroup )
    endif
    if ( Trig_Chooser_Func008C() ) then
        call StateGrid_SetPlayerRole(ForcePickRandomPlayer(udg_ChooseGroup), StateGrid_ROLE_MUTANT)
        call ForceRemovePlayerSimple( udg_Mutant, udg_ChooseGroup )
    endif
    call ForForce( GetPlayersAll(), function Trig_Chooser_Func009A )
    call TriggerExecute( gg_trg_ChooseRoles )
    call ForceClear( udg_ChooseGroup )
    call ForForce( GetPlayersAll(), function Trig_Chooser_Func012A )
    call GroupClear( udg_ChooseRoles_SpawnGroup )
    set udg_ChooseRoles_SpawnGroup = GetUnitsOfTypeIdAll('e003')
    call ForForce( udg_ChooseGroup, function Trig_Chooser_Func015A )
    call DestroyTrigger(gg_trg_Researcher)
    call DestroyTrigger(gg_trg_CEO)
    call DestroyTrigger(gg_trg_Captain)
    call DestroyTrigger(gg_trg_Commissar)
    call DestroyTrigger(gg_trg_Janitor)
    call DestroyTrigger(gg_trg_WarVeteran)
    call DestroyTrigger(gg_trg_Engineer)
    call DestroyTrigger(gg_trg_SecurityGuard)
    call DestroyTrigger(gg_trg_Pilot)
    set udg_TempBool = true
    call ForForce( GetPlayersAll(), function Trig_Chooser_Func026A )
    if ( Trig_Chooser_Func027C() ) then
        set udg_ace_Existence = true
        call ShowUnitHide( gg_unit_h02Q_0212 )
    else
    endif
    call GroupClear( udg_ChooseRoles_SpawnGroup )
    call ConditionalTriggerExecute( gg_trg_RepickAlien )
    call ConditionalTriggerExecute( gg_trg_RepickMutant )
endfunction

//===========================================================================
function InitTrig_Chooser takes nothing returns nothing
    set gg_trg_Chooser = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_Chooser, 0.00 )
    call TriggerAddAction( gg_trg_Chooser, function Trig_Chooser_Actions )
endfunction

