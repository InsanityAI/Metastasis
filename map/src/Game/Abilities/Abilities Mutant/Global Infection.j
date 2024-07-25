function Trig_Global_Infection_Func002C takes nothing returns boolean 
    if((udg_Mutant == GetOwningPlayer(GetTriggerUnit()))) then 
        return true 
    endif 
    if((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == true)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_Global_Infection_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A067')) then 
        return false 
    endif 
    if(not Trig_Global_Infection_Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Global_Infection_Func005Func001Func001Func005C takes nothing returns boolean 
    if((udg_Mutant == GetOwningPlayer(GetEnumUnit()))) then 
        return true 
    endif 
    if((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == true)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_Global_Infection_Func005Func001Func001C takes nothing returns boolean 
    if(not Trig_Global_Infection_Func005Func001Func001Func005C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Global_Infection_Func005Func001Func002C takes nothing returns boolean 
    if((GetUnitRace(GetEnumUnit()) == RACE_ORC)) then 
        return true 
    endif 
    if((GetUnitRace(GetEnumUnit()) == RACE_UNDEAD)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_Global_Infection_Func005Func001C takes nothing returns boolean 
    if(not Trig_Global_Infection_Func005Func001Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Global_Infection_Func005A takes nothing returns nothing 
    if(Trig_Global_Infection_Func005Func001C()) then 
        if(Trig_Global_Infection_Func005Func001Func001C()) then 
        else 
            set udg_TempLoc3 = GetUnitLoc(GetEnumUnit()) 
            call CreateNUnitsAtLoc(1, 'e03H', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempLoc3, bj_CAMERA_DEFAULT_ROLL) 
            call UnitApplyTimedLifeBJ(2.00, 'BTLF', GetLastCreatedUnit()) 
            call IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", GetEnumUnit()) 
        endif 
    else 
    endif 
endfunction 

function Trig_Global_Infection_Actions takes nothing returns nothing 
    set udg_Global_Infection_group = GetUnitsInRectAll(GetPlayableMapRect()) 
    call ForGroupBJ(udg_Global_Infection_group, function Trig_Global_Infection_Func005A) 
    call GroupRemoveGroup(udg_Global_Infection_group, udg_Global_Infection_group) 
    call DestroyGroup(udg_Global_Infection_group) 
    call RemoveLocation(udg_TempLoc3) 
endfunction 

//=========================================================================== 
function InitTrig_Global_Infection takes nothing returns nothing 
    set gg_trg_Global_Infection = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Global_Infection, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Global_Infection, Condition(function Trig_Global_Infection_Conditions)) 
    call TriggerAddAction(gg_trg_Global_Infection, function Trig_Global_Infection_Actions) 
endfunction 

