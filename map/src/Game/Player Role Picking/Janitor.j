function Trig_Janitor_Func001Func002Func002C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_HiddenAndroid)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Janitor_Func001Func002C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_Mutant)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Janitor_Func001C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_Parasite)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Janitor_Actions takes nothing returns nothing 
    local string name 
    if(Trig_Janitor_Func001C()) then 
        call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5350") 
    else 
        if(Trig_Janitor_Func001Func002C()) then 
            call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5352") 
        else 
            if(Trig_Janitor_Func001Func002Func002C()) then 
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5327") 
            else 
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5351") 
            endif 
        endif 
    endif 
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r") 
    call UnitAddItemByIdSwapped('I00J', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) 
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Janitor " 
    set name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) 
    call SetPlayerName(udg_TempPlayer, name) 
    call StateGrid_SetPlayerName(udg_TempPlayer, name) 
endfunction 

//=========================================================================== 
function InitTrig_Janitor takes nothing returns nothing 
    set gg_trg_Janitor = CreateTrigger() 
    call TriggerAddAction(gg_trg_Janitor, function Trig_Janitor_Actions) 
endfunction 

