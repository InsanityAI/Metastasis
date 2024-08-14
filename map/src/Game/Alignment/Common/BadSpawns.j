function Trig_BadSpawns_Conditions takes nothing returns boolean
    return SubStringBJ(GetEventPlayerChatString(), 1, 10) == "-liquidate" or SubStringBJ(GetEventPlayerChatString(), 1, 2) == "-l"
endfunction

function Trig_BadSpawns_IsAlien takes player spawnPlayer returns boolean
    return udg_Parasite == GetTriggerPlayer() and udg_Player_IsParasiteSpawn[GetConvertedPlayerId(spawnPlayer)] == true
endfunction

function Trig_BadSpawns_IsMutant takes player spawnPlayer returns boolean
    return udg_Mutant == GetTriggerPlayer() and udg_Player_IsMutantSpawn[GetConvertedPlayerId(spawnPlayer)] == true
endfunction

function Trig_BadSpawns_Actions takes nothing returns nothing
    local player targettedPlayer
    call ExecuteFunc( "ClearArguments" )
    call ExecuteFunc( "ParseEnteredString" )
    if udg_arguments[2] == null or udg_arguments[2] == "" then
        return
    endif
    set udg_TempInt = S2I(udg_arguments[2])
    if udg_TempInt != 0 then
        set targettedPlayer = Anonymity_ShuffledPlayersArray[udg_TempInt - 1]
        if Trig_BadSpawns_IsAlien(targettedPlayer) then
            call DialogClearBJ( udg_Liquidate_AreYouSure2 )
            call DialogSetMessageBJ( udg_Liquidate_AreYouSure2, ( "Are you sure you wish to liquidate " + ( PlayerColor_GetByPlayer(targettedPlayer).color + ( GetPlayerName(targettedPlayer) + "|r?" ) ) ) )
            call DialogAddButtonBJ( udg_Liquidate_AreYouSure2, "TRIGSTR_2556" )
            set udg_Liquidate_AreYouSureButton2[1] = GetLastCreatedButtonBJ()
            call DialogAddButtonBJ( udg_Liquidate_AreYouSure2, "TRIGSTR_2557" )
            set udg_Liquidate_AreYouSureButton2[2] = GetLastCreatedButtonBJ()
            set udg_Liquidate_ToLiquidate2 = udg_TempInt
            call DialogDisplayBJ( true, udg_Liquidate_AreYouSure2, udg_Parasite )
        endif
        if Trig_BadSpawns_IsMutant(targettedPlayer) then
            call DialogClearBJ( udg_Liquidate_AreYouSure )
            call DialogSetMessageBJ( udg_Liquidate_AreYouSure, ( "Are you sure you wish to liquidate " + ( PlayerColor_GetByPlayer(targettedPlayer).color+ ( GetPlayerName(targettedPlayer) + "|r?" ) ) ) )
            call DialogAddButtonBJ( udg_Liquidate_AreYouSure, "TRIGSTR_2556" )
            set udg_Liquidate_AreYouSureButton[1] = GetLastCreatedButtonBJ()
            call DialogAddButtonBJ( udg_Liquidate_AreYouSure, "TRIGSTR_2557" )
            set udg_Liquidate_AreYouSureButton[2] = GetLastCreatedButtonBJ()
            set udg_Liquidate_ToLiquidate = udg_TempInt
            call DialogDisplayBJ( true, udg_Liquidate_AreYouSure, udg_Mutant )
        endif
    endif
endfunction

//===========================================================================
function InitTrig_BadSpawns takes nothing returns nothing
    local integer i=0
    set gg_trg_BadSpawns = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent( gg_trg_BadSpawns, Player(i), "-liquidate ", false )
        call TriggerRegisterPlayerChatEvent( gg_trg_BadSpawns, Player(i), "-l ", false )
        set i=i+1
    endloop
    call TriggerAddCondition( gg_trg_BadSpawns, Condition( function Trig_BadSpawns_Conditions ) )
    call TriggerAddAction( gg_trg_BadSpawns, function Trig_BadSpawns_Actions )
endfunction

