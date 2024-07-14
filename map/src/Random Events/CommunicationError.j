function Trig_CommunicationError_Func005Func001Func003001002001 takes nothing returns boolean
    return ( GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER )
endfunction

function Trig_CommunicationError_Func005Func001C takes nothing returns boolean
    if ( not ( IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), GetPlayersMatching(Condition(function Trig_CommunicationError_Func005Func001Func003001002001))) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_CommunicationError_Func006A takes nothing returns nothing
    call SetPlayerName( GetEnumPlayer(), ( "  " + ( ( ( ( "                                                                                                                                                                                                                                                " + "                                                                                                                                                                                                                                                " ) + "                                                                                                                                                                                                                                                " ) + "                                                                                                                                                                                                                                                " ) + "                                                                                                                                                                                                                                                " ) ) )
endfunction

function Trig_CommunicationError_Func009Func001Func001001002001 takes nothing returns boolean
    return ( GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER )
endfunction

function Trig_CommunicationError_Func009Func001Func002Func002C takes nothing returns boolean
    if ( not ( udg_ColorArray[udg_TempInt] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_CommunicationError_Func009Func001C takes nothing returns boolean
    if ( not ( IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), GetPlayersMatching(Condition(function Trig_CommunicationError_Func009Func001Func001001002001))) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_CommunicationError_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_On[18] = true
    call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(240.00, 600.00) )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4179" )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 12
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_CommunicationError_Func005Func001C() ) then
            set udg_NamesTemp[GetForLoopIndexA()] = GetPlayerName(ConvertedPlayer(GetForLoopIndexA()))
            set udg_ColorArray[GetForLoopIndexA()] = true
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call ForForce( udg_AllPlayers, function Trig_CommunicationError_Func006A )
    call TriggerSleepAction( 60.00 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4181" )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 12
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_CommunicationError_Func009Func001C() ) then
            set bj_forLoopBIndex = 1
            set bj_forLoopBIndexEnd = 1000
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                set udg_TempInt = GetRandomInt(1, 12)
                if ( Trig_CommunicationError_Func009Func001Func002Func002C() ) then
                    set bj_forLoopBIndex = 10000
                else
                endif
                set bj_forLoopBIndex = bj_forLoopBIndex + 1
            endloop
            call SetPlayerName( ConvertedPlayer(GetForLoopIndexA()), udg_NamesTemp[udg_TempInt] )
            call SetPlayerColorBJ( ConvertedPlayer(GetForLoopIndexA()), GetPlayerColor(ConvertedPlayer(udg_TempInt)), true )
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig_CommunicationError takes nothing returns nothing
    set gg_trg_CommunicationError = CreateTrigger(  )
    call DisableTrigger( gg_trg_CommunicationError )
    call TriggerAddAction( gg_trg_CommunicationError, function Trig_CommunicationError_Actions )
endfunction

