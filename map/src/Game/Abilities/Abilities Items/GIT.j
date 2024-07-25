function Trig_GIT_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A018')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GIT_Func004Func001C takes nothing returns boolean 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h00B')) then 
        return true 
    endif 
    if((IsPlayerInForce(GetOwningPlayer(GetSpellTargetUnit()), udg_GIT_TesterGroup[GetItemUserData(udg_TempItem)]) == true)) then 
        return true 
    endif 
    if((udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] != GetSpellTargetUnit())) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_GIT_Func004Func005Func001Func003C takes nothing returns boolean 
    if((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == true)) then 
        return true 
    endif 
    if((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == true)) then 
        return true 
    endif 
    if((GetOwningPlayer(GetSpellTargetUnit()) == udg_Parasite)) then 
        return true 
    endif 
    if((GetOwningPlayer(GetSpellTargetUnit()) == udg_Mutant)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_GIT_Func004Func005Func001C takes nothing returns boolean 
    if(not Trig_GIT_Func004Func005Func001Func003C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GIT_Func004C takes nothing returns boolean 
    if(not Trig_GIT_Func004Func001C()) then 
        return false 
    endif 
    return true 
endfunction 


function Trig_GIT_Actions takes nothing returns nothing 
    set udg_TempItem = GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I00M') 
    if(GetItemUserData(udg_TempItem) == 0) then 
        set udg_GIT_TesterOn = (udg_GIT_TesterOn + 1) 
        call SetItemUserData(udg_TempItem, udg_GIT_TesterOn) 
        set udg_GIT_TesterGroup[GetItemUserData(udg_TempItem)] = CreateForce() 
        set udg_GIT_TesterStatus[GetItemUserData(udg_TempItem)] = 1 
    endif 
    if(Trig_GIT_Func004C()) then 
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 5.00, "TRIGSTR_3178") 
        call SetItemCharges(udg_TempItem, (GetItemCharges(udg_TempItem) + 1)) 
    else 
        call ForceAddPlayerSimple(GetOwningPlayer(GetSpellTargetUnit()), udg_GIT_TesterGroup[GetItemUserData(udg_TempItem)]) 
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 5.00, "TRIGSTR_3177") 
        set udg_GIT_TesterString[GetItemUserData(udg_TempItem)] = (udg_GIT_TesterString[GetItemUserData(udg_TempItem)] + (GetPlayerName(GetOwningPlayer(GetSpellTargetUnit())) + "\n")) 
        if(udg_GIT_TesterStatus[GetItemUserData(udg_TempItem)] != 3) then 
            if(Trig_GIT_Func004Func005Func001C()) then 
                set udg_GIT_TesterStatus[GetItemUserData(udg_TempItem)] = 2 
            else 
                if(GetOwningPlayer(GetSpellTargetUnit()) == udg_HiddenAndroid) then 
                    set udg_GIT_TesterStatus[GetItemUserData(udg_TempItem)] = 3 
                endif 
            endif 
        endif 
    endif 
    if(GetItemCharges(udg_TempItem) <= 1) then 
        set udg_TempInt = GetItemUserData(udg_TempItem) 
        call RemoveItem(udg_TempItem) 
        call CreateItemLoc('I019', udg_HoldZone) 
        call UnitAddItemByIdSwapped('I019', GetTriggerUnit()) 
        call SetItemUserData(GetLastCreatedItem(), udg_TempInt) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_GIT takes nothing returns nothing 
    set gg_trg_GIT = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_GIT, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_GIT, Condition(function Trig_GIT_Conditions)) 
    call TriggerAddAction(gg_trg_GIT, function Trig_GIT_Actions) 
endfunction 

