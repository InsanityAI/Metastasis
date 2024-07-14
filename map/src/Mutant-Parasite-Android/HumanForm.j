function Trig_HumanForm_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A02S' ) ) then
        return false
    endif
    if ( not ( udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_HumanForm_Actions takes nothing returns nothing
    local unit c
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    call CreateNUnitsAtLoc( 1, 'e00H', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, GetUnitFacing(GetSpellAbilityUnit()) )
    call SetUnitAnimation( GetLastCreatedUnit(), "death" )
    set udg_TempUnit = GetLastCreatedUnit()
    call Remove2()
    call CreateNUnitsAtLoc( 1, 'h00H', udg_Parasite, udg_TempPoint, bj_UNIT_FACING )
    set udg_TempUnit = GetLastCreatedUnit()
    set c=udg_TempUnit
    call SetUnitLifePercentBJ( udg_TempUnit, GetUnitLifePercent(GetSpellAbilityUnit()) )
    call SetUnitManaPercentBJ( udg_TempUnit, GetUnitManaPercent(GetSpellAbilityUnit()) )
    call SetUnitPositionLoc( GetSpellAbilityUnit(), udg_HoldZone )
    set udg_TempUnit=c
    call ShowUnitShow( udg_TempUnit )
    set udg_TempUnit=c
    call PauseUnitBJ( false, udg_TempUnit )
    set udg_TempUnit=c
    call UnitRemoveAbilityBJ( 'Avul', udg_TempUnit )
    set udg_TempUnit=c
    call SetUnitPositionLoc( udg_TempUnit, udg_TempPoint )
    call UnitAddAbilityBJ( 'A02O', GetLastCreatedUnit() )
    // Will screw up the Dr.'s tooltip. Fix later!
    call UnitAddAbilityBJ( udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(udg_Parasite)]], GetLastCreatedUnit() )
    call SelectUnitForPlayerSingle( GetLastCreatedUnit(), GetOwningPlayer(GetSpellAbilityUnit()) )
    set udg_TempUnit=c
    call SelectUnitForPlayerSingle( udg_TempUnit, udg_Parasite )
    set udg_AlienForm_Alien = null
    set udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
    set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
    call DisableTrigger( gg_trg_AlienAdjustShop )
    call RemoveUnit( udg_Alien_ShopWorkaround )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TempUnit=c
        call UnitAddItemSwapped( UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()), udg_TempUnit )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call RemoveUnit( GetSpellAbilityUnit() )
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_HumanForm takes nothing returns nothing
    set gg_trg_HumanForm = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_HumanForm, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_HumanForm, Condition( function Trig_HumanForm_Conditions ) )
    call TriggerAddAction( gg_trg_HumanForm, function Trig_HumanForm_Actions )
endfunction

