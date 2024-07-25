function Trig_CryoShock_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A00I')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_CryoShock_Func007Func001C takes nothing returns boolean 
    if(not(GetEnumUnit() != udg_TempUnit3)) then 
        return false 
    endif 
    if(not(GetUnitTypeId(GetEnumUnit()) != 'H03I')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_CryoShock_Func007A takes nothing returns nothing 
    if(Trig_CryoShock_Func007Func001C()) then 
        set udg_TempPoint = GetUnitLoc(GetEnumUnit()) 
        call CreateNUnitsAtLoc(1, 'e01L', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING) 
        call IssuePointOrderLocBJ(GetLastCreatedUnit(), "silence", udg_TempPoint) 
        call RemoveLocation(udg_TempPoint) 
    else 
    endif 
endfunction 

function Trig_CryoShock_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempUnitGroup = GetUnitsInRangeOfLocAll(450.00, udg_TempPoint) 
    set udg_TempUnit3 = GetSpellAbilityUnit() 
    call RemoveLocation(udg_TempPoint) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_CryoShock_Func007A) 
    call DestroyGroup(udg_TempUnitGroup) 
endfunction 

//=========================================================================== 
function InitTrig_CryoShock takes nothing returns nothing 
    set gg_trg_CryoShock = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_CryoShock, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_CryoShock, Condition(function Trig_CryoShock_Conditions)) 
    call TriggerAddAction(gg_trg_CryoShock, function Trig_CryoShock_Actions) 
endfunction 

