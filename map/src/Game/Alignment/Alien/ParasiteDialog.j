function Trig_ParasiteDialog_Conditions takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A078', GetTriggerUnit()) == 1 ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetTriggerUnit()) == udg_Parasite ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(gg_rct_Timeout, udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteDialog_Func006C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) != true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteDialog_Func021C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A046', udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) >= 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteDialog_Func027002001 takes nothing returns boolean
    return ( GetFilterPlayer() != udg_Parasite )
endfunction

function Trig_ParasiteDialog_Func040Func001C takes nothing returns boolean
    if ( not ( udg_IsNiffyLockdownActive == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteDialog_Func040C takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteDialog_Actions takes nothing returns nothing
    local unit a
    if ( Trig_ParasiteDialog_Func006C() ) then
        call RemoveUnit( GetTrainedUnit() )
        return
    else
    endif
    set udg_ParasiteIsUpgrading = true
    set udg_ParasiteUpgradeLevel = ( udg_ParasiteUpgradeLevel + 1 )
    set udg_ParasiteUpgradingTo = GetUnitTypeId(GetTrainedUnit())
    call RemoveUnit( udg_Parasite_EvoSelector )
    call RemoveUnit( GetTrainedUnit() )
    call UnitAddAbilityBJ( 'Avul', udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] )
    call PauseUnitBJ( true, udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] )
    call SetUnitOwner( udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], Player(PLAYER_NEUTRAL_PASSIVE), true )
    call UnitAddAbilityBJ( 'A07E', udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] )
    call PolledWait( 2 )
    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
    call CreateNUnitsAtLoc( 1, 'h02X', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, GetRandomDirectionDeg() )
    set a = GetLastCreatedUnit()
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call UnitAddItemSwapped( UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], GetForLoopIndexA()), GetLastCreatedUnit() )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    if ( Trig_ParasiteDialog_Func021C() ) then
        set udg_TempItem = udg_Player_Suit[GetConvertedPlayerId(udg_Parasite)]
        call SetItemUserData( udg_TempItem, 0 )
        call SetItemVisibleBJ( true, udg_TempItem )
        call SetItemPositionLoc( udg_TempItem, udg_TempPoint )
        call UnitAddItemSwapped( udg_TempItem, GetLastCreatedUnit() )
    else
    endif
    call SetUnitPositionLoc( udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], udg_HoldZone )
    call RemoveUnit( udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] )
    set udg_AlienForm_Alien = GetLastCreatedUnit()
    set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
    set udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
    set udg_TempPlayerGroup = GetPlayersMatching(Condition(function Trig_ParasiteDialog_Func027002001))
    set udg_CountupBar_HideTempBool = true
    set udg_CountUpBarColor = "|cff800080"
    call RemoveLocation(udg_TempPoint)
    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
    call CreateNUnitsAtLoc( 1, 'e00H', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    call SetUnitAnimation( GetLastCreatedUnit(), "death" )
    call CreateNUnitsAtLoc( 1, 'e00H', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    call SetUnitAnimation( GetLastCreatedUnit(), "death" )
    call CreateNUnitsAtLoc( 1, 'e00A', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    call CreateNUnitsAtLoc( 1, 'e00A', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    call RemoveLocation(udg_TempPoint)
    set udg_TempUnit=a
    if ( Trig_ParasiteDialog_Func040C() ) then
        call CountUpBar(udg_TempUnit, 2, 1, "ParasiteUpgrade")
    else
        if ( Trig_ParasiteDialog_Func040Func001C() ) then
            call CountUpBar(udg_TempUnit, 8, 1, "ParasiteUpgrade")
        else
            call CountUpBar(udg_TempUnit, 30, 1, "ParasiteUpgrade")
        endif
    endif
endfunction

//===========================================================================
function InitTrig_ParasiteDialog takes nothing returns nothing
    set gg_trg_ParasiteDialog = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ParasiteDialog, EVENT_PLAYER_UNIT_TRAIN_FINISH )
    call TriggerAddCondition( gg_trg_ParasiteDialog, Condition( function Trig_ParasiteDialog_Conditions ) )
    call TriggerAddAction( gg_trg_ParasiteDialog, function Trig_ParasiteDialog_Actions )
endfunction

