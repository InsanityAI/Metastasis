function Trig_ElectromagneticGrenade_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetSummonedUnit()) == 'e00X')) then 
        return false 
    endif 
    return true 
endfunction 

function EMP_Grenade_Disable_Vendor takes nothing returns nothing 
    local unit a = udg_TempUnit 
    if GetUnitAbilityLevel(GetEnumUnit(), 'A079') > 0 then 
        call ConsoleDisable(GetEnumUnit()) 
    endif 
    call PauseUnitForPeriod(GetEnumUnit(), 120.0) 
    call SetUnitVertexColor(a, 50, 50, 50, 256) 
    call PolledWait(120.00) 
    call SetUnitVertexColor(a, 255, 255, 255, 256) 
    if GetUnitAbilityLevel(a, 'A079') > 0 then 
        call ConsoleEnable(a) 
    endif 
endfunction 

function Trig_ElectromagneticGrenade_Func005A takes nothing returns nothing 
    set udg_TempPoint2 = GetUnitLoc(GetEnumUnit()) 
    call SetUnitManaBJ(GetEnumUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit()) -((250.00 - DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2)) / 1.60))) 
    if GetUnitAbilityLevel(GetEnumUnit(), 'A07Q') >= 1 or GetUnitAbilityLevel(GetEnumUnit(), 'A079') >= 1 then 
        set udg_TempUnit = GetEnumUnit() 
        call ExecuteFunc("EMP_Grenade_Disable_Vendor") 
    endif 
    if IsUnitExplorer(GetEnumUnit()) then 
        call DestroyUnitBarStop(GetEnumUnit()) 
        call SaveBoolean(LS(), GetHandleId(GetEnumUnit()), StringHash("LaunchCleared"), false) 
        call AddSpecialEffectLoc("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", udg_TempPoint2) 
        call SFXThreadClean() 
    endif 
    call RemoveLocation(udg_TempPoint2) 
endfunction 

function Trig_ElectromagneticGrenade_Actions takes nothing returns nothing 
    local location a = GetUnitLoc(GetSummonedUnit()) 
    set udg_TempUnitGroup = GetUnitsInRangeOfLocAll(250.00, a) 
    call CreateNUnitsAtLoc(1, 'e00Y', Player(PLAYER_NEUTRAL_AGGRESSIVE), a, bj_UNIT_FACING) 
    //Silence?  
    call IssuePointOrderLocBJ(GetLastCreatedUnit(), "silence", a) 
    set udg_TempPoint = a 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_ElectromagneticGrenade_Func005A) 
    call DestroyGroup(udg_TempUnitGroup) 
    call RemoveLocation(a) 
endfunction 

//===========================================================================  
function InitTrig_ElectromagneticGrenade takes nothing returns nothing 
    set gg_trg_ElectromagneticGrenade = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ElectromagneticGrenade, EVENT_PLAYER_UNIT_SUMMON) 
    call TriggerAddCondition(gg_trg_ElectromagneticGrenade, Condition(function Trig_ElectromagneticGrenade_Conditions)) 
    call TriggerAddAction(gg_trg_ElectromagneticGrenade, function Trig_ElectromagneticGrenade_Actions) 
endfunction 

