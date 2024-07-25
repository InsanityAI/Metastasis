function Trig_PlanetDamagePerSecond_Conditions takes nothing returns boolean 
    if(not(udg_MinerthaDamagePerSecond > 0.00)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlanetDamagePerSecond_Func005Func001C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetEnumUnit()) != 'n003')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PlanetDamagePerSecond_Func005A takes nothing returns nothing 
    if(Trig_PlanetDamagePerSecond_Func005Func001C()) then 
        call UnitDamageTargetBJ(GetEnumUnit(), GetEnumUnit(), udg_MinerthaDamagePerSecond, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL) 
    else 
    endif 
endfunction 

function Trig_PlanetDamagePerSecond_Actions takes nothing returns nothing 
    set udg_MinerthaDamagePerSecond = (udg_MinerthaDamagePerSecond * 0.99) 
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Planet) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_PlanetDamagePerSecond_Func005A) 
    call DestroyGroup(udg_TempUnitGroup) 
endfunction 

//=========================================================================== 
function InitTrig_PlanetDamagePerSecond takes nothing returns nothing 
    set gg_trg_PlanetDamagePerSecond = CreateTrigger() 
    call TriggerRegisterTimerEventPeriodic(gg_trg_PlanetDamagePerSecond, 1.00) 
    call TriggerAddCondition(gg_trg_PlanetDamagePerSecond, Condition(function Trig_PlanetDamagePerSecond_Conditions)) 
    call TriggerAddAction(gg_trg_PlanetDamagePerSecond, function Trig_PlanetDamagePerSecond_Actions) 
endfunction 

