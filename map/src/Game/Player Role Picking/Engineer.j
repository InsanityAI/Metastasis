function Trig_Engineer_Func001Func002Func002C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_HiddenAndroid)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Engineer_Func001Func002C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_Mutant)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Engineer_Func001C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_Parasite)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Engineer_Func007C takes nothing returns boolean 
    if(not(udg_ExtraStation == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Engineer_Actions takes nothing returns nothing 
    local string name 
    if(Trig_Engineer_Func001C()) then 
        call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5360") 
    else 
        if(Trig_Engineer_Func001Func002C()) then 
            call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5361") 
        else 
            if(Trig_Engineer_Func001Func002Func002C()) then 
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5362") 
            else 
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5363") 
            endif 
        endif 
    endif 
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r") 
    call UnitAddItemByIdSwapped('I00B', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) 
    call UnitAddItemByIdSwapped('I00H', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) 
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Engineer " 
    set name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) 
    call SetPlayerName(udg_TempPlayer, name) 
    call StateGrid_SetPlayerName(udg_TempPlayer, name) 
    if(Trig_Engineer_Func007C()) then 
        set udg_InitialSpawnPoint[GetConvertedPlayerId(udg_TempPlayer)] = Location(-6016.00, 11980.00) 
        set udg_EngineerUsed = true 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Engineer takes nothing returns nothing 
    set gg_trg_Engineer = CreateTrigger() 
    call TriggerAddAction(gg_trg_Engineer, function Trig_Engineer_Actions) 
endfunction 

