function Trig_RepickAlienChoice_Conditions takes nothing returns boolean
    if ( not ( GetClickedButtonBJ() == udg_RepickAlienDialogButton[1] ) ) then
        return false
    endif
    return true
endfunction

function Trig_RepickAlienChoice_Func008C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == 'h00H' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RepickAlienChoice_Actions takes nothing returns nothing
    // Make the new alien
    // Pick a player who is human ((does this include android?!))
    call StateGrid_SetPlayerRole(udg_Parasite, StateGrid_ROLE_HUMAN)
    set udg_TempPlayer = NoninfectedForcePickOne()
    set udg_Parasite = udg_TempPlayer
    call StateGrid_SetPlayerRole(udg_Parasite, StateGrid_ROLE_ALIEN)
    call SetPlayerAllianceStateBJ( Player(bj_PLAYER_NEUTRAL_EXTRA), udg_Parasite, bj_ALLIANCE_ALLIED_ADVUNITS )
    if ( Trig_RepickAlienChoice_Func008C() ) then
        call UnitAddAbilityBJ( 'A02O', udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] )
    else
    endif
    call DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffFF0000You are now the alien. Seek out all enemies and destroy them.")
    // Remove the old alien's abilities etc etc
    call SetPlayerAllianceStateBJ( Player(bj_PLAYER_NEUTRAL_EXTRA), GetTriggerPlayer(), bj_ALLIANCE_NEUTRAL )
    call UnitRemoveAbilityBJ( 'A02O', udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())] )
    call ConditionalTriggerExecute( gg_trg_RepickAlien )
endfunction

//===========================================================================
function InitTrig_RepickAlienChoice takes nothing returns nothing
    set gg_trg_RepickAlienChoice = CreateTrigger(  )
    call TriggerRegisterDialogEventBJ( gg_trg_RepickAlienChoice, udg_RepickAlienDialog )
    call TriggerAddCondition( gg_trg_RepickAlienChoice, Condition( function Trig_RepickAlienChoice_Conditions ) )
    call TriggerAddAction( gg_trg_RepickAlienChoice, function Trig_RepickAlienChoice_Actions )
endfunction

