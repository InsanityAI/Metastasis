globals 
    trigger repickAlienDialogTrigger 

    dialog repickAlienDialog 
    button repickAlienDialogButtonYes 
    button repickAlienDialogButtonNo 

    boolean alienPicked = false 
    force eligibleHumans4Alien = null
    player tempPlayer4Alien
endglobals 

//Will not random pick current dialogued mutant because of wc3 bug (any upcoming dialog is displayed despite a dialog already on screen, no queuing happening...)
function Trig_RepickAlien_GetRandomHuman takes nothing returns player
    local player currentMutant = StateGrid_GetMutant()
    if udg_Allow_Mutant then //if mutant in game
        call ForceRemovePlayer(eligibleHumans4Alien, currentMutant)
    endif
    set tempPlayer4Alien = ForcePickRandomPlayer(eligibleHumans4Alien)
    call ForceRemovePlayer(eligibleHumans4Alien, tempPlayer4Alien)
    if udg_Allow_Mutant and not mutantPicked then //if mutant in game and hasn't confirmed his role
        call ForceAddPlayer(eligibleHumans4Alien, currentMutant)
    endif

    set currentMutant = null
    return tempPlayer4Alien
endfunction

function Trig_RepickAlien_FinalizeChoice takes nothing returns nothing
    set alienPicked = true 
    call DestroyForce(eligibleHumans4Alien)
    set eligibleHumans4Alien = null
endfunction

function Trig_RepickAlien_DialogClickActions takes nothing returns nothing 
    local button clickedButton = GetClickedButton() 
    local player oldAlien = StateGrid_GetAlien() 
    local player newAlien 
    if clickedButton == repickAlienDialogButtonYes then 
        call Trig_RepickAlien_FinalizeChoice()
    elseif clickedButton = repickAlienDialogButtonNo then 
        call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), oldAlien, bj_ALLIANCE_NEUTRAL) 
        call UnitRemoveAbility(udg_Playerhero[GetConvertedPlayerId(oldAlien)], 'A02O') 
        // Make the new alien   
        // Pick a player who is human ((does this include android?!))   
        call StateGrid_SetPlayerRole(oldAlien, StateGrid_ROLE_HUMAN) 
        set newAlien = GetRandomHuman() 
        if newAlien == null then
            set newAlien = StateGridUtil_PickRandomLivingHuman()
            call DisplayTextToPlayer(newAlien, 0, 0, "|cFFFF0000Unfortunately, this role has been forced into your hands.")
            call Trig_RepickAlien_FinalizeChoice()
        endif
        call StateGrid_SetPlayerRole(newAlien, StateGrid_ROLE_ALIEN) 
        call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), newAlien, bj_ALLIANCE_ALLIED_ADVUNITS) 
        if GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(newAlien)]) == 'h00H' then //if unsuited  
            call UnitAddAbility(udg_Playerhero[GetConvertedPlayerId(newAlien)], 'A02O') 
        endif 
        call DisplayTextToPlayer(newAlien, 0, 0, "|cffFF0000You are now the alien. Seek out all enemies and destroy them.") 
    endif 

    if not alienPicked then
        call ConditionalTriggerExecute(gg_trg_RepickAlien) 
    endif
endfunction 

function Trig_RepickAlien_Conditions takes nothing returns boolean 
    return udg_Allow_Parasite and not udg_TESTING 
endfunction 

function Trig_RepickAlien_Timeout takes nothing returns nothing 
    local Table t = Timeout.complete() 
    if alienPicked then 
        return 
    endif 
    call DialogDisplay(t.player.read("player"), repickAlienDialog, false) 
    call TriggerExecute(gg_trg_RepickAlienChoice) 
endfunction 

function Trig_RepickAlien_Actions takes nothing returns nothing 
    local Table t 
    local player currentAlien = StateGrid_GetAlien() 

    if eligibleHumans4Alien == null then
        set eligibleHumans4Alien = StateGridUtil_GetHumans()
        if udg_Allow_Mutant and not mutantPicked then //if mutant in game and hasn't confirmed his role
            call ForceAddPlayer(eligibleHumans4Alien, StateGrid_GetMutant())
        endif
    endif

    call DialogClear(repickAlienDialog) 
    call DialogSetMessage(repickAlienDialog, "TRIGSTR_5314") 
    set udg_RepickAlienDialogButton[0] = DialogAddButton(repickAlienDialog, "TRIGSTR_5312") 
    set udg_RepickAlienDialogButton[1] = DialogAddButton(repickAlienDialog, "TRIGSTR_5315") 
    call DialogDisplay(currentAlien, repickAlienDialog, true) 
    
    set t = Timeout.start(15, false, function Trig_RepickAlien_Timeout) 
    call t.player.write("player", currentAlien) 

    set currentAlien = null 
endfunction 

//===========================================================================    
function InitTrig_RepickAlien takes nothing returns nothing 
    set gg_trg_RepickAlien = CreateTrigger() 
    call TriggerAddCondition(gg_trg_RepickAlien, Condition(function Trig_RepickAlien_Conditions)) 
    call TriggerAddAction(gg_trg_RepickAlien, function Trig_RepickAlien_Actions) 

    set repickAlienDialogTrigger = CreateTrigger() 
    call TriggerRegisterDialogEvent(repickAlienDialogTrigger, repickAlienDialog) 
    call TriggerAddAction(repickAlienDialogTrigger, function Trig_RepickAlien_DialogClickActions) 
endfunction 