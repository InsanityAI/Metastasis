function Trig_CEO_Func001Func002Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_CEO_Func001Func002C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Mutant ) ) then
        return false
    endif
    return true
endfunction

function Trig_CEO_Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Parasite ) ) then
        return false
    endif
    return true
endfunction

function Trig_CEO_Actions takes nothing returns nothing
    local string name
    if ( Trig_CEO_Func001C() ) then
        call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5339" )
    else
        if ( Trig_CEO_Func001Func002C() ) then
            call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5342" )
        else
            if ( Trig_CEO_Func001Func002Func001C() ) then
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5340" )
            else
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5341" )
            endif
        endif
    endif
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "CEO "
    set name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) 
    call SetPlayerName( udg_TempPlayer, name)
    call StateGrid_SetPlayerName(udg_TempPlayer, name)
    call CreateNUnitsAtLoc( 1, 'H046', udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING )
    set udg_TempUnit = GetLastCreatedUnit()
    set udg_TempUnit2 = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]
    call ExecuteFunc("RoboButler")
endfunction

//===========================================================================
function InitTrig_CEO takes nothing returns nothing
    set gg_trg_CEO = CreateTrigger(  )
    call TriggerAddAction( gg_trg_CEO, function Trig_CEO_Actions )
endfunction

