function Trig_PlayerMurderPart2_Func001C takes nothing returns boolean 
    if(not(IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerMurderPart2_Func003Func007Func001C takes nothing returns boolean 
    if(not(IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerMurderPart2_Func003Func007A takes nothing returns nothing 
    if(Trig_PlayerMurderPart2_Func003Func007Func001C()) then 
        call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED_VISION) 
        call SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED) 
    else 
    endif 
endfunction 

function Trig_PlayerMurderPart2_Func003Func012C takes nothing returns boolean 
    if(not(udg_Player_TetrabinLevel[GetConvertedPlayerId(udg_TempPlayer)] >= 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerMurderPart2_Func003Func013C takes nothing returns boolean 
    if(not(udg_DeathType == 2)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerMurderPart2_Func003Func014Func001C takes nothing returns boolean 
    if(not(IsUnitDeadBJ(GetEnumUnit()) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerMurderPart2_Func003Func014A takes nothing returns nothing 
    if(Trig_PlayerMurderPart2_Func003Func014Func001C()) then 
    else 
        call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true) 
    endif 
endfunction 

function Trig_PlayerMurderPart2_Func003Func017Func001C takes nothing returns boolean 
    if(not(IsUnitDeadBJ(GetEnumUnit()) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerMurderPart2_Func003Func017A takes nothing returns nothing 
    if(Trig_PlayerMurderPart2_Func003Func017Func001C()) then 
    else 
        call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true) 
    endif 
endfunction 

function Trig_PlayerMurderPart2_Func003Func023Func002C takes nothing returns boolean 
    if((udg_Android_Preference == 'h052')) then 
        return true 
    endif 
    if hasRevivedAsPacificationBot == true then 
        return true 
    endif 
    return false 
endfunction 

function Trig_PlayerMurderPart2_Func003Func023C takes nothing returns boolean 
    if(not Trig_PlayerMurderPart2_Func003Func023Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerMurderPart2_Func003C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_HiddenAndroid)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlayerMurderPart2_Actions takes nothing returns nothing 
    if(Trig_PlayerMurderPart2_Func001C()) then 
        return 
    else 
    endif 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call RemoveItem(UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA())) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    if(Trig_PlayerMurderPart2_Func003C()) then 
        call DisplayTextToPlayer(udg_TempPlayer, 0, 0, "You have died. You will be allowed to watch only where your memory card is. As you are the android, you may yet be revived. If you do not wish to be revived or recognize this as impossible, you may type - shutdown to forfeit all revival priviledges.")
        call ForGroupBJ(GetUnitsOfPlayerAll(udg_TempPlayer), function Trig_PlayerMurderPart2_Func003Func017A) 
        call EnableTrigger(gg_trg_AndroidCardVision) 
        set AndroidChat_Enabled = true
        set udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)] = GetPlayerName(udg_TempPlayer) 
        call ForceAddPlayerSimple(udg_TempPlayer, udg_DeadGroup) 
        if(Trig_PlayerMurderPart2_Func003Func023C()) then 
            call RemoveItem(udg_Android_MemoryCard) 
        else 
        endif 
    else 
        call DisplayTextToPlayer(udg_TempPlayer, 0, 0, "You have died. You can stay and watch the game, or leave at any time.") 
        set udg_Player_Spectating[GetConvertedPlayerId(udg_TempPlayer)] = true 
        call ForForce(GetPlayersAll(), function Trig_PlayerMurderPart2_Func003Func007A) 
        call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPlayer, bj_ALLIANCE_ALLIED_VISION) 
        call ForceAddPlayerSimple(udg_TempPlayer, udg_DeadGroup) 
        set udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)] = GetPlayerName(udg_TempPlayer) 
        if(Trig_PlayerMurderPart2_Func003Func012C()) then 
            call CameraClearNoiseForPlayer(udg_TempPlayer) 
        else 
        endif 
        if(Trig_PlayerMurderPart2_Func003Func013C()) then 
            call CustomDefeatBJ(udg_TempPlayer, "TRIGSTR_3582") 
        else 
        endif 
        call ForGroupBJ(GetUnitsOfPlayerAll(udg_TempPlayer), function Trig_PlayerMurderPart2_Func003Func014A) 
    endif 
    call TriggerExecute(gg_trg_WinCheck) 
endfunction 

//=========================================================================== 
function InitTrig_PlayerMurderPart2 takes nothing returns nothing 
    set gg_trg_PlayerMurderPart2 = CreateTrigger() 
    call TriggerAddAction(gg_trg_PlayerMurderPart2, function Trig_PlayerMurderPart2_Actions) 
endfunction 

