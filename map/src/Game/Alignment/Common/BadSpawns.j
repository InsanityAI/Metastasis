//TESH.scrollpos=7
//TESH.alwaysfold=0
function Trig_BadSpawns_Conditions takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 1, 10) == "-liquidate" or SubStringBJ(GetEventPlayerChatString(), 1, 2) == "-l" ) ) then
        return false
    endif
    return true
endfunction

function Trig_BadSpawns_Func004Func001C takes nothing returns boolean
    if ( not ( udg_Parasite == GetTriggerPlayer() ) ) then
        return false
    endif
    if ( not ( udg_Player_IsParasiteSpawn[udg_TempInt] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_BadSpawns_Func004Func002C takes nothing returns boolean
    if ( not ( udg_Mutant == GetTriggerPlayer() ) ) then
        return false
    endif
    if ( not ( udg_Player_IsMutantSpawn[udg_TempInt] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_BadSpawns_Func004C takes nothing returns boolean
    if ( not ( udg_TempInt != 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_BadSpawns_Actions takes nothing returns nothing
    call ExecuteFunc( "ClearArguments" )
    call ExecuteFunc( "ParseEnteredString" )
    if not(HaveSavedInteger(LS(), GetHandleId(gg_trg_ChatGroupBroadcast), StringHash(udg_arguments[2]))) then
    return
    endif
        set udg_TempInt=LoadInteger(LS(), GetHandleId(gg_trg_ChatGroupBroadcast), StringHash(udg_arguments[2]))
    if ( Trig_BadSpawns_Func004C() ) then
        if ( Trig_BadSpawns_Func004Func001C() ) then
            //call KillUnit( udg_Playerhero[udg_TempInt] )
                call DialogClearBJ( udg_Liquidate_AreYouSure2 )
                call DialogSetMessageBJ( udg_Liquidate_AreYouSure2, ( "Are you sure you wish to liquidate " + ( udg_ColorCode[udg_TempInt] + ( GetPlayerName(ConvertedPlayer(udg_TempInt)) + "|r?" ) ) ) )
                call DialogAddButtonBJ( udg_Liquidate_AreYouSure2, "TRIGSTR_2556" )
                set udg_Liquidate_AreYouSureButton2[1] = GetLastCreatedButtonBJ()
                call DialogAddButtonBJ( udg_Liquidate_AreYouSure2, "TRIGSTR_2557" )
                set udg_Liquidate_AreYouSureButton2[2] = GetLastCreatedButtonBJ()
                set udg_Liquidate_ToLiquidate2 = udg_TempInt
                call DialogDisplayBJ( true, udg_Liquidate_AreYouSure2, udg_Parasite )
        else
        endif
        if ( Trig_BadSpawns_Func004Func002C() ) then
           // call KillUnit( udg_Playerhero[udg_TempInt] )
    call DialogClearBJ( udg_Liquidate_AreYouSure )
    call DialogSetMessageBJ( udg_Liquidate_AreYouSure, ( "Are you sure you wish to liquidate " + ( udg_ColorCode[udg_TempInt] + ( GetPlayerName(ConvertedPlayer(udg_TempInt)) + "|r?" ) ) ) )
    call DialogAddButtonBJ( udg_Liquidate_AreYouSure, "TRIGSTR_2556" )
    set udg_Liquidate_AreYouSureButton[1] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ( udg_Liquidate_AreYouSure, "TRIGSTR_2557" )
    set udg_Liquidate_AreYouSureButton[2] = GetLastCreatedButtonBJ()
    set udg_Liquidate_ToLiquidate = udg_TempInt
    call DialogDisplayBJ( true, udg_Liquidate_AreYouSure, udg_Mutant )
        else
        endif
    else
    endif
endfunction

//===========================================================================
function InitTrig_BadSpawns takes nothing returns nothing
local integer i=0
    set gg_trg_BadSpawns = CreateTrigger(  )
    loop
    exitwhen i > 11
    call TriggerRegisterPlayerChatEvent( gg_trg_BadSpawns, Player(i), "-liquidate ", false )
        call TriggerRegisterPlayerChatEvent( gg_trg_BadSpawns, Player(i), "-l ", false )
    set i=i+1
    endloop
    call TriggerAddCondition( gg_trg_BadSpawns, Condition( function Trig_BadSpawns_Conditions ) )
    call TriggerAddAction( gg_trg_BadSpawns, function Trig_BadSpawns_Actions )
endfunction

