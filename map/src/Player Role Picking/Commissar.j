function Trig_Commissar_Func001Func002Func002C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_Commissar_Func001Func002C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Mutant ) ) then
        return false
    endif
    return true
endfunction

function Trig_Commissar_Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Parasite ) ) then
        return false
    endif
    return true
endfunction

function Trig_Commissar_Actions takes nothing returns nothing
    if ( Trig_Commissar_Func001C() ) then
        call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5357" )
    else
        if ( Trig_Commissar_Func001Func002C() ) then
            call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5358" )
        else
            if ( Trig_Commissar_Func001Func002Func002C() ) then
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5324" )
            else
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5359" )
            endif
        endif
    endif
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
    call UnitAddItemByIdSwapped( 'I00G', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Commissar "
    call SetPlayerName( udg_TempPlayer, ( udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) ) )
endfunction

//===========================================================================
function InitTrig_Commissar takes nothing returns nothing
    set gg_trg_Commissar = CreateTrigger(  )
    call TriggerAddAction( gg_trg_Commissar, function Trig_Commissar_Actions )
endfunction

