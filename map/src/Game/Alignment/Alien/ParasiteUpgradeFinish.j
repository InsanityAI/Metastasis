function Trig_ParasiteUpgradeFinish_Func002C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func003C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h02V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func004C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h03P' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func005C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h02Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func006Func003Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func006C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h031' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func007Func004Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func007C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h037' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func008C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h03E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func009C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h03A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func010C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h035' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func011Func027Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == true ) ) then
        return false
    endif
    if ( not ( IsUnitType(udg_Playerhero[GetForLoopIndexA()], UNIT_TYPE_MECHANICAL) == true ) ) then
        return false
    endif
    if ( not ( udg_HiddenAndroid != ConvertedPlayer(GetForLoopIndexA()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func011C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h033' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func012C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h03C' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func013C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h03G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func014C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradingTo == 'h03V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func036C takes nothing returns boolean
    if ( not ( udg_Masq_evolved != true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Func037Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == true ) ) then
        return false
    endif
    if ( not ( IsUnitType(udg_Playerhero[GetForLoopIndexA()], UNIT_TYPE_MECHANICAL) == true ) ) then
        return false
    endif
    if ( not ( udg_HiddenAndroid != ConvertedPlayer(GetForLoopIndexA()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgradeFinish_Actions takes nothing returns nothing
    local unit a
    if ( Trig_ParasiteUpgradeFinish_Func002C() ) then
    else
        return
    endif
    if ( Trig_ParasiteUpgradeFinish_Func003C() ) then
        set udg_ParasiteChildInfectee = 'h02W'
        call CreateNUnitsAtLoc( 1, 'e00T', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING )
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func004C() ) then
        set udg_ParasiteChildInfectee = 'h03R'
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func005C() ) then
        call EnableTrigger( gg_trg_ClosedTimeLikeLoopSavePos )
        call CreateNUnitsAtLoc( 1, 'e00J', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING )
        set udg_ParasiteChildInfectee = 'h030'
        call ExecuteFunc("CreateCTLRequirement")
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func006C() ) then
        call CreateNUnitsAtLoc( 1, 'e00M', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING )
        set udg_ParasiteChildInfectee = 'h032'
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 12
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_ParasiteUpgradeFinish_Func006Func003Func001C() ) then
                call CreateNUnitsAtLoc( 1, 'e00M', ConvertedPlayer(GetForLoopIndexA()), udg_HoldZone, bj_UNIT_FACING )
            else
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func007C() ) then
        call CreateNUnitsAtLoc( 1, 'e00O', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING )
        call CreateNUnitsAtLoc( 1, 'e00P', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING )
        set udg_ParasiteChildInfectee = 'h039'
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 12
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_ParasiteUpgradeFinish_Func007Func004Func001C() ) then
                call CreateNUnitsAtLoc( 1, 'e00M', ConvertedPlayer(GetForLoopIndexA()), udg_HoldZone, bj_UNIT_FACING )
            else
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func008C() ) then
        call EnableTrigger( gg_trg_NeurotoxicPoison )
        set udg_ParasiteChildInfectee = 'h03F'
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func009C() ) then
        set udg_ParasiteChildInfectee = 'h03B'
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func010C() ) then
        set udg_ParasiteChildInfectee = 'h036'
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func011C() ) then
        set udg_Masq_evolved = true
        set udg_ParasiteChildInfectee = 'h034'
        call CreateNUnitsAtLoc( 1, 'e015', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING )
        // -----------------------------
        // -----------------------------
        set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        set a=udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]
        set udg_AlienCurrentForm = udg_ParasiteUpgradingTo
        set udg_AlienForm_Alien = null
        call CreateNUnitsAtLoc( 1, udg_ParasiteUpgradingTo, Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING )
        call SetUnitX(GetLastCreatedUnit(),GetLocationX(udg_TempPoint))
        call SetUnitY(GetLastCreatedUnit(),GetLocationY(udg_TempPoint))
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 6
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call UnitAddItemSwapped( UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], GetForLoopIndexA()), GetLastCreatedUnit() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = null
        set udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = null
        set udg_TempUnit=a
        call KillUnit( udg_TempUnit )
        call RemoveLocation(udg_TempPoint)
        set udg_ParasiteIsUpgrading = false
        set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
        set udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
        set udg_AlienForm_Alien = GetLastCreatedUnit()
        call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Parasite )
        call CreateNUnitsAtLoc( 1, 'e00L', udg_Parasite, udg_HoldZone, bj_UNIT_FACING )
        set udg_Alien_ShopWorkaround = GetLastCreatedUnit()
        call EnableTrigger( gg_trg_AlienAdjustShop )
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 12
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_ParasiteUpgradeFinish_Func011Func027Func001C() ) then
                set udg_TempUnitType = udg_ParasiteChildInfectee
                set udg_TempUnit = udg_Playerhero[GetForLoopIndexA()]
                set udg_TempPlayer = ConvertedPlayer(GetForLoopIndexA())
                call ExecuteFunc("PendUpgrade")
                call TriggerExecute( gg_trg_ParasiteSpawnCreateSpell )
            else
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        // Trigger - Turn off Infinite Alien bugfix <gen> BUT WHY TE FUCK ITS HERE!>?
        return
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func012C() ) then
        set udg_ParasiteChildInfectee = 'h03D'
        call CreateNUnitsAtLoc( 1, 'e00S', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING )
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func013C() ) then
        set udg_ParasiteChildInfectee = 'h03H'
        call CreateNUnitsAtLoc( 1, 'e00V', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING )
    else
    endif
    if ( Trig_ParasiteUpgradeFinish_Func014C() ) then
        set udg_ParasiteChildInfectee = 'h03W'
    else
    endif
    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
    set a=udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]
    set udg_AlienCurrentForm = udg_ParasiteUpgradingTo
    set udg_AlienForm_Alien = null
    call CreateNUnitsAtLoc( 1, udg_ParasiteUpgradingTo, Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING )
    call SetUnitX(GetLastCreatedUnit(),GetLocationX(udg_TempPoint))
    call SetUnitY(GetLastCreatedUnit(),GetLocationY(udg_TempPoint))
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call UnitAddItemSwapped( UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], GetForLoopIndexA()), GetLastCreatedUnit() )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = null
    set udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = null
    set udg_TempUnit=a
    call KillUnit( udg_TempUnit )
    call RemoveLocation(udg_TempPoint)
    set udg_ParasiteIsUpgrading = false
    set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
    set udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
    set udg_AlienForm_Alien = GetLastCreatedUnit()
    call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Parasite )
    call CreateNUnitsAtLoc( 1, 'e00L', udg_Parasite, udg_HoldZone, bj_UNIT_FACING )
    set udg_Alien_ShopWorkaround = GetLastCreatedUnit()
    call EnableTrigger( gg_trg_AlienAdjustShop )
    if ( Trig_ParasiteUpgradeFinish_Func036C() ) then
        call PlaySoundBJ( gg_snd_DragonYesAttack3 )
        call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 2, "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0.00, 100.00, 100.00, 0 )
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4587" )
    else
    endif
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 12
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_ParasiteUpgradeFinish_Func037Func001C() ) then
            set udg_TempUnitType = udg_ParasiteChildInfectee
            set udg_TempUnit = udg_Playerhero[GetForLoopIndexA()]
            set udg_TempPlayer = ConvertedPlayer(GetForLoopIndexA())
            call ExecuteFunc("PendUpgrade")
            call TriggerExecute( gg_trg_ParasiteSpawnCreateSpell )
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    // Trigger - Turn off Infinite Alien bugfix <gen>
endfunction

//===========================================================================
function InitTrig_ParasiteUpgradeFinish takes nothing returns nothing
    set gg_trg_ParasiteUpgradeFinish = CreateTrigger(  )
    call TriggerAddAction( gg_trg_ParasiteUpgradeFinish, function Trig_ParasiteUpgradeFinish_Actions )
endfunction

