function Trig_Mirror_start_Conditions takes nothing returns boolean 
    if(not(udg_Mirror_Enabled == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_start_Func006Func001C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetEnumUnit()) == 'H03I')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_start_Func006A takes nothing returns nothing 
    if(Trig_Mirror_start_Func006Func001C()) then 
    else 
        call CreateNUnitsAtLoc(1, GetUnitTypeId(GetEnumUnit()), Player(PLAYER_NEUTRAL_PASSIVE), GetRandomLocInRect(gg_rct_Mirror_Arena), bj_UNIT_FACING) 
        call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 1)), GetLastCreatedUnit()) 
        call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 2)), GetLastCreatedUnit()) 
        call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 3)), GetLastCreatedUnit()) 
        call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 4)), GetLastCreatedUnit()) 
        call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 5)), GetLastCreatedUnit()) 
        call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 6)), GetLastCreatedUnit()) 
        call GroupAddUnitSimple(GetLastCreatedUnit(), udg_Mirror_Hostilegroup) 
        // Cache the playerhero units, so as to exit when they are dead 
        if IsUnitPlayerhero(GetEnumUnit()) then 
            call GroupAddUnitSimple(GetLastCreatedUnit(), udg_Mirror_KillExitGroup) 
        endif 
    endif 
endfunction 

function Trig_Mirror_start_Func007Func001C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetEnumUnit()) == 'H03I')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_start_Func007A takes nothing returns nothing 
    if(Trig_Mirror_start_Func007Func001C()) then 
        call DisplayTextToPlayer(GetOwningPlayer(GetEnumUnit()), 0, 0, "|CFFE55BB0You have just intervened with yourself from an alternative dimension!\r
        \ r 
        Victory might bring you to U.S.I.Niffy ")
    else 
    endif 
endfunction 

function Trig_Mirror_start_Actions takes nothing returns nothing 
    call StartTimerBJ(udg_Mirror_Timer, false, 60.00) 
    call TriggerSleepAction(0.30) 
    set udg_Mirror_Enabled = true 
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Mirror_Arena) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_Mirror_start_Func006A) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_Mirror_start_Func007A) 
    call DestroyGroup(udg_TempUnitGroup) 
    call EnableTrigger(gg_trg_Mirror_relocation) 
    call EnableTrigger(gg_trg_Mirror_un_abuse) 
    call EnableTrigger(gg_trg_Mirror_A_I) 
    call DisableTrigger(GetTriggeringTrigger()) 
endfunction 

//=========================================================================== 
function InitTrig_Mirror_start takes nothing returns nothing 
    set gg_trg_Mirror_start = CreateTrigger() 
    call DisableTrigger(gg_trg_Mirror_start) 
    call TriggerAddCondition(gg_trg_Mirror_start, Condition(function Trig_Mirror_start_Conditions)) 
    call TriggerAddAction(gg_trg_Mirror_start, function Trig_Mirror_start_Actions) 
endfunction 

