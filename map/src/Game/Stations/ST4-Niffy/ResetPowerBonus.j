function Trig_ResetPowerBonus_Func001Func002A takes nothing returns nothing 
    call RemoveUnit(GetEnumUnit()) 
endfunction 

function Trig_ResetPowerBonus_Func001C takes nothing returns boolean 
    if(not(udg_Power_Bonus == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ResetPowerBonus_Func002Func001Func001C takes nothing returns boolean 
    if not(IsUnitExplorer(GetEnumUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ResetPowerBonus_Func002Func001A takes nothing returns nothing 
    if(Trig_ResetPowerBonus_Func002Func001Func001C()) then 
        call UnitRemoveAbilityBJ('A06K', GetEnumUnit()) 
        call UnitRemoveAbilityBJ('A06J', GetEnumUnit()) 
        call UnitRemoveAbilityBJ('A06I', GetEnumUnit()) 
    else 
    endif 
endfunction 

function Trig_ResetPowerBonus_Func002C takes nothing returns boolean 
    if(not(udg_Power_Bonus == 2)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ResetPowerBonus_Func003Func002Func001C takes nothing returns boolean 
    if not(IsUnitStation(GetEnumUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ResetPowerBonus_Func003Func002A takes nothing returns nothing 
    if(Trig_ResetPowerBonus_Func003Func002Func001C()) then 
        call UnitRemoveAbilityBJ('A06L', GetEnumUnit()) 
        call UnitRemoveAbilityBJ('A06M', GetEnumUnit()) 
    else 
    endif 
endfunction 

function Trig_ResetPowerBonus_Func003C takes nothing returns boolean 
    if(not(udg_Power_Bonus == 3)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ResetPowerBonus_Func004C takes nothing returns boolean 
    if(not(udg_Power_Bonus == 4)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ResetPowerBonus_Actions takes nothing returns nothing 
    if(Trig_ResetPowerBonus_Func001C()) then 
        set udg_TempUnitGroup = GetUnitsOfTypeIdAll('e01U') 
        call ForGroupBJ(udg_TempUnitGroup, function Trig_ResetPowerBonus_Func001Func002A) 
        call DestroyGroup(udg_TempUnitGroup) 
    else 
    endif 
    if(Trig_ResetPowerBonus_Func002C()) then 
        call ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), function Trig_ResetPowerBonus_Func002Func001A) 
    else 
    endif 
    if(Trig_ResetPowerBonus_Func003C()) then 
        call DecUnitAbilityLevelSwapped('A005', gg_unit_h007_0027) 
        call ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), function Trig_ResetPowerBonus_Func003Func002A) 
    else 
    endif 
    if(Trig_ResetPowerBonus_Func004C()) then 
        call DisableTrigger(gg_trg_LaboratorySpawnExperiments) 
        call ResetUnitAnimation(gg_unit_h049_0139) 
        set udg_TempUnit = gg_unit_h049_0139 
        call PauseUnitForPeriod(udg_TempUnit, 99999999.0) 
        call PacificationBotDisable() 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_ResetPowerBonus takes nothing returns nothing 
    set gg_trg_ResetPowerBonus = CreateTrigger() 
    call TriggerAddAction(gg_trg_ResetPowerBonus, function Trig_ResetPowerBonus_Actions) 
endfunction 

