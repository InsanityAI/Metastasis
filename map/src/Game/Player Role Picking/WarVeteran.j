function Trig_WarVeteran_Func001Func002Func002C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_WarVeteran_Func001Func002C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Mutant ) ) then
        return false
    endif
    return true
endfunction

function Trig_WarVeteran_Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Parasite ) ) then
        return false
    endif
    return true
endfunction

function Trig_WarVeteran_Actions takes nothing returns nothing
    local string name
    if ( Trig_WarVeteran_Func001C() ) then
        call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5364" )
    else
        if ( Trig_WarVeteran_Func001Func002C() ) then
            call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5365" )
        else
            if ( Trig_WarVeteran_Func001Func002Func002C() ) then
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5366" )
            else
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5367" )
            endif
        endif
    endif
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
    call UnitAddItemByIdSwapped( 'I00F', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Corporal "
    set name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) 
    call SetPlayerName( udg_TempPlayer, name)
    call StateGrid_SetPlayerName(udg_TempPlayer, name)
endfunction

//===========================================================================
function InitTrig_WarVeteran takes nothing returns nothing
    set gg_trg_WarVeteran = CreateTrigger(  )
    call TriggerAddAction( gg_trg_WarVeteran, function Trig_WarVeteran_Actions )
endfunction

