function Trig_Researcher_Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Mutant ) ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Func001C takes nothing returns boolean
    if ( not ( udg_TempPlayer == udg_Parasite ) ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Func003C takes nothing returns boolean
    if ( not ( udg_TempInt == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Func004Func001Func001Func001Func006Func002C takes nothing returns boolean
    if ( ( udg_TempPlayer == udg_Mutant ) ) then
        return true
    endif
    if ( ( udg_TempPlayer == udg_Parasite ) ) then
        return true
    endif
    return false
endfunction

function Trig_Researcher_Func004Func001Func001Func001Func006C takes nothing returns boolean
    if ( not Trig_Researcher_Func004Func001Func001Func001Func006Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Func004Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Func004Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Func004Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Func004Func007Func002C takes nothing returns boolean
    if ( ( udg_TempPlayer == udg_Mutant ) ) then
        return true
    endif
    if ( ( udg_TempPlayer == udg_Parasite ) ) then
        return true
    endif
    return false
endfunction

function Trig_Researcher_Func004Func007C takes nothing returns boolean
    if ( not Trig_Researcher_Func004Func007Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Func004C takes nothing returns boolean
    if ( not ( udg_TempInt == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Researcher_Actions takes nothing returns nothing
    if ( Trig_Researcher_Func001C() ) then
        call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5338" )
    else
        if ( Trig_Researcher_Func001Func001C() ) then
            call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5337" )
        else
            if ( Trig_Researcher_Func001Func001Func001C() ) then
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5336" )
            else
                call DisplayTimedTextToPlayer( udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5329" )
            endif
        endif
    endif
    set udg_TempInt = GetRandomInt(1, 4)
    if ( Trig_Researcher_Func003C() ) then
        set udg_TempInt = GetRandomInt(1, 2)
    else
    endif
    if ( Trig_Researcher_Func004C() ) then
        call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff000080You have a PhD in Biology.|r")
        call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff008080You have 200% health regeneration!|r")
        set udg_Researcher_PhD[GetConvertedPlayerId(udg_TempPlayer)] = 4
        call SetPlayerTechResearchedSwap( 'R006', 1, udg_TempPlayer )
        if ( Trig_Researcher_Func004Func007C() ) then
            call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cffFF0000This only applies while you are human.|r")
        else
        endif
    else
        if ( Trig_Researcher_Func004Func001C() ) then
            call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff000080You have a PhD in Electronics.|r")
            call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff008080Sentries and force shields built by you gain 50 health!|r")
            set udg_Researcher_PhD[GetConvertedPlayerId(udg_TempPlayer)] = 3
        else
            if ( Trig_Researcher_Func004Func001Func001C() ) then
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff000080You have a PhD in Gravitational Effects.|r")
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff008080Ships under your control move 10% faster!|r")
                set udg_Researcher_PhD[GetConvertedPlayerId(udg_TempPlayer)] = 2
                call SetPlayerTechResearchedSwap( 'R007', 1, udg_TempPlayer )
            else
                if ( Trig_Researcher_Func004Func001Func001Func001C() ) then
                    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff000080You have a PhD in Optics!|r")
                    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff008080You have extra sight range!|r")
                    set udg_Researcher_PhD[GetConvertedPlayerId(udg_TempPlayer)] = 1
                    call SetPlayerTechResearchedSwap( 'R008', 1, udg_TempPlayer )
                    if ( Trig_Researcher_Func004Func001Func001Func001Func006C() ) then
                        call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cffFF0000This only applies while you are human.|r")
                    else
                    endif
                else
                endif
            endif
        endif
    endif
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
    call UnitAddItemByIdSwapped( 'I025', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
    call UnitAddItemByIdSwapped( 'I002', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] )
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Dr. "
    call SetPlayerName( udg_TempPlayer, ( udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) ) )
endfunction

//===========================================================================
function InitTrig_Researcher takes nothing returns nothing
    set gg_trg_Researcher = CreateTrigger(  )
    call TriggerAddAction( gg_trg_Researcher, function Trig_Researcher_Actions )
endfunction

