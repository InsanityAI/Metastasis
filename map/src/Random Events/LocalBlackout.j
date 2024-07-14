function Trig_LocalBlackout_Func014A takes nothing returns nothing
    call FogModifierStop( udg_SpaceVisibility[GetConvertedPlayerId(GetEnumPlayer())] )
endfunction

function Trig_LocalBlackout_Func015Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnumUnit()) != 'h04G' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetEnumUnit()) != 'h031' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetEnumUnit()) != 'h032' ) ) then
        return false
    endif
    return true
endfunction

function Trig_LocalBlackout_Func015A takes nothing returns nothing
    if ( Trig_LocalBlackout_Func015Func001C() ) then
        call SetUnitOwner( GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true )
    else
    endif
endfunction

function Trig_LocalBlackout_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_On[13] = true
    call RemoveLocation(udg_TempPoint)
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_5195" )
    call PolledWait( 5.00 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2568" )
    call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(90.00, 1200.00) )
    call StartTimerBJ( udg_BlackoutTimer, false, GetRandomReal(60.00, 60.00) )
    call CreateTimerDialogBJ( GetLastCreatedTimerBJ(), "TRIGSTR_2569" )
    set udg_BlackoutTimerWindow = GetLastCreatedTimerDialogBJ()
    call TimerDialogDisplayBJ( true, udg_BlackoutTimerWindow )
    set udg_Blackout = true
    call PlaySoundBJ( gg_snd_Warning01 )
    call ForForce( GetPlayersAll(), function Trig_LocalBlackout_Func014A )
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_Space), function Trig_LocalBlackout_Func015A )
    call PolledWait( 1.50 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2572" )
    call PolledWait( 1.50 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2573" )
    call PolledWait( 1.50 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2574" )
    call PolledWait( 1.50 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2575" )
    call PolledWait( 3.00 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2947" )
    call PolledWait( 3.00 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2576" )
    call PolledWait( 7.00 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2577" )
    call PolledWait( 5.00 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2578" )
    call PolledWait( 10.00 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2579" )
    call PolledWait( 10.00 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2580" )
endfunction

//===========================================================================
function InitTrig_LocalBlackout takes nothing returns nothing
    set gg_trg_LocalBlackout = CreateTrigger(  )
    call DisableTrigger( gg_trg_LocalBlackout )
    call TriggerAddAction( gg_trg_LocalBlackout, function Trig_LocalBlackout_Actions )
endfunction

