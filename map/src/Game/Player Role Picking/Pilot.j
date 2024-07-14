function Trig_Pilot_Func001Func002Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_Pilot_Func001Func002C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Mutant ) ) then
        return false
    endif
    return true
endfunction

function Trig_Pilot_Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Parasite ) ) then
        return false
    endif
    return true
endfunction

function Trig_Pilot_Func006Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Pilot_Func006Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Pilot_Func006C takes nothing returns boolean
    if ( not ( udg_TempInt == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Pilot_Actions takes nothing returns nothing
    local string name
    if ( Trig_Pilot_Func001C() ) then
        call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5343" )
    else
        if ( Trig_Pilot_Func001Func002C() ) then
            call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5345" )
        else
            if ( Trig_Pilot_Func001Func002Func001C() ) then
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5325" )
            else
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5344" )
            endif
        endif
    endif
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Ace "
    set udg_InitialSpawnPoint[GetConvertedPlayerId(udg_TempPlayer)] = Location(-2252.00, 14431.00)
    set name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) 
    call SetPlayerName( udg_TempPlayer, name)
    call StateGrid_SetPlayerName(udg_TempPlayer, name)
    if ( Trig_Pilot_Func006C() ) then
        call UnitAddItemByIdSwapped( 'I008', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
    else
        if ( Trig_Pilot_Func006Func001C() ) then
            call UnitAddItemByIdSwapped( 'I001', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
        else
            if ( Trig_Pilot_Func006Func001Func001C() ) then
                call UnitAddItemByIdSwapped( 'I000', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
            else
                call UnitAddItemByIdSwapped( 'I007', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
            endif
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Pilot takes nothing returns nothing
    set gg_trg_Pilot = CreateTrigger(  )
    call TriggerAddAction( gg_trg_Pilot, function Trig_Pilot_Actions )
endfunction

