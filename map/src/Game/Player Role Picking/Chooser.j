globals 
    integer chooseGroupSize 
endglobals 

function Trig_Chooser_PopulateChooseGroup takes nothing returns nothing 
    local player p = GetEnumPlayer() 
    if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then 
        call ForceAddPlayer(udg_ChooseGroup, p) 
        set chooseGroupSize = chooseGroupSize + 1 
    endif 
    set p = null 
endfunction 

function Trig_Chooser_DeclareMainRole takes nothing returns nothing 
    local player p = GetEnumPlayer() 
    if p == udg_Mutant then 
        call DisplayTimedTextToPlayer(p, 0, 0, 30, "|cffFF00FFYOU ARE THE MUTANT|r") 
        call SetPlayerStateBJ(p, PLAYER_STATE_RESOURCE_FOOD_CAP, 100) 
    elseif p == udg_Parasite then 
        call DisplayTimedTextToPlayer(p, 0, 0, 30, "|cffFF8000YOU ARE THE ALIEN|r") 
        call SetPlayerStateBJ(p, PLAYER_STATE_RESOURCE_FOOD_CAP, 100) 
    elseif p == udg_HiddenAndroid then 
        call DisplayTimedTextToPlayer(p, 0, 0, 30, "|cffFF8000YOU ARE THE ANDROID|r") 
        call SetPlayerStateBJ(p, PLAYER_STATE_RESOURCE_FOOD_CAP, 100) 
    else 
        call DisplayTimedTextToPlayer(p, 0, 0, 30, "|cff808000YOU ARE HUMAN|r") 
    endif 
    set p = null 
endfunction 

function Trig_Chooser_IfResearcherRole takes nothing returns boolean 
    local integer role = udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] 
    return role == 1 or role == 2 
endfunction 

function Trig_Chooser_RemoveInvalidStartPositions takes nothing returns nothing
    local unit = startLocDummy = GetEnumUnit()
    local location startLoc = GetUnitLoc(startLocDummy)
    local integer startingSector =  GetSector(startLoc) 

    if not arbitressUsed and startingSector == 1 then
        call GroupRemoveUnit(udg_ChooseRoles_SpawnGroup, startLocDummy)
        call RemoveUnit(startLocDummy)
    endif

    set startLocDummy = null
    call RemoveLocation(startLoc)
    set startLoc = null
endfunction

function Trig_Chooser_PositionPlayerHeroes takes nothing returns nothing 
    local player p = GetEnumPlayer()
    local integer playerGUIID = GetConvertedPlayerId(p)
    if GetLocationX(udg_InitialSpawnPoint[playerGUIID]) == 0.00 then //if not predefined position 
        set udg_TempUnit = GroupPickRandomUnit(udg_ChooseRoles_SpawnGroup) 
        set udg_TempPoint = GetUnitLoc(udg_TempUnit) 
        call GroupRemoveUnit(udg_ChooseRoles_SpawnGroup, udg_TempUnit) 
        call RemoveUnit(udg_TempUnit) 
        set udg_InitialSpawnPoint[playerGUIID] = udg_TempPoint 
    endif 
    if Trig_Chooser_IfResearcherRole() then 
        call UnitAddAbilityBJ(udg_Dr_RoleAbility[udg_Researcher_PhD[playerGUIID]], udg_Playerhero[playerGUIID]) 
    else 
        call UnitAddAbilityBJ(udg_RoleAbility[udg_PlayerRole[playerGUIID]], udg_Playerhero[playerGUIID]) 
    endif 
    call SetUnitPositionLoc(udg_Playerhero[playerGUIID], udg_InitialSpawnPoint[playerGUIID]) 
    call PanCameraToTimedLocForPlayer(p, udg_InitialSpawnPoint[playerGUIID], 0) 
    call SelectUnitForPlayerSingle(udg_Playerhero[playerGUIID], p) 
    if udg_Parasite == p then 
        call UnitAddAbilityBJ('A02O', udg_Playerhero[playerGUIID]) 
    endif 
    if udg_Mutant == p then 
        call UnitAddAbilityBJ('A05M', udg_Playerhero[playerGUIID]) 
        call CreateNUnitsAtLoc(1, 'e031', p, udg_HoldZone, bj_UNIT_FACING) 
    endif 
    if udg_HiddenAndroid == p then 
        call UnitAddAbilityBJ('A05Z', udg_Playerhero[playerGUIID]) 
    endif 
    set p = null
endfunction 

function Trig_Chooser_CheckIfAceExists takes nothing returns nothing 
    if(udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] == 11) then 
        set udg_TempBool = false 
    endif 
endfunction 

function Trig_Chooser_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call ForceClear(udg_ChooseGroup) 
    set chooseGroupSize = 0 
    call ForForce(GetPlayersAll(), function Trig_Chooser_PopulateChooseGroup) 
    call StateGrid_Initialize(chooseGroupSize) 
    if chooseGroupSize <= 0 then 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_520") 
        return 
    elseif chooseGroupSize <= 4 then 
        set udg_Allow_Android = false 
        if GetRandomInt(1, 2) == 1 then 
            set udg_Allow_Mutant = false 
        else 
            set udg_Allow_Parasite = false 
        endif 
    elseif chooseGroupSize < 7 then 
        set udg_Allow_Android = false 
    else 
        set udg_ExtraStation = GetRandomInt(1, 3) 
    endif 
    if udg_Allow_Android then 
        call StateGrid_SetPlayerRole(ForcePickRandomPlayer(udg_ChooseGroup), StateGrid_ROLE_ANDROID) 
        call ForceRemovePlayer(udg_ChooseGroup, udg_HiddenAndroid) 
    endif 
    if udg_Allow_Parasite then 
        call StateGrid_SetPlayerRole(ForcePickRandomPlayer(udg_ChooseGroup), StateGrid_ROLE_ALIEN) 
        call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), udg_Parasite, bj_ALLIANCE_ALLIED_ADVUNITS) 
        call ForceRemovePlayer(udg_ChooseGroup, udg_Parasite) 
    endif 
    if udg_Allow_Mutant then 
        call StateGrid_SetPlayerRole(ForcePickRandomPlayer(udg_ChooseGroup), StateGrid_ROLE_MUTANT) 
        call ForceRemovePlayer(udg_ChooseGroup, udg_Mutant) 
    endif 
    call ForForce(GetPlayersAll(), function Trig_Chooser_DeclareMainRole) 
    call TriggerExecute(gg_trg_ChooseRoles) 
    call ForceClear(udg_ChooseGroup) 
    set chooseGroupSize = 0 
    call ForForce(GetPlayersAll(), function Trig_Chooser_PopulateChooseGroup) 
    call GroupClear(udg_ChooseRoles_SpawnGroup) 
    set udg_ChooseRoles_SpawnGroup = GetUnitsOfTypeIdAll('e003') 
    call ForGroup(udg_ChooseRoles_SpawnGroup, function Trig_Chooser_RemoveInvalidStartPositions)
    call ForForce(udg_ChooseGroup, function Trig_Chooser_PositionPlayerHeroes) 
    call DestroyTrigger(gg_trg_Researcher) 
    call DestroyTrigger(gg_trg_CEO) 
    call DestroyTrigger(gg_trg_Captain) 
    call DestroyTrigger(gg_trg_Commissar) 
    call DestroyTrigger(gg_trg_Janitor) 
    call DestroyTrigger(gg_trg_WarVeteran) 
    call DestroyTrigger(gg_trg_Engineer) 
    call DestroyTrigger(gg_trg_SecurityGuard) 
    call DestroyTrigger(gg_trg_Pilot) 
    set udg_TempBool = true 
    call ForForce(GetPlayersAll(), function Trig_Chooser_CheckIfAceExists) 
    if udg_TempBool then //if ace exists      
        set udg_ace_Existence = true 
        call ShowUnitHide(gg_unit_h02Q_0212) 
    endif 
    call GroupClear(udg_ChooseRoles_SpawnGroup) 
    call ConditionalTriggerExecute(gg_trg_RepickAlien) 
    call ConditionalTriggerExecute(gg_trg_RepickMutant) 
endfunction 

//===========================================================================      
function InitTrig_Chooser takes nothing returns nothing 
    set gg_trg_Chooser = CreateTrigger() 
    call TriggerRegisterTimerEventSingle(gg_trg_Chooser, 0.00) 
    call TriggerAddAction(gg_trg_Chooser, function Trig_Chooser_Actions) 
endfunction 

