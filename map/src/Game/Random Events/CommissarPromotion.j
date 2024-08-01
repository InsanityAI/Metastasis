function Trig_CommissarPromotion_Func003Func001C takes nothing returns boolean 
    if(not(udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] == 8)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_CommissarPromotion_Func003A takes nothing returns nothing 
    if(Trig_CommissarPromotion_Func003Func001C()) then 
        set udg_TempBool = true 
        set udg_TempPlayer = GetEnumPlayer() 
    else 
    endif 
endfunction 

function Trig_CommissarPromotion_Func004Func009C takes nothing returns boolean 
    if((IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) == false)) then 
        return true 
    endif 
    if((udg_TempBool == false)) then 
        return true 
    endif 
    if((udg_TempPlayer == udg_Mutant)) then 
        return true 
    endif 
    if((udg_TempPlayer == udg_Parasite)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_CommissarPromotion_Func004C takes nothing returns boolean 
    if(not Trig_CommissarPromotion_Func004Func009C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_CommissarPromotion_Actions takes nothing returns nothing 
    local string name 
    set udg_RandomEvent_On[1] = true 
    set udg_TempBool = false 
    call ForForce(GetPlayersAll(), function Trig_CommissarPromotion_Func003A) 
    if(Trig_CommissarPromotion_Func004C()) then 
        call StartTimerBJ(udg_RandomEvent, false, 1.00) 
    else 
        call StartTimerBJ(udg_RandomEvent, false, GetRandomReal(180.00, 900.00)) 
        call DisplayTextToForce(GetPlayersAll(), (GetPlayerName(udg_TempPlayer) + " |cff00FF40has received a promotion!|r")) 
        call DisplayTextToPlayer(udg_TempPlayer, 0, 0, "|cffffcc00You have recieved the Operative suit. Thank you for your dedication to the United Security Initiative and the future of humanity.|r") 
        set udg_TempString = SubStringBJ(GetPlayerName(udg_TempPlayer), (StringLength(udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)]) + 1), 99) 
        set udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Rebarch " 
        set name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + udg_TempString 
        call SetPlayerName(udg_TempPlayer, name) 
        call StateGrid_SetPlayerName(udg_TempPlayer, name) 
        set ChatProfiles_getReal(udg_TempPlayer).name = PlayerColor_GetPlayerTextColor(udg_TempPlayer) + name + "|r"
        call UnitAddItemByIdSwapped('I00X', udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_CommissarPromotion takes nothing returns nothing 
    set gg_trg_CommissarPromotion = CreateTrigger() 
    call DisableTrigger(gg_trg_CommissarPromotion) 
    call TriggerAddAction(gg_trg_CommissarPromotion, function Trig_CommissarPromotion_Actions) 
endfunction 

