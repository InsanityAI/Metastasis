function Trig_UpgradeStatus_Func004Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetEnumPlayer())] == true ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func004A takes nothing returns nothing
    if ( Trig_UpgradeStatus_Func004Func001C() ) then
        set udg_UpgradePointsAlien = ( udg_UpgradePointsAlien + 0.28 )
    else
    endif
endfunction

function Trig_UpgradeStatus_Func005Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetEnumPlayer())] == true ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func005A takes nothing returns nothing
    if ( Trig_UpgradeStatus_Func005Func001C() ) then
        set udg_UpgradePointsMutant = ( udg_UpgradePointsMutant + 0.40 )
    else
    endif
endfunction

function Trig_UpgradeStatus_Func006A takes nothing returns nothing
    set udg_UpgradePointsAlien = ( udg_UpgradePointsAlien + 0.20 )
endfunction

function Trig_UpgradeStatus_Func007Func002C takes nothing returns boolean
    if ( not ( udg_UpgradePointsAlien <= 1370.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func007C takes nothing returns boolean
    if ( not ( udg_UpgradePointsAlien <= 660.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func008Func004Func001Func001C takes nothing returns boolean
    if ( not ( udg_UpgradePointsMutant <= 1800.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func008Func004Func001C takes nothing returns boolean
    if ( not ( udg_UpgradePointsMutant <= 900.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func008Func004C takes nothing returns boolean
    if ( not ( udg_UpgradePointsMutant <= 300.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func008C takes nothing returns boolean
    if ( not ( 'h04G' != udg_MutantUpgradingTo ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func012C takes nothing returns boolean
    if ( not ( GetPlayerState(udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER) >= 300 ) ) then
        return false
    endif
    if ( not ( udg_MutantUpgrades[1] == false ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(udg_Mutant, udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func013C takes nothing returns boolean
    if ( not ( udg_MutantUpgrades[1] == true ) ) then
        return false
    endif
    if ( not ( udg_MutantUpgrades[2] == false ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(udg_Mutant, udg_DeadGroup) == false ) ) then
        return false
    endif
    if ( not ( GetPlayerState(udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER) >= 900 ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func014C takes nothing returns boolean
    if ( not ( udg_MutantUpgrades[2] == true ) ) then
        return false
    endif
    if ( not ( udg_MutantUpgrades[3] == false ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(udg_Mutant, udg_DeadGroup) == false ) ) then
        return false
    endif
    if ( not ( GetPlayerState(udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER) >= 1800 ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func015C takes nothing returns boolean
    if ( not ( GetPlayerState(udg_Parasite, PLAYER_STATE_RESOURCE_LUMBER) >= 660 ) ) then
        return false
    endif
    if ( not ( udg_ParasiteUpgrades[1] == false ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(udg_Parasite, udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func016C takes nothing returns boolean
    if ( not ( GetPlayerState(udg_Parasite, PLAYER_STATE_RESOURCE_LUMBER) >= 1370 ) ) then
        return false
    endif
    if ( not ( udg_ParasiteUpgrades[2] == false ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(udg_Parasite, udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Func017C takes nothing returns boolean
    if ( not ( GetPlayerState(udg_HiddenAndroid, PLAYER_STATE_RESOURCE_LUMBER) >= 2000 ) ) then
        return false
    endif
    if ( not ( udg_AndroidUpgrades[1] == false ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(gg_unit_h003_0018) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_UpgradeStatus_Actions takes nothing returns nothing
    set udg_UpgradePointsAndroid = ( udg_UpgradePointsAndroid + 1.50 )
    set udg_UpgradePointsAlien = ( udg_UpgradePointsAlien + 0.40 )
    call ForForce( GetPlayersAll(), function Trig_UpgradeStatus_Func004A )
    call ForForce( GetPlayersAll(), function Trig_UpgradeStatus_Func005A )
    call ForGroupBJ( udg_Parasite_EggGroup, function Trig_UpgradeStatus_Func006A )
    if ( Trig_UpgradeStatus_Func007C() ) then
        call SetPlayerStateBJ( udg_Parasite, PLAYER_STATE_RESOURCE_FOOD_USED, R2I(( ( udg_UpgradePointsAlien - 0.00 ) / ( 660.00 / 100.00 ) )) )
    else
        if ( Trig_UpgradeStatus_Func007Func002C() ) then
            call SetPlayerStateBJ( udg_Parasite, PLAYER_STATE_RESOURCE_FOOD_USED, R2I(( ( udg_UpgradePointsAlien - 660.00 ) / ( 710.00 / 100.00 ) )) )
        else
        endif
    endif
    if ( Trig_UpgradeStatus_Func008C() ) then
        set udg_UpgradePointsMutant = ( udg_UpgradePointsMutant + 0.40 )
        if ( Trig_UpgradeStatus_Func008Func004C() ) then
            call SetPlayerStateBJ( udg_Mutant, PLAYER_STATE_RESOURCE_FOOD_USED, R2I(( ( udg_UpgradePointsMutant - 0.00 ) / ( 300.00 / 100.00 ) )) )
        else
            if ( Trig_UpgradeStatus_Func008Func004Func001C() ) then
                call SetPlayerStateBJ( udg_Mutant, PLAYER_STATE_RESOURCE_FOOD_USED, R2I(( ( udg_UpgradePointsMutant - 300.00 ) / ( 600.00 / 100.00 ) )) )
            else
                if ( Trig_UpgradeStatus_Func008Func004Func001Func001C() ) then
                    call SetPlayerStateBJ( udg_Mutant, PLAYER_STATE_RESOURCE_FOOD_USED, R2I(( ( udg_UpgradePointsMutant - 900.00 ) / ( 900.00 / 100.00 ) )) )
                else
                endif
            endif
        endif
        call SetPlayerStateBJ( udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER, R2I(udg_UpgradePointsMutant) )
    else
        call AdjustPlayerStateBJ( 1, udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER )
    endif
    call SetPlayerStateBJ( udg_Parasite, PLAYER_STATE_RESOURCE_LUMBER, R2I(udg_UpgradePointsAlien) )
    call SetPlayerStateBJ( udg_HiddenAndroid, PLAYER_STATE_RESOURCE_LUMBER, R2I(udg_UpgradePointsAndroid) )
    call SetPlayerStateBJ( udg_HiddenAndroid, PLAYER_STATE_RESOURCE_FOOD_USED, R2I(( ( udg_UpgradePointsAndroid - 0.00 ) / ( 2000.00 / 100.00 ) )) )
    if ( Trig_UpgradeStatus_Func012C() ) then
        set udg_MutantUpgrades[1] = true
        call DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 30, "|cffFF8040You feel new power coursing through you. It is time to evolve...Press ESC when you are ready.")
        call CinematicFilterGenericForPlayer(udg_Mutant, 6.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 100,0,0,25,0,0,0,100)
    else
    endif
    if ( Trig_UpgradeStatus_Func013C() ) then
        set udg_MutantUpgrades[2] = true
        call DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 30, "|cffFF8040You feel new power coursing through you. It is time to evolve...Press ESC when you are ready.")
        call CinematicFilterGenericForPlayer(udg_Mutant, 6.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 100,0,0,25,0,0,0,100)
    else
    endif
    if ( Trig_UpgradeStatus_Func014C() ) then
        set udg_MutantUpgrades[3] = true
        call DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 30, "|cffFF8040You feel new power coursing through you. It is time to evolve...Press ESC when you are ready.")
        call CinematicFilterGenericForPlayer(udg_Mutant, 6.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 100,0,0,25,0,0,0,100)
    else
    endif
    if ( Trig_UpgradeStatus_Func015C() ) then
        set udg_ParasiteUpgrades[1] = true
        call DisplayTimedTextToPlayer(udg_Parasite, 0, 0, 30, "|cffFF8040You feel new power coursing through you. It is time to transform...Press ESC when you are ready.")
        call CinematicFilterGenericForPlayer(udg_Parasite, 6.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0,100,100,25,0,0,0,100)
    else
    endif
    if ( Trig_UpgradeStatus_Func016C() ) then
        set udg_ParasiteUpgrades[2] = true
        call DisplayTimedTextToPlayer(udg_Parasite, 0, 0, 30, "|cffFF8040You feel new power coursing through you. It is time to transform...Press ESC when you are ready.")
        call CinematicFilterGenericForPlayer(udg_Parasite, 6.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0,100,100,25,0,0,0,100)
    else
    endif
    if ( Trig_UpgradeStatus_Func017C() ) then
        set udg_AndroidUpgrades[1] = true
        call EnableTrigger( gg_trg_AndroidUpgrade )
        call DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 25.00, "|cff00FFFFThe metallic fabricator is ready to build you a new chassis, if necessary. Proceed to the Arbitress.|r")
        call CinematicFilterGenericForPlayer(udg_HiddenAndroid, 6.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0,100,100,0,0,0,0,100)
    else
    endif
endfunction

//===========================================================================
function InitTrig_UpgradeStatus takes nothing returns nothing
    set gg_trg_UpgradeStatus = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_UpgradeStatus, 1.00 )
    call TriggerAddAction( gg_trg_UpgradeStatus, function Trig_UpgradeStatus_Actions )
endfunction

