function Trig_AndroidCardVision_Func003Func002Func003Func001C takes nothing returns boolean 
    if(not(UnitHasItem(GetEnumUnit(), udg_Android_MemoryCard) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidCardVision_Func003Func002Func003A takes nothing returns nothing 
    if(Trig_AndroidCardVision_Func003Func002Func003Func001C()) then 
        set udg_Android_MemoryCardOwner = GetEnumUnit() 
    else 
    endif 
endfunction 

function Trig_AndroidCardVision_Func003Func002C takes nothing returns boolean 
    if(not(UnitHasItem(udg_Android_MemoryCardOwner, udg_Android_MemoryCard) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidCardVision_Func003C takes nothing returns boolean 
    if(not(CheckItemStatus(udg_Android_MemoryCard, bj_ITEM_STATUS_OWNED) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidCardVision_Func005C takes nothing returns boolean 
    if(not(IsUnitDeadBJ(udg_TempUnit) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AndroidCardVision_Actions takes nothing returns nothing 
    call DestroyFogModifier(udg_AndroidCardVisibility) 
    if(Trig_AndroidCardVision_Func003C()) then 
        if(Trig_AndroidCardVision_Func003Func002C()) then 
            set udg_TempPoint = GetUnitLoc(udg_Android_MemoryCardOwner) 
        else 
            set udg_TempUnitGroup = GetUnitsInRectAll(GetPlayableMapRect()) 
            call ForGroupBJ(udg_TempUnitGroup, function Trig_AndroidCardVision_Func003Func002Func003A) 
            set udg_TempPoint = GetUnitLoc(udg_Android_MemoryCardOwner) 
            call DestroyGroup(udg_TempUnitGroup) 
        endif 
    else 
        set udg_TempPoint = GetItemLoc(udg_Android_MemoryCard) 
    endif 
    set udg_TempUnit = udg_Sector_Space[GetSector(udg_TempPoint)] 
    if(Trig_AndroidCardVision_Func005C()) then 
        call DestroyTrigger(GetTriggeringTrigger()) 
        return 
    else 
    endif 
    call CreateFogModifierRadiusLocBJ(true, udg_HiddenAndroid, FOG_OF_WAR_VISIBLE, udg_TempPoint, 650.00) 
    set udg_AndroidCardVisibility = GetLastCreatedFogModifier() 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_AndroidCardVision takes nothing returns nothing 
    set gg_trg_AndroidCardVision = CreateTrigger() 
    call DisableTrigger(gg_trg_AndroidCardVision) 
    call TriggerRegisterTimerEventPeriodic(gg_trg_AndroidCardVision, 1.00) 
    call TriggerAddAction(gg_trg_AndroidCardVision, function Trig_AndroidCardVision_Actions) 
endfunction 

