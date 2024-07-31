function NIFPO_Sort takes nothing returns nothing 
    if IsPlayerHuman(GetEnumPlayer()) then 
        call ForceAddPlayer(udg_TempPlayerGroup, GetEnumPlayer()) 
    endif 
endfunction 

function NoninfectedForcePickOne takes nothing returns player 
    local player p 
    
    set udg_TempPlayerGroup = CreateForce() 
    call ForForce(GetPlayersAll(), function NIFPO_Sort) 
    set p = ForcePickRandomPlayer(udg_TempPlayerGroup) 
    call DestroyForce(udg_TempPlayerGroup) 
    return p 
endfunction 

function Trig_PlayerLeaves_Actions takes nothing returns nothing 
    local player p 
    local boolean b = IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) 

    set udg_Player_Left[GetConvertedPlayerId(GetTriggerPlayer())] = true 
    call DisplayTextToForce(GetPlayersAll(), (udg_OriginalName[GetConvertedPlayerId(GetTriggerPlayer())] + "|cff408080 has left the game!|r")) 
    call KillUnit(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) //Kill leaver's playerhero unit  
    call UnitAddAbility(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())], 'A02T') //And stay dead  
    call StateGrid_SetPlayerState(GetTriggerPlayer(), StateGrid_STATE_LEFT) 
    
    //If less than 90 seconds passed AND player who left is alien, mutant, or android  
    if TimerGetElapsed(udg_GameTimer) <= 90.0 and(IsPlayerMainInfected(GetTriggerPlayer()) or udg_HiddenAndroid == GetTriggerPlayer()) then 
        
        if udg_Mutant == GetTriggerPlayer() then 
            call DisplayTextToForce(GetPlayersAll(), "Reassigning a new mutant...") 
            set p = NoninfectedForcePickOne() 
            if p != null then 
                set udg_Mutant = p 
                call StateGrid_SetPlayerRole(udg_Mutant, StateGrid_ROLE_MUTANT) 
                call ChatSystem_groupMutants.add(ChatProfiles_getReal(udg_Mutant))
                call DisplayTextToPlayer(p, 0, 0, "|cffFF0000You are now the mutant. Seek out all enemies and destroy them.") 
                call CreateNUnitsAtLoc(1, 'e031', p, udg_HoldZone, bj_UNIT_FACING) //Was GetEnumUnit()  
                //If it doesn't work, also add the ability on the playerhero unit  
            else 
                call DisplayTextToForce(GetPlayersAll(), "Not enough players for a new mutant.") 
            endif 
        endif 
        
        if udg_Parasite == GetTriggerPlayer() then 
            call DisplayTextToForce(GetPlayersAll(), "Reassigning a new alien...") 
            set p = NoninfectedForcePickOne() 
            if p != null then 
                set udg_Parasite = p 
                call StateGrid_SetPlayerRole(udg_Parasite, StateGrid_ROLE_ALIEN) 
                call ChatSystem_groupAliens.add(ChatProfiles_getReal(udg_Mutant))
                call DisplayTextToPlayer(p, 0, 0, "|cffFF0000You are now the alien. Seek out all enemies and destroy them.") 
                call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), p, bj_ALLIANCE_ALLIED_ADVUNITS) 
            else 
                call DisplayTextToForce(GetPlayersAll(), "Not enough players for a new alien.") 
            endif 
        endif 
        
        if udg_HiddenAndroid == GetTriggerPlayer() then 
            call DisplayTextToForce(GetPlayersAll(), "Reassigning a new android...") 
            set p = NoninfectedForcePickOne() 
            if p != null then 
                set udg_HiddenAndroid = p 
                call StateGrid_SetPlayerRole(udg_HiddenAndroid, StateGrid_ROLE_ANDROID) 
                call DisplayTextToPlayer(p, 0, 0, "|cffFF0000You are now the android. Protect the humans and eliminate the alien threat.") 
            else 
                call DisplayTextToForce(GetPlayersAll(), "Not enough players for a new android.") 
            endif 
        endif 
    endif 
endfunction 

//===========================================================================  
function InitTrig_PlayerLeaves takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_PlayerLeaves = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerEventLeave(gg_trg_PlayerLeaves, Player(i)) 
        set i = i + 1 
    endloop 
    call TriggerAddAction(gg_trg_PlayerLeaves, function Trig_PlayerLeaves_Actions) 
endfunction 

