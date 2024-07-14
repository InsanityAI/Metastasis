function Trig_BnetNames_Conditions takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_BnetNames_Func014Func001C takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_BnetNames_Func014A takes nothing returns nothing
    if ( Trig_BnetNames_Func014Func001C() ) then
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, udg_ColorCode[GetConvertedPlayerId(GetEnumPlayer())] + "(DEAD)" + "|r: " + udg_Player_OriginalName[GetConvertedPlayerId(GetEnumPlayer())])
    else
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, udg_ColorCode[GetConvertedPlayerId(GetEnumPlayer())] + GetPlayerName(GetEnumPlayer()) + "|r: " + udg_Player_OriginalName[GetConvertedPlayerId(GetEnumPlayer())])
    endif
endfunction

function Trig_BnetNames_Actions takes nothing returns nothing
    call ForForce( GetPlayersAll(), function Trig_BnetNames_Func014A )
endfunction

//===========================================================================
function InitTrig_BnetNames takes nothing returns nothing
    set gg_trg_BnetNames = CreateTrigger(  )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(0), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(1), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(2), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(3), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(4), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(5), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(6), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(7), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(8), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(9), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(10), "-names", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_BnetNames, Player(11), "-names", true )
    call TriggerAddCondition( gg_trg_BnetNames, Condition( function Trig_BnetNames_Conditions ) )
    call TriggerAddAction( gg_trg_BnetNames, function Trig_BnetNames_Actions )
endfunction

