function Trig_MutantUpgrade_Conditions takes nothing returns boolean
    if ( not ( GetTriggerPlayer() == udg_Mutant ) ) then
        return false
    endif
    if ( not ( udg_MutantIsUpgrading == false ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantUpgrade_Func017Func006Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == 'h01B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantUpgrade_Func017Func006Func001Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == 'h01I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantUpgrade_Func017Func006Func001Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == 'h01O' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantUpgrade_Func017Func006Func001Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == 'h01E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantUpgrade_Func017Func006Func001C takes nothing returns boolean
    if ( not ( udg_MutantUpgradeLevel == 2 ) ) then
        return false
    endif
    if ( not ( udg_UpgradePointsMutant >= 1800.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantUpgrade_Func017Func006Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == 'h00V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantUpgrade_Func017Func006C takes nothing returns boolean
    if ( not ( udg_MutantUpgradeLevel == 1 ) ) then
        return false
    endif
    if ( not ( udg_UpgradePointsMutant >= 900.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantUpgrade_Func017C takes nothing returns boolean
    if ( not ( udg_MutantUpgradeLevel == 0 ) ) then
        return false
    endif
    if ( not ( udg_UpgradePointsMutant >= 300.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantUpgrade_Actions takes nothing returns nothing
    call RemoveUnit( udg_Mutant_EvoSelector )
    if ( Trig_MutantUpgrade_Func017C() ) then
        set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
        call CreateNUnitsAtLoc( 1, 'e02A', udg_Mutant, udg_TempPoint, bj_UNIT_FACING )
        set udg_Mutant_EvoSelector = GetLastCreatedUnit()
        call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Mutant )
        call RemoveLocation(udg_TempPoint)
    else
        if ( Trig_MutantUpgrade_Func017Func006C() ) then
            if ( Trig_MutantUpgrade_Func017Func006Func002C() ) then
                set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                call CreateNUnitsAtLoc( 1, 'e02C', udg_Mutant, udg_TempPoint, bj_UNIT_FACING )
                set udg_Mutant_EvoSelector = GetLastCreatedUnit()
                call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Mutant )
                call RemoveLocation(udg_TempPoint)
            else
                set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                call CreateNUnitsAtLoc( 1, 'e02B', udg_Mutant, udg_TempPoint, bj_UNIT_FACING )
                set udg_Mutant_EvoSelector = GetLastCreatedUnit()
                call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Mutant )
                call RemoveLocation(udg_TempPoint)
            endif
        else
            if ( Trig_MutantUpgrade_Func017Func006Func001C() ) then
                if ( Trig_MutantUpgrade_Func017Func006Func001Func001C() ) then
                    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                    call CreateNUnitsAtLoc( 1, 'e02F', udg_Mutant, udg_TempPoint, bj_UNIT_FACING )
                    set udg_Mutant_EvoSelector = GetLastCreatedUnit()
                    call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Mutant )
                    call RemoveLocation(udg_TempPoint)
                else
                endif
                if ( Trig_MutantUpgrade_Func017Func006Func001Func002C() ) then
                    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                    call CreateNUnitsAtLoc( 1, 'e02D', udg_Mutant, udg_TempPoint, bj_UNIT_FACING )
                    set udg_Mutant_EvoSelector = GetLastCreatedUnit()
                    call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Mutant )
                    call RemoveLocation(udg_TempPoint)
                else
                endif
                if ( Trig_MutantUpgrade_Func017Func006Func001Func003C() ) then
                    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                    call CreateNUnitsAtLoc( 1, 'e02E', udg_Mutant, udg_TempPoint, bj_UNIT_FACING )
                    set udg_Mutant_EvoSelector = GetLastCreatedUnit()
                    call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Mutant )
                    call RemoveLocation(udg_TempPoint)
                else
                endif
                if ( Trig_MutantUpgrade_Func017Func006Func001Func004C() ) then
                    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                    call CreateNUnitsAtLoc( 1, 'e02G', udg_Mutant, udg_TempPoint, bj_UNIT_FACING )
                    set udg_Mutant_EvoSelector = GetLastCreatedUnit()
                    call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Mutant )
                    call RemoveLocation(udg_TempPoint)
                else
                endif
            else
            endif
        endif
    endif
    // Trigger - Turn on Infinite Mutant bugfix <gen>
endfunction

//===========================================================================
function InitTrig_MutantUpgrade takes nothing returns nothing
    set gg_trg_MutantUpgrade = CreateTrigger(  )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(0) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(1) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(2) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(3) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(4) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(5) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(6) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(7) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(8) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(9) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(10) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_MutantUpgrade, Player(11) )
    call TriggerAddCondition( gg_trg_MutantUpgrade, Condition( function Trig_MutantUpgrade_Conditions ) )
    call TriggerAddAction( gg_trg_MutantUpgrade, function Trig_MutantUpgrade_Actions )
endfunction

