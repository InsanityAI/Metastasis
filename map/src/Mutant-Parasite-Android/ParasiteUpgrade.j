function Trig_ParasiteUpgrade_Conditions takes nothing returns boolean
    if ( not ( GetTriggerPlayer() == udg_Parasite ) ) then
        return false
    endif
    if ( not ( udg_ParasiteIsUpgrading == false ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgrade_Func017Func006Func002C takes nothing returns boolean
    if ( not ( udg_AlienCurrentForm == 'h035' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgrade_Func017Func006Func003C takes nothing returns boolean
    if ( not ( udg_AlienCurrentForm == 'h02V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgrade_Func017Func006Func004C takes nothing returns boolean
    if ( not ( udg_AlienCurrentForm == 'h03E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgrade_Func017Func006C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradeLevel == 1 ) ) then
        return false
    endif
    if ( not ( udg_UpgradePointsAlien >= 1370.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgrade_Func017C takes nothing returns boolean
    if ( not ( udg_ParasiteUpgradeLevel == 0 ) ) then
        return false
    endif
    if ( not ( udg_UpgradePointsAlien >= 660.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ParasiteUpgrade_Actions takes nothing returns nothing
    call RemoveUnit( udg_Parasite_EvoSelector )
    if ( Trig_ParasiteUpgrade_Func017C() ) then
        set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
        call CreateNUnitsAtLoc( 1, 'e023', udg_Parasite, udg_TempPoint, bj_UNIT_FACING )
        set udg_Parasite_EvoSelector = GetLastCreatedUnit()
        call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Parasite )
        call RemoveLocation(udg_TempPoint)
    else
        if ( Trig_ParasiteUpgrade_Func017Func006C() ) then
            call DialogClearBJ( udg_ParasiteChooseDialog )
            if ( Trig_ParasiteUpgrade_Func017Func006Func002C() ) then
                set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                call CreateNUnitsAtLoc( 1, 'e029', udg_Parasite, udg_TempPoint, bj_UNIT_FACING )
                set udg_Parasite_EvoSelector = GetLastCreatedUnit()
                call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Parasite )
                call RemoveLocation(udg_TempPoint)
            else
            endif
            if ( Trig_ParasiteUpgrade_Func017Func006Func003C() ) then
                set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                call CreateNUnitsAtLoc( 1, 'e028', udg_Parasite, udg_TempPoint, bj_UNIT_FACING )
                set udg_Parasite_EvoSelector = GetLastCreatedUnit()
                call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Parasite )
                call RemoveLocation(udg_TempPoint)
            else
            endif
            if ( Trig_ParasiteUpgrade_Func017Func006Func004C() ) then
                set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                call CreateNUnitsAtLoc( 1, 'e027', udg_Parasite, udg_TempPoint, bj_UNIT_FACING )
                set udg_Parasite_EvoSelector = GetLastCreatedUnit()
                call SelectUnitForPlayerSingle( GetLastCreatedUnit(), udg_Parasite )
                call RemoveLocation(udg_TempPoint)
            else
            endif
        else
        endif
    endif
    // Trigger - Turn on Infinite Alien bugfix <gen>
endfunction

//===========================================================================
function InitTrig_ParasiteUpgrade takes nothing returns nothing
    set gg_trg_ParasiteUpgrade = CreateTrigger(  )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(0) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(1) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(2) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(3) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(4) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(5) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(6) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(7) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(8) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(9) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(10) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_ParasiteUpgrade, Player(11) )
    call TriggerAddCondition( gg_trg_ParasiteUpgrade, Condition( function Trig_ParasiteUpgrade_Conditions ) )
    call TriggerAddAction( gg_trg_ParasiteUpgrade, function Trig_ParasiteUpgrade_Actions )
endfunction

