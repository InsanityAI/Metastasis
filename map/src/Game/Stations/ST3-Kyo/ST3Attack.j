function Trig_ST3Attack_Conditions takes nothing returns boolean
    if ( not ( GetEventDamage() >= 1.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Attack_Func004C takes nothing returns boolean
    if ( not ( udg_ST3_TakingDamage == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Attack_Func007Func001Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Attack_Func007Func001C takes nothing returns boolean
    if ( not ( GetEnumUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] ) ) then
        return false
    endif
    if ( not ( udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Attack_Func007A takes nothing returns nothing
    if ( Trig_ST3Attack_Func007Func001C() ) then
        if ( Trig_ST3Attack_Func007Func001Func001C() ) then
            call ForceAddPlayerSimple( udg_Parasite, udg_ST3_PGroup )
            call CameraSetEQNoiseForPlayer( udg_Parasite, 3 )
        else
            call ForceAddPlayerSimple( GetOwningPlayer(GetEnumUnit()), udg_ST3_PGroup )
            call CameraSetEQNoiseForPlayer( GetOwningPlayer(GetEnumUnit()), 3 )
        endif
    else
    endif
endfunction

function Trig_ST3Attack_Func008A takes nothing returns nothing
    call DisplayTimedTextToPlayer( GetEnumPlayer(), 0, 0, 5.00, "TRIGSTR_5333" )
endfunction

function Trig_ST3Attack_Func010Func001C takes nothing returns boolean
    if ( not ( udg_Player_TetrabinLevel[GetConvertedPlayerId(GetEnumPlayer())] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Attack_Func010A takes nothing returns nothing
    if ( Trig_ST3Attack_Func010Func001C() ) then
        call CameraClearNoiseForPlayer( GetEnumPlayer() )
    else
    endif
endfunction

function Trig_ST3Attack_Actions takes nothing returns nothing
    call DisableTrigger( GetTriggeringTrigger() )
    if ( Trig_ST3Attack_Func004C() ) then
        call SetStackedSoundBJ( true, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST3 )
        set udg_ST3_TakingDamage = true
    else
    endif
    call StartTimerBJ( udg_ST3_ResetAlarm, false, 10.00 )
    call ForceClear( udg_ST3_PGroup )
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_ST3), function Trig_ST3Attack_Func007A )
    call ForForce( udg_ST3_PGroup, function Trig_ST3Attack_Func008A )
    call PolledWait( 5.00 )
    call ForForce( udg_ST3_PGroup, function Trig_ST3Attack_Func010A )
    call EnableTrigger( gg_trg_ST3Attack )
endfunction

//===========================================================================
function InitTrig_ST3Attack takes nothing returns nothing
    set gg_trg_ST3Attack = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_ST3Attack, gg_unit_h007_0027, EVENT_UNIT_DAMAGED )
    call TriggerAddCondition( gg_trg_ST3Attack, Condition( function Trig_ST3Attack_Conditions ) )
    call TriggerAddAction( gg_trg_ST3Attack, function Trig_ST3Attack_Actions )
endfunction

