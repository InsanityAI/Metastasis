function Trig_ListMutants_Func001C takes nothing returns boolean
    if ( ( udg_Mutant == GetTriggerPlayer() ) ) then
        return true
    endif
    if ( ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetTriggerPlayer())] == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_ListMutants_Conditions takes nothing returns boolean
    if ( not Trig_ListMutants_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_ListMutants_Func015Func001Func002C takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ListMutants_Func015Func001C takes nothing returns boolean
    if ( not ( udg_Player_IsMutantSpawn[GetForLoopIndexA()] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ListMutants_Func015Func002Func002C takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ListMutants_Func015Func002C takes nothing returns boolean
    if ( not ( udg_Mutant == ConvertedPlayer(GetForLoopIndexA()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ListMutants_Actions takes nothing returns nothing
    set udg_TempPlayerGroup = GetForceOfPlayer(GetTriggerPlayer())
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 12
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_ListMutants_Func015Func001C() ) then
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30, udg_ColorCode[GetForLoopIndexA()] + GetPlayerName(ConvertedPlayer(GetForLoopIndexA())) + "|r (|cffffcc00Spawn|r)")
            if ( Trig_ListMutants_Func015Func001Func002C() ) then
                set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetForLoopIndexA()])
                call PingMinimapLocForForceEx( udg_TempPlayerGroup, udg_TempPoint, 5.00, bj_MINIMAPPINGSTYLE_SIMPLE, ( I2R(udg_ColorCodesRed[( GetConvertedPlayerId(GetEnumPlayer()) - 1 )]) / 2.55 ), ( I2R(udg_ColorCodesGreen[( GetConvertedPlayerId(GetEnumPlayer()) - 1 )]) / 2.55 ), ( I2R(udg_ColorCodesBlue[( GetConvertedPlayerId(GetEnumPlayer()) - 1 )]) / 2.55 ) )
                call RemoveLocation(udg_TempPoint)
            else
            endif
        else
        endif
        if ( Trig_ListMutants_Func015Func002C() ) then
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30, udg_ColorCode[GetForLoopIndexA()] + GetPlayerName(ConvertedPlayer(GetForLoopIndexA())) + "|r (|cffffcc00Overlord|r)")
            if ( Trig_ListMutants_Func015Func002Func002C() ) then
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
function InitTrig_ListMutants takes nothing returns nothing
    set gg_trg_ListMutants = CreateTrigger(  )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(0), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(1), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(2), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(3), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(4), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(5), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(6), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(7), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(8), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(9), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(10), "-listmutants", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ListMutants, Player(11), "-listmutants", true )
    call TriggerAddCondition( gg_trg_ListMutants, Condition( function Trig_ListMutants_Conditions ) )
    call TriggerAddAction( gg_trg_ListMutants, function Trig_ListMutants_Actions )
endfunction

