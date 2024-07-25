function Trig_Captain_Func001Func001Func001C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_HiddenAndroid)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Captain_Func001Func001C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_Mutant)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Captain_Func001C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_Parasite)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Captain_Actions takes nothing returns nothing 
    local string name 
    if(Trig_Captain_Func001C()) then 
        call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 10, "TRIGSTR_5349") 
    else 
        if(Trig_Captain_Func001Func001C()) then 
            call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5348") 
        else 
            if(Trig_Captain_Func001Func001Func001C()) then 
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5346") 
            else 
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5347") 
            endif 
        endif 
    endif 
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r") 
    call UnitAddItemByIdSwapped('I00I', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) 
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Captain " 
    set udg_InitialSpawnPoint[GetConvertedPlayerId(udg_TempPlayer)] = Location(-14714.00, -13302.00) 
    set name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) 
    call SetPlayerName(udg_TempPlayer, name) 
    call StateGrid_SetPlayerName(udg_TempPlayer, name) 
endfunction 

//=========================================================================== 
function InitTrig_Captain takes nothing returns nothing 
    set gg_trg_Captain = CreateTrigger() 
    call TriggerAddAction(gg_trg_Captain, function Trig_Captain_Actions) 
endfunction 

