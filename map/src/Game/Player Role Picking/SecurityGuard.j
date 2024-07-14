function Trig_SecurityGuard_Func001Func002Func002C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_SecurityGuard_Func001Func002C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Mutant ) ) then
        return false
    endif
    return true
endfunction

function Trig_SecurityGuard_Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Parasite ) ) then
        return false
    endif
    return true
endfunction

function Trig_SecurityGuard_Func006Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SecurityGuard_Func006Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SecurityGuard_Func006C takes nothing returns boolean
    if ( not ( udg_TempInt == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SecurityGuard_Actions takes nothing returns nothing
    local string name
    if ( Trig_SecurityGuard_Func001C() ) then
        call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5353" )
    else
        if ( Trig_SecurityGuard_Func001Func002C() ) then
            call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5354" )
        else
            if ( Trig_SecurityGuard_Func001Func002Func002C() ) then
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5355" )
            else
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5356" )
            endif
        endif
    endif
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
    call SetPlayerTechResearchedSwap( 'R000', 1, udg_TempPlayer )
    set udg_TempInt = GetRandomInt(1, 4)
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Private "
    if ( Trig_SecurityGuard_Func006C() ) then
        call UnitAddItemByIdSwapped( 'I008', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
    else
        if ( Trig_SecurityGuard_Func006Func001C() ) then
            call UnitAddItemByIdSwapped( 'I001', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
        else
            if ( Trig_SecurityGuard_Func006Func001Func001C() ) then
                call UnitAddItemByIdSwapped( 'I000', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
            else
                call UnitAddItemByIdSwapped( 'I007', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
            endif
        endif
    endif
    set name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) 
    call SetPlayerName( udg_TempPlayer, name)
    call StateGrid_SetPlayerName(udg_TempPlayer, name)
endfunction

//===========================================================================
function InitTrig_SecurityGuard takes nothing returns nothing
    set gg_trg_SecurityGuard = CreateTrigger(  )
    call TriggerAddAction( gg_trg_SecurityGuard, function Trig_SecurityGuard_Actions )
endfunction

