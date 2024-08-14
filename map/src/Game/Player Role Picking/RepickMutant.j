globals 
    trigger repickMutantDialogTrigger 

    dialog repickMutantDialog 
    button repickMutantDialogButtonYes 
    button repickMutantDialogButtonNo 

    boolean mutantPicked = false 
    force eligibleHumans4Mutant = null
    player tempPlayer4Mutant
endglobals 

//Will not random pick current dialogued mutant because of wc3 bug (any upcoming dialog is displayed despite a dialog already on screen, no queuing happening...)
function Trig_RepickMutant_GetRandomHuman takes nothing returns player
    local player currentAlien = StateGrid_GetAlien()
    if udg_Allow_Parasite then //if alien in game
        call ForceRemovePlayer(eligibleHumans4Mutant, currentAlien)
    endif
    set tempPlayer4Mutant = ForcePickRandomPlayer(eligibleHumans4Mutant)
    call ForceRemovePlayer(eligibleHumans4Mutant, tempPlayer4Mutant)
    if udg_Allow_Parasite and not alienPicked then //if alien in game and hasn't confirmed his role
        call ForceAddPlayer(eligibleHumans4Mutant, currentAlien)
    endif

    set currentAlien = null
    return tempPlayer4Mutant
endfunction

function Trig_RepickMutant_FinalizeChoice takes nothing returns nothing
    set mutantPicked = true 
    call DestroyForce(eligibleHumans4Mutant)
    set eligibleHumans4Mutant = null
endfunction

function Trig_RepickMutant_DialogClickActions takes nothing returns nothing 
    local button clickedButton = GetClickedButton() 
    local player oldMutant = StateGrid_GetMutant() 
    local player newMutant 
    if clickedButton == repickMutantDialogButtonYes then 
        call Trig_RepickMutant_FinalizeChoice()
    elseif clickedButton = repickMutantDialogButtonNo then 
        call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), oldMutant, bj_ALLIANCE_NEUTRAL) 
        call UnitRemoveAbility(udg_Playerhero[GetConvertedPlayerId(oldMutant)], 'A05M') 
        // Make the new mutant   
        // Pick a player who is human ((does this include android?!))   
        call StateGrid_SetPlayerRole(oldMutant, StateGrid_ROLE_HUMAN) 
        set newMutant = GetRandomHuman() 
        if newMutant == null then
            set newMutant = StateGridUtil_PickRandomLivingHuman()
            call DisplayTextToPlayer(newMutant, 0, 0, "|cFFFF0000Unfortunately, this role has been forced into your hands.")
            call Trig_RepickMutant_FinalizeChoice()
        endif
        call StateGrid_SetPlayerRole(newMutant, StateGrid_ROLE_MUTANT) 
        call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), newMutant, bj_ALLIANCE_ALLIED_ADVUNITS) 
        if GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(newMutant)]) == 'h00H' then //if unsuited  
            call UnitAddAbility(udg_Playerhero[GetConvertedPlayerId(newMutant)], 'A05M') 
        endif 
        call DisplayTextToPlayer(newMutant, 0, 0, "|cffFF0000You are now the mutant. Seek out all enemies and destroy them.") 
    endif 

    if not mutantPicked then
        call ConditionalTriggerExecute(gg_trg_RepickMutant) 
    endif
endfunction 

function Trig_RepickMutant_Conditions takes nothing returns boolean 
    return udg_Allow_Mutant and not udg_TESTING 
endfunction 

function Trig_RepickMutant_Timeout takes nothing returns nothing 
    local Table t = Timeout.complete() 
    if mutantPicked then 
        return 
    endif 
    call DialogDisplay(t.player.read("player"), repickMutantDialog, false) 
    call TriggerExecute(gg_trg_RepickMutantChoice) 
endfunction 

function Trig_RepickMutant_Actions takes nothing returns nothing 
    local Table t 
    local player currentMutant = StateGrid_GetMutant() 

    if eligibleHumans4Mutant == null then
        set eligibleHumans4Mutant = StateGridUtil_GetHumans()
        if udg_Allow_Parasite and not mutantPicked then //if mutant in game and hasn't confirmed his role
            call ForceAddPlayer(eligibleHumans4Mutant, StateGrid_GetMutant())
        endif
    endif

    call DialogClear(repickMutantDialog) 
    call DialogSetMessage(repickMutantDialog, "TRIGSTR_5314") 
    set udg_RepickMutantDialogButton[0] = DialogAddButton(repickMutantDialog, "TRIGSTR_5312") 
    set udg_RepickMutantDialogButton[1] = DialogAddButton(repickMutantDialog, "TRIGSTR_5315") 
    call DialogDisplay(currentMutant, repickMutantDialog, true) 
    
    set t = Timeout.start(15, false, function Trig_RepickMutant_Timeout) 
    call t.player.write("player", currentMutant) 

    set currentMutant = null 
endfunction 

//===========================================================================    
function InitTrig_RepickMutant takes nothing returns nothing 
    set gg_trg_RepickMutant = CreateTrigger() 
    call TriggerAddCondition(gg_trg_RepickMutant, Condition(function Trig_RepickMutant_Conditions)) 
    call TriggerAddAction(gg_trg_RepickMutant, function Trig_RepickMutant_Actions) 

    set repickMutantDialogTrigger = CreateTrigger() 
    call TriggerRegisterDialogEvent(repickMutantDialogTrigger, repickMutantDialog) 
    call TriggerAddAction(repickMutantDialogTrigger, function Trig_RepickMutant_DialogClickActions) 
endfunction 