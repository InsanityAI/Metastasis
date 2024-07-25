function Trig_AndroidRemote_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A05W')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func003C takes nothing returns boolean 
    if(not(GetItemUserData(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I01I')) != udg_AndroidRemoteID)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func005Func001Func001Func001C takes nothing returns boolean 
    if(not(udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then 
        return false 
    endif 
    if(not(GetOwningPlayer(GetSpellAbilityUnit()) != udg_Parasite)) then 
        return false 
    endif 
    if(not(GetOwningPlayer(GetSpellAbilityUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return false 
    endif 
    if(not(udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] != true)) then 
        return false 
    endif 
    if(not(GetOwningPlayer(GetSpellAbilityUnit()) != udg_Mutant)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func005Func001Func001Func002C takes nothing returns boolean 
    if((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] == true)) then 
        return true 
    endif 
    if((udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] == true)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_AndroidRemote_Func005Func001Func001Func007A takes nothing returns nothing 
    call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 7.00, "|cff800080Android successfully configured for HUMAN classification.|r") 
endfunction 

function Trig_AndroidRemote_Func005Func001Func001C takes nothing returns boolean 
    if(not Trig_AndroidRemote_Func005Func001Func001Func001C()) then 
        return false 
    endif 
    if(not Trig_AndroidRemote_Func005Func001Func001Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func005Func001Func007Func001Func002C takes nothing returns boolean 
    if((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetEnumPlayer())] == true)) then 
        return true 
    endif 
    if((GetEnumPlayer() == udg_Parasite)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_AndroidRemote_Func005Func001Func007Func001C takes nothing returns boolean 
    if(not Trig_AndroidRemote_Func005Func001Func007Func001Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func005Func001Func007A takes nothing returns nothing 
    if(Trig_AndroidRemote_Func005Func001Func007Func001C()) then 
        call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 7.00, "|cff800080Android successfully configured for ALIEN classification.|r") 
    else 
    endif 
endfunction 

function Trig_AndroidRemote_Func005Func001Func008C takes nothing returns boolean 
    if((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == true)) then 
        return true 
    endif 
    if((GetOwningPlayer(GetSpellAbilityUnit()) == udg_Parasite)) then 
        return true 
    endif 
    if((GetOwningPlayer(GetSpellAbilityUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_AndroidRemote_Func005Func001C takes nothing returns boolean 
    if(not(udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] == false)) then 
        return false 
    endif 
    if(not Trig_AndroidRemote_Func005Func001Func008C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func005Func007Func001Func002C takes nothing returns boolean 
    if((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetEnumPlayer())] == true)) then 
        return true 
    endif 
    if((GetOwningPlayer(GetEnumUnit()) == udg_Mutant)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_AndroidRemote_Func005Func007Func001C takes nothing returns boolean 
    if(not Trig_AndroidRemote_Func005Func007Func001Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func005Func007A takes nothing returns nothing 
    if(Trig_AndroidRemote_Func005Func007Func001C()) then 
        call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 7.00, "|cff800080Android successfully configured for MUTANT classification.|r") 
    else 
    endif 
endfunction 

function Trig_AndroidRemote_Func005Func008C takes nothing returns boolean 
    if((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == true)) then 
        return true 
    endif 
    if((GetOwningPlayer(GetSpellAbilityUnit()) == udg_Mutant)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_AndroidRemote_Func005C takes nothing returns boolean 
    if(not(udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] == false)) then 
        return false 
    endif 
    if(not Trig_AndroidRemote_Func005Func008C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func006Func001Func005A takes nothing returns nothing 
    call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true) 
endfunction 

function Trig_AndroidRemote_Func006Func001Func010Func001C takes nothing returns boolean 
    if(not(udg_EscapePod_Owner[GetUnitUserData(GetEnumUnit())] == udg_HiddenAndroid)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func006Func001Func010A takes nothing returns nothing 
    if(Trig_AndroidRemote_Func006Func001Func010Func001C()) then 
        call SetUnitOwner(GetEnumUnit(), udg_HiddenAndroid, true) 
    else 
    endif 
endfunction 

function Trig_AndroidRemote_Func006Func001C takes nothing returns boolean 
    if(not(udg_Android_Deactivated == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Func006C takes nothing returns boolean 
    if(not(udg_TempBool == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidRemote_Actions takes nothing returns nothing 
    if(Trig_AndroidRemote_Func003C()) then 
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 7.00, "|cff800080ERROR: Unit not responsive. Clearance code out of date; please find the newest remote.|r") 
        return 
    else 
    endif 
    set udg_TempBool = true 
    if(Trig_AndroidRemote_Func005C()) then 
        call DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00, "|cff800080New friendly classification: MUTANT|r") 
        set udg_TempBool = false 
        set udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = false 
        set udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = true 
        call ForForce(GetPlayersAll(), function Trig_AndroidRemote_Func005Func007A) 
    else 
        if(Trig_AndroidRemote_Func005Func001C()) then 
            call DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00, "|cff800080New friendly classification: ALIEN|r") 
            set udg_TempBool = false 
            set udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = true 
            set udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = false 
            call ForForce(GetPlayersAll(), function Trig_AndroidRemote_Func005Func001Func007A) 
        else 
            if(Trig_AndroidRemote_Func005Func001Func001C()) then 
                call DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00, "|cff800080New friendly classification: HUMAN|r") 
                set udg_TempBool = false 
                set udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = false 
                set udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = false 
                call ForForce(GetPlayersAll(), function Trig_AndroidRemote_Func005Func001Func001Func007A) 
            else 
            endif 
        endif 
    endif 
    if(Trig_AndroidRemote_Func006C()) then 
        if(Trig_AndroidRemote_Func006Func001C()) then 
            set udg_Android_Deactivated = false 
            call PauseUnitBJ(false, udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) 
            call DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 7.00, "|cff800080Android reactivated.|r") 
            call DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00, "|cff800080You have been reactivated.|r") 
            call ForGroupBJ(GetUnitsOfTypeIdAll('h02P'), function Trig_AndroidRemote_Func006Func001Func010A) 
        else 
            set udg_Android_Deactivated = true 
            call DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 7.00, "|cff800080Android deactivated.|r") 
            call PauseUnitBJ(true, udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) 
            call DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00, "|cff800080You have been deactivated.|r") 
            call ForGroupBJ(GetUnitsInRectOfPlayer(gg_rct_Space, udg_HiddenAndroid), function Trig_AndroidRemote_Func006Func001Func005A) 
        endif 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_AndroidRemote takes nothing returns nothing 
    set gg_trg_AndroidRemote = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AndroidRemote, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_AndroidRemote, Condition(function Trig_AndroidRemote_Conditions)) 
    call TriggerAddAction(gg_trg_AndroidRemote, function Trig_AndroidRemote_Actions) 
endfunction 

