function Trig_BackFromHellDialog_Func002C takes nothing returns boolean 
    if(not(udg_BackFromHellDialogButtons[0] == GetClickedButtonBJ())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHellDialog_Func005C takes nothing returns boolean 
    if(not(udg_EldritchBeastExists == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHellDialog_Func006Func001C takes nothing returns boolean 
    if(not(udg_BackFromHellDialogButtons[GetForLoopIndexA()] == GetClickedButtonBJ())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHellDialog_Func009Func007C takes nothing returns boolean 
    if(not(udg_Mutant == udg_TempPlayer)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHellDialog_Func009Func016A takes nothing returns nothing 
    call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED) 
    call SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED) 
endfunction 

function Trig_BackFromHellDialog_Func009Func019A takes nothing returns nothing 
    call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_UNALLIED) 
    call SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION) 
endfunction 

function Trig_BackFromHellDialog_Func009C takes nothing returns boolean 
    if(not(udg_TempBool == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BackFromHellDialog_Actions takes nothing returns nothing 
    if(Trig_BackFromHellDialog_Func002C()) then 
        call DialogDisplayBJ(true, udg_BackFromHellDialog, GetTriggerPlayer()) 
        return 
    else 
    endif 
    set udg_TempBool = false 
    // TempBool determines if eldritch beast spawn or player 
    if(Trig_BackFromHellDialog_Func005C()) then 
        set udg_TempInt = 1 
    else 
        set udg_TempInt = 2 
    endif 
    set bj_forLoopAIndex = udg_TempInt 
    set bj_forLoopAIndexEnd = 12 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        if(Trig_BackFromHellDialog_Func006Func001C()) then 
            set udg_TempPlayer = udg_BackFromHellDialog_Player[GetForLoopIndexA()] 
            set udg_TempBool = true 
        else 
        endif 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    set udg_TempPoint2 = GetUnitLoc(udg_AlienForm_Alien) 
    set udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 25.00, GetUnitFacing(udg_AlienForm_Alien)) 
    if(Trig_BackFromHellDialog_Func009C()) then 
        call CreateNUnitsAtLoc(1, 'n00E', udg_TempPlayer, udg_TempPoint, bj_UNIT_FACING) 
        set udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_TempPlayer)] = true 
        set udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_TempPlayer)] = false 
        if(Trig_BackFromHellDialog_Func009Func007C()) then 
            set udg_Mutant = null 
        endif 
        call StateGrid_SetPlayerRole(udg_TempPlayer, StateGrid_ROLE_ALIEN_SPAWN) 
        call StateGrid_SetPlayerState(udg_TempPlayer, StateGrid_STATE_ALIVE) 
        call ChatSystem_groupAliens.add(ChatProfiles_getReal(udg_TempPlayer))
        call ChatSystem_groupDead.remove(ChatProfiles_getReal(udg_TempPlayer))
        call PlayerSelectedChat_SetPlayerChatGroup(udg_TempPlayer, ChatSystem_groupAll)
        call DisplayTextToPlayer(GetOwningPlayer(GetDyingUnit()), 0, 0, "|cffFF0000You have been turned into the alien's spawn! Work with the alien to ensure victory.|r") 
        call SetUnitLifeBJ(GetLastCreatedUnit(), 1.00) 
        set udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit() 
        call SetPlayerName(udg_TempPlayer, udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)]) 
        set ChatProfiles_getReal(udg_TempPlayer).name = PlayerColor_GetPlayerTextColor(udg_TempPlayer) + udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)] + "|r"
        call ShowInterfaceForceOn(GetForceOfPlayer(udg_TempPlayer), 0.25) 
        call PanCameraToTimedLocForPlayer(udg_TempPlayer, udg_TempPoint, 0) 
        call SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_TempPlayer) 
        call ForceRemovePlayerSimple(udg_TempPlayer, udg_DeadGroup) 
        call ForForce(GetPlayersAll(), function Trig_BackFromHellDialog_Func009Func016A) 
        call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPlayer, bj_ALLIANCE_ALLIED) 
        call SetPlayerAllianceStateBJ(udg_TempPlayer, Player(bj_PLAYER_NEUTRAL_EXTRA), bj_ALLIANCE_ALLIED) 
        call ForForce(udg_DeadGroup, function Trig_BackFromHellDialog_Func009Func019A) 
    else 
        call CreateNUnitsAtLoc(1, 'h02Z', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING) 
        set udg_EldritchBeastExists = true 
    endif 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
endfunction 

//=========================================================================== 
function InitTrig_BackFromHellDialog takes nothing returns nothing 
    set gg_trg_BackFromHellDialog = CreateTrigger() 
    call TriggerRegisterDialogEventBJ(gg_trg_BackFromHellDialog, udg_BackFromHellDialog) 
    call TriggerAddAction(gg_trg_BackFromHellDialog, function Trig_BackFromHellDialog_Actions) 
endfunction 

