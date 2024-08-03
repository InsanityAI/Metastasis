function Trig_WinCheck_Func001C takes nothing returns boolean
    if ( not ( udg_WC_Disable == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func003Func003Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(ConvertedPlayer(GetForLoopIndexA()))] == true ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetForLoopIndexA()]) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func003Func004Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(ConvertedPlayer(GetForLoopIndexA()))] == true ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetForLoopIndexA()]) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func003Func005Func010A takes nothing returns nothing
    call SetUnitAnimation( GetEnumUnit(), "victory" )
endfunction

function Trig_WinCheck_Func003Func005Func011A takes nothing returns nothing
    call SetPlayerName( GetEnumPlayer(), Anonymity_GetOriginalPlayerName(GetEnumPlayer()) )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 12
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call SetPlayerAllianceStateBJ( ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

function Trig_WinCheck_Func003Func005C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func003Func006C takes nothing returns boolean
    if ( ( IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true ) ) then
        return true
    endif
    if ( ( udg_Allow_Mutant == false ) ) then
        return true
    endif
    return false
endfunction

function Trig_WinCheck_Func003Func007C takes nothing returns boolean
    if ( ( IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == true ) ) then
        return true
    endif
    if ( ( udg_Allow_Parasite == false ) ) then
        return true
    endif
    return false
endfunction

function Trig_WinCheck_Func003C takes nothing returns boolean
    if ( not ( udg_GameEnd == false ) ) then
        return false
    endif
    if ( not Trig_WinCheck_Func003Func006C() ) then
        return false
    endif
    if ( not Trig_WinCheck_Func003Func007C() ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func004Func003Func001C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetForLoopIndexA()]) == true ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), udg_DeadGroup) == false ) ) then
        return false
    endif
    if ( not ( ConvertedPlayer(GetForLoopIndexA()) != udg_Mutant ) ) then
        return false
    endif
    if ( not ( udg_Player_IsMutantSpawn[GetForLoopIndexA()] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func004Func004Func010A takes nothing returns nothing
    call SetPlayerName( GetEnumPlayer(), Anonymity_GetOriginalPlayerName(GetEnumPlayer()) )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 12
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call SetPlayerAllianceStateBJ( ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

function Trig_WinCheck_Func004Func004Func012A takes nothing returns nothing
    call SetUnitAnimation( GetEnumUnit(), "victory" )
endfunction

function Trig_WinCheck_Func004Func004C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func004Func005C takes nothing returns boolean
    if ( ( IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == true ) ) then
        return true
    endif
    if ( ( udg_Allow_Parasite == false ) ) then
        return true
    endif
    if ( ( GetPlayerSlotState(udg_Parasite) != PLAYER_SLOT_STATE_PLAYING ) ) then
        return true
    endif
    return false
endfunction

function Trig_WinCheck_Func004C takes nothing returns boolean
    if ( not ( udg_GameEnd == false ) ) then
        return false
    endif
    if ( not Trig_WinCheck_Func004Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func005Func003Func001C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetForLoopIndexA()]) == true ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), udg_DeadGroup) == false ) ) then
        return false
    endif
    if ( not ( ConvertedPlayer(GetForLoopIndexA()) != udg_Parasite ) ) then
        return false
    endif
    if ( not ( udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func005Func004Func010A takes nothing returns nothing
    call SetPlayerName( GetEnumPlayer(), Anonymity_GetOriginalPlayerName(GetEnumPlayer())  )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 12
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call SetPlayerAllianceStateBJ( ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

function Trig_WinCheck_Func005Func004Func012A takes nothing returns nothing
    call SetUnitAnimation( GetEnumUnit(), "victory" )
endfunction

function Trig_WinCheck_Func005Func004C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Func005Func005C takes nothing returns boolean
    if ( ( IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true ) ) then
        return true
    endif
    if ( ( udg_Allow_Mutant == false ) ) then
        return true
    endif
    if ( ( GetPlayerSlotState(udg_Mutant) != PLAYER_SLOT_STATE_PLAYING ) ) then
        return true
    endif
    return false
endfunction

function Trig_WinCheck_Func005C takes nothing returns boolean
    if ( not ( udg_GameEnd == false ) ) then
        return false
    endif
    if ( not Trig_WinCheck_Func005Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_WinCheck_Actions takes nothing returns nothing
    if ( Trig_WinCheck_Func001C() ) then
        return
    else
    endif
    call PolledWait( 0.25 )
    if ( Trig_WinCheck_Func003C() ) then
        set udg_TempBool = true
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 12
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_WinCheck_Func003Func003Func001C() ) then
                set udg_TempBool = false
            else
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 12
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_WinCheck_Func003Func004Func001C() ) then
                set udg_TempBool = false
            else
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        if ( Trig_WinCheck_Func003Func005C() ) then
            set udg_GameEnd = true
            call DestroyTrigger(gg_trg_PlayerDeathText)
            call DestroyTrigger(gg_trg_WinCheck)
            call DestroyTrigger(gg_trg_PlayerMurder)
            call DestroyTrigger(GetTriggeringTrigger())
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1068" )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1624" )
            call PlaySoundBJ( gg_snd_HumanVictory )
            call PolledWait( 2.00 )
            call ForGroupBJ( GetUnitsInRectAll(GetPlayableMapRect()), function Trig_WinCheck_Func003Func005Func010A )
            call ForForce( GetPlayersAll(), function Trig_WinCheck_Func003Func005Func011A )
            call FogEnableOff(  )
            call PolledWait( 10.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1070" )
            call PolledWait( 15.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1071" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1072" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1073" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1074" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1075" )
            call PolledWait( 1.00 )
            call EndGame(true)
        else
        endif
    else
    endif
    if ( Trig_WinCheck_Func004C() ) then
        set udg_TempBool = true
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 12
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_WinCheck_Func004Func003Func001C() ) then
                set udg_TempBool = false
            else
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        if ( Trig_WinCheck_Func004Func004C() ) then
            set udg_GameEnd = true
            call DestroyTrigger(gg_trg_PlayerDeathText)
            call DestroyTrigger(gg_trg_WinCheck)
            call DestroyTrigger(GetTriggeringTrigger())
            call DestroyTrigger(gg_trg_PlayerMurder)
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1076" )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1623" )
            call PlaySoundBJ( gg_snd_DarkVictory )
            call PolledWait( 2 )
            call ForForce( GetPlayersAll(), function Trig_WinCheck_Func004Func004Func010A )
            call FogEnableOff(  )
            call ForGroupBJ( GetUnitsInRectAll(GetPlayableMapRect()), function Trig_WinCheck_Func004Func004Func012A )
            call PolledWait( 10.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1622" )
            call PolledWait( 15.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1079" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1080" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1081" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1082" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1083" )
            call PolledWait( 1.00 )
            call EndGame(true)
        else
        endif
    else
    endif
    if ( Trig_WinCheck_Func005C() ) then
        set udg_TempBool = true
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 12
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if ( Trig_WinCheck_Func005Func003Func001C() ) then
                set udg_TempBool = false
            else
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        if ( Trig_WinCheck_Func005Func004C() ) then
            set udg_GameEnd = true
            call DestroyTrigger(gg_trg_PlayerDeathText)
            call DestroyTrigger(gg_trg_WinCheck)
            call DestroyTrigger(gg_trg_PlayerMurder)
            call DestroyTrigger(GetTriggeringTrigger())
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1084" )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1085" )
            call PlaySoundBJ( gg_snd_SadMystery )
            call PolledWait( 2 )
            call ForForce( GetPlayersAll(), function Trig_WinCheck_Func005Func004Func010A )
            call FogEnableOff(  )
            call ForGroupBJ( GetUnitsInRectAll(GetPlayableMapRect()), function Trig_WinCheck_Func005Func004Func012A )
            call PolledWait( 10.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1621" )
            call PolledWait( 15.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1087" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1088" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1089" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1090" )
            call PolledWait( 1.00 )
            call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1091" )
            call PolledWait( 1.00 )
            call EndGame(true)
        else
        endif
    else
    endif
endfunction

//===========================================================================
function InitTrig_WinCheck takes nothing returns nothing
    set gg_trg_WinCheck = CreateTrigger(  )
    call DisableTrigger( gg_trg_WinCheck )
    call TriggerAddAction( gg_trg_WinCheck, function Trig_WinCheck_Actions )
endfunction

