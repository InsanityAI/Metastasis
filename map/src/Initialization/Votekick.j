function Trig_Votekick_Conditions takes nothing returns boolean
    return SubStringBJ(GetEventPlayerChatString(), 1, 10) == "-votekick "
endfunction

function Trig_Votekick_IsAlive takes nothing returns boolean
    return IsPlayerInForce(ConvertedPlayer(GetForLoopIndexA()), udg_DeadGroup) == false and GetPlayerSlotState(ConvertedPlayer(GetForLoopIndexA())) == PLAYER_SLOT_STATE_PLAYING
endfunction

function Trig_Votekick_IsAndroid takes nothing returns boolean
    return ConvertedPlayer(udg_TempInt) == udg_HiddenAndroid
endfunction

function Trig_Votekick_ReachedThreshold takes nothing returns boolean
    return udg_Player_DeadKickVotes[udg_TempInt] >= ( udg_TempInt2 / 2 )
endfunction

function Trig_Votekick_Func019Func002C takes nothing returns boolean
    if ( not ( IsPlayerInForce(ConvertedPlayer(udg_TempInt), udg_DeadGroup) == true ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) == false ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(GetTriggerPlayer(), udg_Player_VotedKickGroup[udg_TempInt]) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Votekick_Actions takes nothing returns nothing
    // Standard argument parsing. Parses any entered string into a series of arguments seperated by spaces. -kill noob becausehesucks would set arguments[1] equal to -kill, arguments[2] to noob, etc.
    call ExecuteFunc( "ClearArguments" )
    call ExecuteFunc( "ParseEnteredString" )
    // Nasty crashes can occur if you don't check if you have an integer before you use it.
    if udg_arguments[2] != null and udg_arguments[2] != "" then
        set udg_TempInt=GetConvertedPlayerId(Anonymity_ShuffledPlayersArray[S2I(udg_arguments[2]) - 1])
        if ( Trig_Votekick_Func019Func002C() ) then
            set udg_Player_DeadKickVotes[udg_TempInt] = ( udg_Player_DeadKickVotes[udg_TempInt] + 1 )
            set udg_TempInt2 = 0
            call ForceAddPlayerSimple( GetTriggerPlayer(), udg_Player_VotedKickGroup[udg_TempInt] )
            set bj_forLoopAIndex = 1
            set bj_forLoopAIndexEnd = 12
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if ( Trig_Votekick_IsAlive() ) then
                    set udg_TempInt2 = ( udg_TempInt2 + 1 )
                else
                endif
                set bj_forLoopAIndex = bj_forLoopAIndex + 1
            endloop
            if ( Trig_Votekick_ReachedThreshold() ) then
                if ( Trig_Votekick_IsAndroid() ) then
                    call DisplayTextToForce( GetPlayersAll(), ( "Dialoguing offensive android..." + ( " " + ( udg_Player_OriginalName[udg_TempInt] + "!" ) ) ) )
                    call ShowInterfaceForceOff( GetForceOfPlayer(udg_HiddenAndroid), 2.00 )
                else
                    call DisplayTextToForce( GetPlayersAll(), ( "Dialoguing offensive player..." + ( " " + ( udg_Player_OriginalName[udg_TempInt] + "!" ) ) ) )
                    call ShowInterfaceForceOff( GetForceOfPlayer(ConvertedPlayer(udg_TempInt)), 2.00 )
                endif
            else
                call DisplayTextToForce( GetPlayersAll(), ( I2S(( ( udg_TempInt2 / 2 ) - udg_Player_DeadKickVotes[udg_TempInt] )) + ( " votes left to kick " + ( udg_Player_OriginalName[udg_TempInt] + "!" ) ) ) )
            endif
        else
        endif
    else
    endif
endfunction

//===========================================================================
function InitTrig_Votekick takes nothing returns nothing
    set gg_trg_Votekick = CreateTrigger(  )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(0), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(1), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(2), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(3), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(4), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(5), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(6), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(7), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(8), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(9), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(10), "-votekick ", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_Votekick, Player(11), "-votekick ", false )
    call TriggerAddCondition( gg_trg_Votekick, Condition( function Trig_Votekick_Conditions ) )
    call TriggerAddAction( gg_trg_Votekick, function Trig_Votekick_Actions )
endfunction

