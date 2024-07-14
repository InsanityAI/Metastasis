function Trig_ListAliens_Func001C takes nothing returns boolean
    if ( ( udg_Parasite == GetTriggerPlayer() ) ) then
        return true
    endif
    if ( ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetTriggerPlayer())] == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_ListAliens_Conditions takes nothing returns boolean
    if ( not Trig_ListAliens_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_ListAliens_Func015Func001Func002C takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ListAliens_Func015Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsParasiteSpawn[GetForLoopIndexA()] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ListAliens_Func015Func002Func002C takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ListAliens_Func015Func002C takes nothing returns boolean
    if ( not ( udg_Parasite == ConvertedPlayer(GetForLoopIndexA()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ListAliens_Actions takes nothing returns nothing
    set udg_TempPlayerGroup = GetForceOfPlayer(GetTriggerPlayer())
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 12
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_ListAliens_Func015Func001C() ) then
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30, udg_ColorCode[GetForLoopIndexA()] + GetPlayerName(ConvertedPlayer(GetForLoopIndexA())) + "|r (|cffffcc00Spawn|r)")
            if ( Trig_ListAliens_Func015Func001Func002C() ) then
                set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetForLoopIndexA()])
                call PingMinimapLocForForceEx( udg_TempPlayerGroup, udg_TempPoint, 5.00, bj_MINIMAPPINGSTYLE_SIMPLE, ( I2R(udg_ColorCodesRed[( GetConvertedPlayerId(GetEnumPlayer()) - 1 )]) / 2.55 ), ( I2R(udg_ColorCodesGreen[( GetConvertedPlayerId(GetEnumPlayer()) - 1 )]) / 2.55 ), ( I2R(udg_ColorCodesBlue[( GetConvertedPlayerId(GetEnumPlayer()) - 1 )]) / 2.55 ) )
                call RemoveLocation(udg_TempPoint)
            else
            endif
        else
        endif
        if ( Trig_ListAliens_Func015Func002C() ) then
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30, udg_ColorCode[GetForLoopIndexA()] + GetPlayerName(ConvertedPlayer(GetForLoopIndexA())) + "|r (|cffffcc00Overlord|r)")
            if ( Trig_ListAliens_Func015Func002Func002C() ) then
                set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetForLoopIndexA()])
                call PingMinimapLocForForceEx( udg_TempPlayerGroup, udg_TempPoint, 5.00, bj_MINIMAPPINGSTYLE_SIMPLE, ( I2R(udg_ColorCodesRed[( GetConvertedPlayerId(GetEnumPlayer()) - 1 )]) / 2.55 ), ( I2R(udg_ColorCodesGreen[( GetConvertedPlayerId(GetEnumPlayer()) - 1 )]) / 2.55 ), ( I2R(udg_ColorCodesBlue[( GetConvertedPlayerId(GetEnumPlayer()) - 1 )]) / 2.55 ) )
                call RemoveLocation(udg_TempPoint)
            else
            endif
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call DestroyForce(udg_TempPlayerGroup)
endfunction

//===========================================================================
function InitTrig_ListAliens takes nothing returns nothing
    set gg_trg_ListAliens = CreateTrigger(  )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(0), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(1), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(2), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(3), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(4), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(5), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(6), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(7), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(8), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(9), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(10), "-listaliens", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListAliens, Player(11), "-listaliens", true )
    call TriggerAddCondition( gg_trg_ListAliens, Condition( function Trig_ListAliens_Conditions ) )
    call TriggerAddAction( gg_trg_ListAliens, function Trig_ListAliens_Actions )
endfunction

