function Trig_BackFromHell_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A032')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHell_Func007C takes nothing returns boolean 
    if(not(udg_EldritchBeastExists == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHell_Func009Func001C takes nothing returns boolean 
    if(not(IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == true)) then 
        return false 
    endif 
    if(not(udg_Mutant != GetEnumPlayer())) then 
        return false 
    endif 
    if(not(udg_HiddenAndroid != GetEnumPlayer())) then 
        return false 
    endif 
    if(not(udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetEnumPlayer())] == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHell_Func009A takes nothing returns nothing 
    if(Trig_BackFromHell_Func009Func001C()) then 
        set udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetEnumPlayer())] = false 
        call DialogAddButtonBJ(udg_BackFromHellDialog, udg_Player_NameBeforeDead[GetConvertedPlayerId(GetEnumPlayer())]) 
        set udg_BackFromHellDialogButtons[udg_TempInt] = GetLastCreatedButtonBJ() 
        set udg_BackFromHellDialog_Player[udg_TempInt] = GetEnumPlayer() 
        set udg_TempInt = (udg_TempInt + 1) 
    else 
    endif 
endfunction 

function Trig_BackFromHell_Func010C takes nothing returns boolean 
    if(not(udg_TempInt == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHell_Actions takes nothing returns nothing 
    call DialogClearBJ(udg_BackFromHellDialog) 
    call DialogAddButtonBJ(udg_BackFromHellDialog, "TRIGSTR_1827") 
    set udg_BackFromHellDialogButtons[0] = GetLastCreatedButtonBJ() 
    // Start - If Eldritch Beast already exists -> Dont spawn the button 
    if(Trig_BackFromHell_Func007C()) then 
        // Eldritch Beast Exists 
        set udg_TempInt = 1 
    else 
        // Eldritch Beast Does NOT Exist 
        set udg_TempInt = 2 
        call DialogAddButtonBJ(udg_BackFromHellDialog, "TRIGSTR_1828") 
        set udg_BackFromHellDialogButtons[1] = GetLastCreatedButtonBJ() 
    endif 
    // End - If Eldritch Beast already exists -> Dont spawn the button 
    call ForForce(udg_DeadGroup, function Trig_BackFromHell_Func009A) 
    if(Trig_BackFromHell_Func010C()) then 
        // Cannot spawn eldritch or a player! 
        call IssueImmediateOrderBJ(GetTriggerUnit(), "stop") 
        call SetUnitManaBJ(GetTriggerUnit(), 100.00) 
    else 
        call DialogDisplayBJ(true, udg_BackFromHellDialog, udg_Parasite) 
        set udg_TempUnitType = 'e00J' 
        set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit()) 
        set udg_TempReal = 120.00 
        call ExecuteFunc("AlienRequirementRemove") 
        call ExecuteFunc("AlienRequirementRestore") 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_BackFromHell takes nothing returns nothing 
    set gg_trg_BackFromHell = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_BackFromHell, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_BackFromHell, Condition(function Trig_BackFromHell_Conditions)) 
    call TriggerAddAction(gg_trg_BackFromHell, function Trig_BackFromHell_Actions) 
endfunction 

