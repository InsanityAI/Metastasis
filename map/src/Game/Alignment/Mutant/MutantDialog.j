function Trig_MutantDialog_Conditions takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A078', GetTriggerUnit()) == 1 ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetTriggerUnit()) == udg_Mutant ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(gg_rct_Timeout, udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantDialog_Func005C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) != true ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantDialog_Func026C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A046', udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) >= 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantDialog_Func030002001 takes nothing returns boolean
    return ( GetFilterPlayer() != udg_Mutant )
endfunction

function Trig_MutantDialog_Func033Func001C takes nothing returns boolean
    if ( not ( udg_IsNiffyLockdownActive == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantDialog_Func033C takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantDialog_Actions takes nothing returns nothing
    if ( Trig_MutantDialog_Func005C() ) then
        call RemoveUnit( GetTrainedUnit() )
        return
    else
    endif
    set udg_MutantIsUpgrading = true
    set udg_MutantUpgradeLevel = ( udg_MutantUpgradeLevel + 1 )
    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
    set udg_MutantUpgradingTo = GetUnitTypeId(GetTrainedUnit())
    call UnitAddAbilityBJ( 'Avul', udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] )
    call PauseUnitBJ( true, udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] )
    call SetUnitOwner( udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], Player(PLAYER_NEUTRAL_PASSIVE), true )
    set udg_MutantUpgrade_Health = GetUnitLifePercent(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
    call RemoveUnit( udg_Mutant_EvoSelector )
    call RemoveUnit( GetTrainedUnit() )
    call CreateNUnitsAtLoc( 1, 'h00T', udg_Mutant, udg_TempPoint, bj_UNIT_FACING )
    call UnitAddAbilityBJ( 'A07E', udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] )
    set udg_Mutant_EvolvingMass = GetLastCreatedUnit()
    call SetUnitX(GetLastCreatedUnit(),GetLocationX(udg_TempPoint))
    call SetUnitY(GetLastCreatedUnit(),GetLocationY(udg_TempPoint))
    call SizeUnitOverTime(udg_Mutant_EvolvingMass,2.5,0.01,1,false)
    call RemoveLocation(udg_TempPoint)
    call PolledWait( 2.00 )
    call SetUnitPositionLoc( udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], udg_HoldZone )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call UnitAddItemSwapped( UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], GetForLoopIndexA()), udg_Mutant_EvolvingMass )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    if ( Trig_MutantDialog_Func026C() ) then
        set udg_TempItem = udg_Player_Suit[GetConvertedPlayerId(udg_Mutant)]
        call SetItemUserData( udg_TempItem, 0 )
        call SetItemVisibleBJ( true, udg_TempItem )
        call SetItemPositionLoc( udg_TempItem, udg_TempPoint )
        call UnitAddItemSwapped( udg_TempItem, GetLastCreatedUnit() )
    else
    endif
    call RemoveUnit( udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] )
    set udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] = udg_Mutant_EvolvingMass
    set udg_TempUnit = udg_Mutant_EvolvingMass
    set udg_TempPlayerGroup = GetPlayersMatching(Condition(function Trig_MutantDialog_Func030002001))
    set udg_CountupBar_HideTempBool = true
    set udg_CountUpBarColor = "|cffFF8000"
    if ( Trig_MutantDialog_Func033C() ) then
        call CountUpBar(udg_TempUnit, 2, 1, "MutantUpgrade")
    else
        if ( Trig_MutantDialog_Func033Func001C() ) then
            call CountUpBar(udg_TempUnit, 8, 1, "MutantUpgrade")
        else
            call CountUpBar(udg_TempUnit, 30, 1, "MutantUpgrade")
        endif
    endif
endfunction

//===========================================================================
function InitTrig_MutantDialog takes nothing returns nothing
    set gg_trg_MutantDialog = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_MutantDialog, EVENT_PLAYER_UNIT_TRAIN_FINISH )
    call TriggerAddCondition( gg_trg_MutantDialog, Condition( function Trig_MutantDialog_Conditions ) )
    call TriggerAddAction( gg_trg_MutantDialog, function Trig_MutantDialog_Actions )
endfunction

