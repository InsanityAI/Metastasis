function Trig_PlayerMurder_Func002Func001C takes nothing returns boolean
    if ( ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] != GetDyingUnit() ) ) then
        return true
    endif
    if ( ( GetOwningPlayer(GetDyingUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return true
    endif
    return false
endfunction

function Trig_PlayerMurder_Func002C takes nothing returns boolean
    if ( not Trig_PlayerMurder_Func002Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func005Func001Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == false ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetDyingUnit()) != udg_Parasite ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func005Func001Func005C takes nothing returns boolean
    if ( not ( udg_Parasite == GetOwningPlayer(GetDyingUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func005Func001Func019Func002C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetDyingUnit()) != udg_Parasite ) ) then
        return false
    endif
    if ( not ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func005Func001Func019C takes nothing returns boolean
    if ( ( udg_Mutant_IsRapidGestation == true ) ) then
        return true
    endif
    if ( Trig_PlayerMurder_Func005Func001Func019Func002C() ) then
        return true
    endif
    return false
endfunction

function Trig_PlayerMurder_Func005Func001C takes nothing returns boolean
    if ( not ( udg_Unit_InfectionType[GetUnitUserData(GetDyingUnit())] == 1 ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetDyingUnit()) != udg_HiddenAndroid ) ) then
        return false
    endif
    if ( not Trig_PlayerMurder_Func005Func001Func019C() ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func005C takes nothing returns boolean
    if ( not ( udg_Unit_IsInfected[GetUnitUserData(GetDyingUnit())] == true ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetDyingUnit()) != udg_HiddenAndroid ) ) then
        return false
    endif
    if ( not ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == false ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetDyingUnit()) != udg_Mutant ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func006Func002Func002Func001Func001Func005Func003C takes nothing returns boolean
    if ( ( GetOwningPlayer(GetKillingUnitBJ()) == udg_Parasite ) ) then
        return true
    endif
    if ( ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))] == true ) ) then
        return true
    endif
    if ( ( GetOwningPlayer(GetKillingUnitBJ()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return true
    endif
    return false
endfunction

function Trig_PlayerMurder_Func006Func002Func002Func001Func001Func005C takes nothing returns boolean
    if ( not Trig_PlayerMurder_Func006Func002Func002Func001Func001Func005Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func006Func002Func002Func001Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func006Func002Func002Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func006Func002Func002C takes nothing returns boolean
    if ( not ( udg_HiddenAndroid == GetOwningPlayer(GetDyingUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func006Func002C takes nothing returns boolean
    if ( not ( udg_Parasite == GetOwningPlayer(GetDyingUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func006Func007C takes nothing returns boolean
    if ( not ( udg_Unit_IsInfected[GetUnitUserData(GetDyingUnit())] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func006C takes nothing returns boolean
    if ( not ( udg_Mutant == GetOwningPlayer(GetDyingUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Func010C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlayerMurder_Actions takes nothing returns nothing
    local player victimPlayer = GetOwningPlayer(GetDyingUnit())
    local integer index = 1
    local integer maxIndex = 12
    if ( Trig_PlayerMurder_Func002C() ) then
        return
    else
    endif
    set udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
    set udg_TempUnit = GetDyingUnit()
    if ( Trig_PlayerMurder_Func005C() ) then
        if ( Trig_PlayerMurder_Func005Func001C() ) then
            set udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
            set udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = true
            set udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = false
            if ( Trig_PlayerMurder_Func005Func001Func005C() ) then
                set udg_Parasite=null
            else
            endif
            set udg_TempPoint = GetUnitLoc(GetDyingUnit())
            call CreateNUnitsAtLoc( 1, udg_MutantChildInfectee, GetOwningPlayer(GetDyingUnit()), udg_TempPoint, bj_UNIT_FACING )
            call SetUnitLifePercentBJ( GetLastCreatedUnit(), 33.00 )
            call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_TempPlayer )
            call PanCameraToTimedLocForPlayer( udg_TempPlayer, udg_TempPoint, 0 )
            call RemoveLocation(udg_TempPoint)
            set udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit()
            call DisplayTextToPlayer(GetOwningPlayer(GetDyingUnit()), 0, 0, "|cffFF0000You have been turned into the mutant's spawn! Work with the mutant to ensure victory.|r")
            call DisplayTextToPlayer(udg_Mutant, 0, 0, "|cffFF0000You have acquired a spawn!|r")
            call StateGrid_SetPlayerRole(victimPlayer, StateGrid_ROLE_MUTANT_SPAWN)
            call StateGrid_RevealPlayerRole(udg_Mutant, victimPlayer)
            call StateGrid_RevealPlayerRole(victimPlayer, udg_Mutant)
            loop
                exitwhen index >= maxIndex
                if udg_Player_IsMutantSpawn[index] then
                    call StateGrid_RevealPlayerRole(victimPlayer, ConvertedPlayer(index))
                    call StateGrid_RevealPlayerRole(ConvertedPlayer(index), victimPlayer)
                endif
                set index = index + 1
            endloop
            call TriggerExecute( gg_trg_WinCheck )
            return
        else
            if ( Trig_PlayerMurder_Func005Func001Func001C() ) then
                set udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = true
                set udg_TempPoint = GetUnitLoc(GetDyingUnit())
                set udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
                call CreateNUnitsAtLoc( 1, udg_ParasiteChildInfectee, GetOwningPlayer(GetDyingUnit()), udg_TempPoint, bj_UNIT_FACING )
                call SetUnitLifePercentBJ( GetLastCreatedUnit(), 33.00 )
                call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_TempPlayer )
                call PanCameraToTimedLocForPlayer( udg_TempPlayer, udg_TempPoint, 0 )
                call RemoveLocation(udg_TempPoint)
                set udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit()
                call DisplayTextToPlayer(GetOwningPlayer(GetDyingUnit()), 0, 0, "|cffFF0000You have been turned into the alien's spawn! Work with the alien to ensure victory.|r")
                call DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffFF0000You have acquired a spawn!|r")
                call DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffffcc00+175 evolution points for successful kill!")
                set udg_UpgradePointsAlien = ( udg_UpgradePointsAlien + 175.00 )
                set udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
                call StateGrid_SetPlayerRole(victimPlayer, StateGrid_ROLE_ALIEN_SPAWN)
                call StateGrid_RevealPlayerRole(udg_Mutant, victimPlayer)
                call StateGrid_RevealPlayerRole(victimPlayer, udg_Mutant)
                loop
                    exitwhen index >= maxIndex
                    if udg_Player_IsParasiteSpawn[index] then
                        call StateGrid_RevealPlayerRole(victimPlayer, ConvertedPlayer(index))
                        call StateGrid_RevealPlayerRole(ConvertedPlayer(index), victimPlayer)
                    endif
                    set index = index + 1
                endloop
                call TriggerExecute( gg_trg_ParasiteSpawnCreateSpell )
                call TriggerExecute( gg_trg_WinCheck )
                return
                // Commented out!
                //call FadeUnitOverTime(GetDyingUnit(),5.0,true)
            else
            endif
        endif
    else
    endif
    if ( Trig_PlayerMurder_Func006C() ) then
        call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_3989" )
        call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0.00, 100.00, 0, 50.00 )
        call PlaySoundBJ( gg_snd_AbominationAlternateDeath1 )
        // New Code here - If alien killed mutant
        if ( Trig_PlayerMurder_Func006Func007C() ) then
            set udg_UpgradePointsAlien = ( udg_UpgradePointsAlien + 3000.00 )
        else
        endif
        // New Code above - If alien killed mutant
        call StateGrid_RevealPlayerRole(victimPlayer, null)
        call StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
    else
        if ( Trig_PlayerMurder_Func006Func002C() ) then
            call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_3988" )
            call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0.00, 0.00, 100.00, 50.00 )
            call PlaySoundBJ( gg_snd_WarlockDeath1 )
            call StateGrid_RevealPlayerRole(victimPlayer, null)
            call StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
        else
            if ( Trig_PlayerMurder_Func006Func002Func002C() ) then
                call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
                call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_3987" )
                call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 100.00, 100.00, 50.00 )
                call PlaySoundBJ( gg_snd_RockGolemDeath1 )
                call StateGrid_RevealPlayerRole(victimPlayer, null)
                call StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
            else
                if ( Trig_PlayerMurder_Func006Func002Func002Func001C() ) then
                    call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
                    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_3986" )
                    call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0.00, 0.00, 100.00, 50.00 )
                    call PlaySoundBJ( gg_snd_PitFiendDeath1 )
                    call StateGrid_RevealPlayerRole(victimPlayer, null)
                    call StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
                else
                    if ( Trig_PlayerMurder_Func006Func002Func002Func001Func001C() ) then
                        call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
                        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_3985" )
                        call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0.00, 100.00, 100.00, 50.00 )
                        call PlaySoundBJ( gg_snd_BansheeDeath )
                        call StateGrid_RevealPlayerRole(victimPlayer, null)
                        call StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
                    else
                        call DisplayTextToForce( GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " |cff800080has been killed!|r" ) )
                        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_3983" )
                        call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 4.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.00, 0.00, 0.00, 50.00 )
                        call PlaySoundBJ( gg_snd_PeasantDeath )
                        if ( Trig_PlayerMurder_Func006Func002Func002Func001Func001Func005C() ) then
                            call DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffffcc00+175 evolution points for successful kill!")
                            set udg_UpgradePointsAlien = ( udg_UpgradePointsAlien + 175.00 )
                        else
                        endif
                        call StateGrid_RevealPlayerRole(victimPlayer, null)
                        call StateGrid_SetPlayerState(victimPlayer, StateGrid_STATE_DEAD)
                    endif
                endif
            endif
        endif
    endif
    call AndroidKillCheck(GetOwningPlayer(GetDyingUnit()))
    set udg_TempPlayer = GetOwningPlayer(GetDyingUnit())
    set udg_TempUnit = GetDyingUnit()
    if ( Trig_PlayerMurder_Func010C() ) then
        set udg_TempPoint = GetUnitLoc(udg_TempUnit)
        call CreateItemLoc( 'I01H', udg_TempPoint )
        call RemoveLocation(udg_TempPoint)
        set udg_Android_MemoryCard = GetLastCreatedItem()
    else
    endif
    call MurderPart2()
endfunction

//===========================================================================
function InitTrig_PlayerMurder takes nothing returns nothing
    set gg_trg_PlayerMurder = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_PlayerMurder, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddAction( gg_trg_PlayerMurder, function Trig_PlayerMurder_Actions )
endfunction

