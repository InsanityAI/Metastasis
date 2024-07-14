function Trig_AntiShareControl_Func002Func001Func001Func003C takes nothing returns boolean
    if ( ( GetPlayerAlliance(ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), ALLIANCE_SHARED_CONTROL) == true ) ) then
        return true
    endif
    if ( ( GetPlayerAlliance(ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL) == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_AntiShareControl_Func002Func001Func001Func005C takes nothing returns boolean
    if ( not ( ConvertedPlayer(GetForLoopIndexA()) == udg_Parasite ) ) then
        return false
    endif
    return true
endfunction

function Trig_AntiShareControl_Func002Func001Func001C takes nothing returns boolean
    if ( not ( ConvertedPlayer(GetForLoopIndexA()) != GetEnumPlayer() ) ) then
        return false
    endif
    if ( not ( GetEnumPlayer() != Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    if ( not Trig_AntiShareControl_Func002Func001Func001Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_AntiShareControl_Func002A takes nothing returns nothing
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 12
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_AntiShareControl_Func002Func001Func001C() ) then
            call SetPlayerAllianceStateBJ( ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), bj_ALLIANCE_ALLIED )
            if ( Trig_AntiShareControl_Func002Func001Func001Func005C() ) then
                call SetPlayerAllianceStateBJ( Player(bj_PLAYER_NEUTRAL_EXTRA), GetEnumPlayer(), bj_ALLIANCE_ALLIED )
            else
            endif
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

function Trig_AntiShareControl_Actions takes nothing returns nothing
    call ForForce( GetPlayersAll(), function Trig_AntiShareControl_Func002A )
endfunction

//===========================================================================
function InitTrig_AntiShareControl takes nothing returns nothing
    set gg_trg_AntiShareControl = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_AntiShareControl, 2 )
    call TriggerAddAction( gg_trg_AntiShareControl, function Trig_AntiShareControl_Actions )
endfunction

