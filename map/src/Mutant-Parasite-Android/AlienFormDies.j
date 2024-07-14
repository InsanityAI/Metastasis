function Trig_AlienFormDies_Conditions takes nothing returns boolean
    if ( not ( GetDyingUnit() == udg_AlienForm_Alien ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienFormDies_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc( 1, 'e000', udg_Parasite, udg_HoldZone, bj_UNIT_FACING )
    set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
    set udg_SpawnTemp = false
    call KillUnit( GetLastCreatedUnit() )
    call UnitAddAbilityBJ( 'A02T', GetLastCreatedUnit() )
    call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, GetLastCreatedUnit() )
    call DisableTrigger( gg_trg_AlienAdjustShop )
endfunction

//===========================================================================
function InitTrig_AlienFormDies takes nothing returns nothing
    set gg_trg_AlienFormDies = CreateTrigger(  )
    call TriggerRegisterPlayerUnitEventSimple( gg_trg_AlienFormDies, Player(bj_PLAYER_NEUTRAL_EXTRA), EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( gg_trg_AlienFormDies, Condition( function Trig_AlienFormDies_Conditions ) )
    call TriggerAddAction( gg_trg_AlienFormDies, function Trig_AlienFormDies_Actions )
endfunction

