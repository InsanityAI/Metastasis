function Trig_RepickMutantChoice_Conditions takes nothing returns boolean
    if ( not ( GetClickedButtonBJ() == udg_RepickMutantDialogButton[1] ) ) then
        return false
    endif
    return true
endfunction

function Trig_RepickMutantChoice_Func008C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == 'h00H' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RepickMutantChoice_Func009C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A05M', udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RepickMutantChoice_Actions takes nothing returns nothing
    // Make the new mutant
    // Pick a player who is human ((does this include android?!))
    call StateGrid_SetPlayerRole(udg_Mutant, StateGrid_ROLE_HUMAN)
    set udg_TempPlayer = NoninfectedForcePickOne()
    set udg_Mutant = udg_TempPlayer
    call StateGrid_SetPlayerRole(udg_Mutant, StateGrid_ROLE_MUTANT)
    call CreateNUnitsAtLoc( 1, 'e031', udg_Mutant, udg_HoldZone, bj_UNIT_FACING )
    if ( Trig_RepickMutantChoice_Func008C() ) then
        call UnitAddAbilityBJ( 'A05M', udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] )
    else
    endif
    if ( Trig_RepickMutantChoice_Func009C() ) then
        call UnitRemoveAbilityBJ( 'A05M', udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())] )
    else
    endif
    call DisplayTextToPlayer(udg_Mutant, 0, 0, "|cffFF0000You are now the Mutant. Seek out all enemies and destroy them.")
    call ConditionalTriggerExecute( gg_trg_RepickMutant )
endfunction

//===========================================================================
function InitTrig_RepickMutantChoice takes nothing returns nothing
    set gg_trg_RepickMutantChoice = CreateTrigger(  )
    call TriggerRegisterDialogEventBJ( gg_trg_RepickMutantChoice, udg_RepickMutantDialog )
    call TriggerAddCondition( gg_trg_RepickMutantChoice, Condition( function Trig_RepickMutantChoice_Conditions ) )
    call TriggerAddAction( gg_trg_RepickMutantChoice, function Trig_RepickMutantChoice_Actions )
endfunction

