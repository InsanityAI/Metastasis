function Trig_AshenDeath_Conditions takes nothing returns boolean 
    if(not(GetUnitAbilityLevelSwapped('A0A9', GetTriggerUnit()) == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AshenDeath_Func016Func001Func002C takes nothing returns boolean 
    if((udg_Mutant == GetEnumPlayer())) then 
        return true 
    endif 
    if((udg_Parasite == GetEnumPlayer())) then 
        return true 
    endif 
    if((udg_HiddenAndroid == GetEnumPlayer())) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_AshenDeath_Func016Func001C takes nothing returns boolean 
    if(not Trig_AshenDeath_Func016Func001Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AshenDeath_Func016A takes nothing returns nothing 
    if(Trig_AshenDeath_Func016Func001C()) then 
    else 
        set udg_TempInt = (udg_TempInt + 1) 
    endif 
endfunction 

function Trig_AshenDeath_Func017C takes nothing returns boolean 
    if(not(udg_TempInt == 0)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AshenDeath_Func019Func002Func028C takes nothing returns boolean 
    if((udg_Mutant == GetEnumPlayer())) then 
        return true 
    endif 
    if((udg_Parasite == GetEnumPlayer())) then 
        return true 
    endif 
    if((udg_HiddenAndroid == GetEnumPlayer())) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_AshenDeath_Func019Func002C takes nothing returns boolean 
    if(not Trig_AshenDeath_Func019Func002Func028C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AshenDeath_Func019A takes nothing returns nothing 
    // Do not revive alien and mutant 
    if(Trig_AshenDeath_Func019Func002C()) then 
    else 
        // Determining spawn point via angle 
        set udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 240.00, udg_TempReal) 

        call CreateNUnitsAtLoc(1, 'n00L', GetEnumPlayer(), udg_TempPoint, udg_TempReal) 
        call GroupAddUnitSimple(GetLastCreatedUnit(), udg_AshenMarineGroup) 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl") 
        call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
        set udg_TempReal = (udg_TempReal + (360.00 / I2R(udg_TempInt))) 
        set udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetEnumPlayer())] = false 
        set udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetEnumPlayer())] = false 
        call DisplayTextToPlayer(GetOwningPlayer(GetLastCreatedUnit()), 0, 0, "|cffff3909The Android brought you back to life - one last chance to carry mankind, since he crumbled under the burden. Make sure you do not die alone again, but take all of your enemies with you.| r ")
        call SetUnitLifePercentBJ(GetLastCreatedUnit(), 50.00) 
        set udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())] = GetLastCreatedUnit() 
        call SetPlayerName(GetEnumPlayer(), udg_Player_NameBeforeDead[GetConvertedPlayerId(GetEnumPlayer())]) 
        set ChatProfiles_getReal(GetEnumPlayer()).name = PlayerColor_GetPlayerTextColor(GetEnumPlayer()) + udg_Player_NameBeforeDead[GetConvertedPlayerId(GetEnumPlayer())] + "|r"
        call StateGrid_SetPlayerRole(GetEnumPlayer(), StateGrid_ROLE_HUMAN)
        call StateGrid_SetPlayerState(GetEnumPlayer(), StateGrid_STATE_ALIVE)
        call ShowInterfaceForceOn(GetForceOfPlayer(GetEnumPlayer()), 0.25) 
        call Timeout.start(0.26, false, function ChatUI_refreshChat)
        call PanCameraToTimedLocForPlayer(GetEnumPlayer(), udg_TempPoint, 0) 
        call SelectUnitForPlayerSingle(GetLastCreatedUnit(), GetEnumPlayer()) 
        call RemoveLocation(udg_TempPoint) 
        set udg_TempPlayer = GetEnumPlayer() 
        call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), GetEnumPlayer(), bj_ALLIANCE_ALLIED) 
        call SetPlayerAllianceStateBJ(GetEnumPlayer(), Player(bj_PLAYER_NEUTRAL_EXTRA), bj_ALLIANCE_ALLIED) 
        call ForceAddPlayerSimple(udg_TempPlayer, udg_TempPlayerGroup) 
        call ForceRemovePlayerSimple(GetEnumPlayer(), udg_DeadGroup) 
        call PlayerSelectedChat_SetPlayerChatGroup(GetEnumPlayer(), ChatSystem_groupAll)
        call ChatSystem_groupDead.remove(ChatProfiles_getReal(GetEnumPlayer()))
    endif 
endfunction 

function Trig_AshenDeath_Func020Func002A takes nothing returns nothing 
    call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED) 
    call SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED) 
endfunction 

function Trig_AshenDeath_Func020Func003A takes nothing returns nothing 
    call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_UNALLIED) 
    call SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION) 
endfunction 

function Trig_AshenDeath_Func020A takes nothing returns nothing 
    set udg_TempPlayer = GetEnumPlayer() 
    call ForForce(GetPlayersAll(), function Trig_AshenDeath_Func020Func002A) 
    call ForForce(udg_DeadGroup, function Trig_AshenDeath_Func020Func003A) 
endfunction 

function Trig_AshenDeath_Actions takes nothing returns nothing 
    local location a = GetUnitLoc(GetTriggerUnit()) 
    set udg_TempPoint = a 
    call CreateNUnitsAtLoc(1, 'e00R', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING) 
    set udg_TempUnit = GetLastCreatedUnit() 
    set udg_CountUpBarColor = "|cffFF0000" 
    call BasicAI_IssueDangerArea(a, 800.0, 3.1) 
    call CountUpBar(udg_TempUnit, 60, 0.05, "FusionBombExplosion2") 
    call TriggerSleepAction(3.00) 
    // --- 
    set udg_TempPoint2 = a 
    set udg_TempReal = 0.00 
    // TempInt = amount of players to revive 
    set udg_TempInt = 0 
    call ForForce(udg_DeadGroup, function Trig_AshenDeath_Func016A) 
    if(Trig_AshenDeath_Func017C()) then 
        return 
    else 
    endif 
    call ForceClear(udg_TempPlayerGroup) 
    call ForForce(udg_DeadGroup, function Trig_AshenDeath_Func019A) 
    call ForForce(udg_TempPlayerGroup, function Trig_AshenDeath_Func020A) 
    call StartTimerBJ(udg_AshenMarineFadeTimer, true, 1.12) 
    call ForceClear(udg_TempPlayerGroup) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_AshenDeath takes nothing returns nothing 
    set gg_trg_AshenDeath = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AshenDeath, EVENT_PLAYER_UNIT_DEATH) 
    call TriggerAddCondition(gg_trg_AshenDeath, Condition(function Trig_AshenDeath_Conditions)) 
    call TriggerAddAction(gg_trg_AshenDeath, function Trig_AshenDeath_Actions) 
endfunction 

