function Trig_AlienForm_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A02O' ) ) then
        return false
    endif
    if ( not ( udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienForm_Actions takes nothing returns nothing
    local unit c
    // Hide the personnel!
    call ShowUnitHide( GetSpellAbilityUnit() )
    // Set temp point to the position of the caster.
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    // Dummy explosion 9 is an egg. Create it, make sure it plays its death animation, and execute Remove2 which will remove it in 2 seconds.
    call CreateNUnitsAtLoc( 1, 'e00H', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, GetUnitFacing(GetSpellAbilityUnit()) )
    call SetUnitAnimation( GetLastCreatedUnit(), "death" )
    set udg_TempUnit = GetLastCreatedUnit()
    call Remove2()
    // Create the alien current form at temppoint!
    call CreateNUnitsAtLoc( 1, udg_AlienCurrentForm, Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, GetUnitFacing(GetSpellAbilityUnit()) )
    // Adjust relative life and mana percentages.
    call SetUnitLifePercentBJ( GetLastCreatedUnit(), GetUnitLifePercent(GetSpellAbilityUnit()) )
    call SetUnitManaPercentBJ( GetLastCreatedUnit(), GetUnitManaPercent(GetSpellAbilityUnit()) )
    // Select it for the owner of the casting unit, who will always be the parasite.
    call SelectUnitForPlayerSingle( GetLastCreatedUnit(), GetOwningPlayer(GetSpellAbilityUnit()) )
    // Set AlienForm_Alien, playerhero for neutral extra, playerhero for parasite player to the alien.
    set udg_AlienForm_Alien = GetLastCreatedUnit()
    set udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
    set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
    // Transfer items and remove caster.
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call UnitAddItemSwapped( UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()), GetLastCreatedUnit() )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call SetUnitPositionLoc( GetSpellAbilityUnit(), udg_HoldZone )
    call RemoveUnit( GetSpellAbilityUnit() )
    // Create the ALIEN SHOP WORKAROUND!
    call CreateNUnitsAtLoc( 1, 'e00L', udg_Parasite, udg_HoldZone, bj_UNIT_FACING )
    set udg_Alien_ShopWorkaround = GetLastCreatedUnit()
    call EnableTrigger( gg_trg_AlienAdjustShop )
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_AlienForm takes nothing returns nothing
    set gg_trg_AlienForm = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_AlienForm, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_AlienForm, Condition( function Trig_AlienForm_Conditions ) )
    call TriggerAddAction( gg_trg_AlienForm, function Trig_AlienForm_Actions )
endfunction

