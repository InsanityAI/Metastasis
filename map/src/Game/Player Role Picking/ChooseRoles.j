globals
    boolean arbitressUsed = false
endglobals

function Trig_ChooseRoles_PopulateChooseGroup takes nothing returns nothing 
    local player p = GetEnumPlayer() 
    if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and not udg_Player_Left[GetConvertedPlayerId(p)] then 
        call ForceAddPlayer(udg_ChooseGroup, p) 
    endif 
    set p = null 
endfunction 

function Trig_ChooseRoles_AssignPlayerRoles takes nothing returns nothing 
    set udg_TempUnit = GroupPickRandomUnit(udg_ChooseRoles_DummyGroup) 
    call GroupRemoveUnit(udg_ChooseRoles_DummyGroup, udg_TempUnit) 
    set udg_TempInt = GetUnitUserData(udg_TempUnit) 
    set udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] = udg_TempInt 
endfunction 

function Trig_ChooseRoles_InitializePlayerRoles takes nothing returns nothing 
    set udg_TempPlayer = GetEnumPlayer() 
    call TriggerExecute(udg_PlayerRoleTrigger[udg_PlayerRole[GetConvertedPlayerId(udg_TempPlayer)]]) 
endfunction 

function Trig_ChooseRoles_DisplayObjectives takes nothing returns nothing 
    local player p = GetEnumPlayer() 
    if udg_Mutant == p then 
        call DisplayTimedTextToPlayer(p, 0, 0, 30, "-Kill everybody, or turn them into mindless drones. Use stealth and sabotage at first, but when you become more powerful confront your enemies directly.") 
    elseif udg_Parasite == p then 
        call DisplayTimedTextToPlayer(p, 0, 0, 30, "-Kill everybody, or turn them into spawns. Use stealth and infection to confront your enemies at first, and later confront them directly when you evolve.") 
    elseif udg_HiddenAndroid == p then 
        call DisplayTimedTextToPlayer(p, 0, 0, 30, "-Kill the mutant, the alien, and all of their allies. Please try to protect company property.|n-Protect local personnel.If too many are killed by you, you will be shut down.|n-You may upgrade yourself into a combat form if enough time passes.|n-If you die, you may be revived at the Arbitress.However you will be under the control of the person who revived you.") 
    else 
        call DisplayTimedTextToPlayer(p, 0, 0, 30, "-Kill the mutant, the alien, and all of their allies. Please try to protect company property.") 
    endif 
    set p = null 
endfunction 

function Trig_ChooseRoles_AddVisionOfArbitressRaptors takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS5 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS6 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
endfunction

function Trig_ChooseRoles_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call ForceClear(udg_ChooseGroup) 
    call ForForce(GetPlayersAll(), function Trig_ChooseRoles_PopulateChooseGroup) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = udg_NumberofRoles 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call CreateNUnitsAtLoc(1, 'e000', Player(PLAYER_NEUTRAL_PASSIVE), udg_HoldZone, bj_UNIT_FACING) 
        call GroupAddUnitSimple(GetLastCreatedUnit(), udg_ChooseRoles_DummyGroup) 
        call SetUnitUserData(GetLastCreatedUnit(), GetForLoopIndexA()) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call ForForce(udg_ChooseGroup, function Trig_ChooseRoles_AssignPlayerRoles) 
    call ForForce(udg_ChooseGroup, function Trig_ChooseRoles_InitializePlayerRoles) 
    call ForForce(udg_ChooseGroup, function Trig_ChooseRoles_DisplayObjectives) 
    if udg_TESTING or udg_EngineerUsed then 
        call TriggerExecute(gg_trg_ST8mInit) 
    else 
        call RemoveUnit(gg_unit_h04E_0259) 
        call DestroyTrigger(gg_trg_ST8Death) 
        call DestroyTrigger(gg_trg_ST8AttackEnd) 
        call DestroyTrigger(gg_trg_ST8Attack) 
    endif 
    call TriggerExecute(gg_trg_ST9Init) 
    if CountPlayersInForceBJ(GetPlayersAll()) >= 11 then 
        call TriggerExecute(gg_trg_ST10Init) 
    elseif udg_ExtraStation == 2 or udg_TESTING then 
        call TriggerExecute(gg_trg_ST10Init) 
    else 
        call TriggerExecute(gg_trg_ST10UnInit) 
    endif 

    if CountPlayersInForceBJ(GetPlayersAll()) <= 6 and not udg_TESTING then 
        // No android? No arbi, its bloat (more playspace to drag games)    
        call RemoveUnit(gg_unit_h003_0018)
        call DestroyTrigger(gg_trg_ST1Death) 
        call DestroyTrigger(gg_trg_ST1AttackEnd) 
        call DestroyTrigger(gg_trg_ST1Attack) 
    else
        call TriggerExecute(gg_trg_ST1mInit)
        set arbitressUsed = true
        call ForForce(GetPlayersAll(), function Trig_ChooseRoles_AddVisionOfArbitressRaptors)
    endif 
endfunction 

//===========================================================================    
function InitTrig_ChooseRoles takes nothing returns nothing 
    set gg_trg_ChooseRoles = CreateTrigger() 
    call TriggerAddAction(gg_trg_ChooseRoles, function Trig_ChooseRoles_Actions) 
endfunction 

