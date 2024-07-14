function Trig_ST8Attack_Conditions takes nothing returns boolean
    if ( not ( GetEventDamage() >= 1.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST8Attack_Func004C takes nothing returns boolean
    if ( not ( udg_ST8_TakingDamage == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST8Attack_Func007Func001Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST8Attack_Func007Func001C takes nothing returns boolean
    if ( not ( GetEnumUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] ) ) then
        return false
    endif
    if ( not ( udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST8Attack_Func007A takes nothing returns nothing
    if ( Trig_ST8Attack_Func007Func001C() ) then
        if ( Trig_ST8Attack_Func007Func001Func001C() ) then
            call ForceAddPlayerSimple( udg_Parasite, udg_ST8_PGroup )
            call CameraSetEQNoiseForPlayer( udg_Parasite, 3 )
        else
            call ForceAddPlayerSimple( GetOwningPlayer(GetEnumUnit()), udg_ST8_PGroup )
            call CameraSetEQNoiseForPlayer( GetOwningPlayer(GetEnumUnit()), 3 )
        endif
    else
    endif
endfunction

function Trig_ST8Attack_Func008A takes nothing returns nothing
    call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 5.00, "|cffFF0000Calipea station under attack!|r")
endfunction

function Trig_ST8Attack_Func010Func001C takes nothing returns boolean
    if ( not ( udg_Player_TetrabinLevel[GetConvertedPlayerId(GetEnumPlayer())] == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST8Attack_Func010A takes nothing returns nothing
    if ( Trig_ST8Attack_Func010Func001C() ) then
        call CameraClearNoiseForPlayer( GetEnumPlayer() )
    else
    endif
endfunction

function Trig_ST8Attack_Actions takes nothing returns nothing
    call DisableTrigger( GetTriggeringTrigger() )
    if ( Trig_ST8Attack_Func004C() ) then
        call SetStackedSoundBJ( true, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST8 )
        set udg_ST8_TakingDamage = true
    else
    endif
    call StartTimerBJ( udg_ST8_ResetAlarm, false, 10.00 )
    call ForceClear( udg_ST8_PGroup )
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_ST8), function Trig_ST8Attack_Func007A )
    call ForForce( udg_ST8_PGroup, function Trig_ST8Attack_Func008A )
    call PolledWait( 5.00 )
    call ForForce( udg_ST8_PGroup, function Trig_ST8Attack_Func010A )
    call EnableTrigger( gg_trg_ST8Attack )
endfunction

//===========================================================================
function InitTrig_ST8Attack takes nothing returns nothing
    set gg_trg_ST8Attack = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_ST8Attack, gg_unit_h04E_0259, EVENT_UNIT_DAMAGED )
    call TriggerAddCondition( gg_trg_ST8Attack, Condition( function Trig_ST8Attack_Conditions ) )
    call TriggerAddAction( gg_trg_ST8Attack, function Trig_ST8Attack_Actions )
endfunction

