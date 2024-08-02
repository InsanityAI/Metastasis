function Trig_Medic_Func001Func002Func002C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_HiddenAndroid)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Medic_Func001Func002C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_Mutant)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Medic_Func001C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_Parasite)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Medic_Actions takes nothing returns nothing 
    local string name 
    if(Trig_Medic_Func001C()) then 
        call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5368") 
    else 
        if(Trig_Medic_Func001Func002C()) then 
            call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5369") 
        else 
            if(Trig_Medic_Func001Func002Func002C()) then 
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5370") 
            else 
                call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5371") 
            endif 
        endif 
    endif 
    call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r") 
    call UnitAddItemByIdSwapped('I00L', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) 
    call UnitAddItemByIdSwapped('I002', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) 
    call UnitAddItemByIdSwapped('I00M', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) 
    set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Medic " 
    set name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer) 
    set ChatProfiles_getReal(udg_TempPlayer).name = PlayerColor_GetPlayerTextColor(udg_TempPlayer) + name + "|r"
    call SetPlayerName(udg_TempPlayer, name) 
    call StateGrid_SetPlayerName(udg_TempPlayer, name) 
endfunction 

//=========================================================================== 
function InitTrig_Medic takes nothing returns nothing 
    set gg_trg_Medic = CreateTrigger() 
    call TriggerAddAction(gg_trg_Medic, function Trig_Medic_Actions) 
endfunction 

