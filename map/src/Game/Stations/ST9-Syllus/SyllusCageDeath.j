function Trig_SyllusCageDeath_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetDyingUnit()) == 'h04Q')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SyllusCageDeath_Func005A takes nothing returns nothing 
    call SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint4) 
    call ShowUnitShow(GetEnumUnit()) 
    call PauseUnitBJ(false, GetEnumUnit()) 
    call UnitRemoveAbilityBJ('Awan', GetEnumUnit()) 
endfunction 

function Trig_SyllusCageDeath_Actions takes nothing returns nothing 
    set udg_TempUnitGroup = LoadGroupHandle(LS(), GetHandleId(GetDyingUnit()), StringHash("CageGroup")) 
    set udg_TempPoint4 = GetUnitLoc(GetDyingUnit()) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_SyllusCageDeath_Func005A) 
    call RemoveLocation(udg_TempPoint) 
    call DestroyGroup(udg_TempUnitGroup) 
endfunction 

//=========================================================================== 
function InitTrig_SyllusCageDeath takes nothing returns nothing 
    set gg_trg_SyllusCageDeath = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SyllusCageDeath, EVENT_PLAYER_UNIT_DEATH) 
    call TriggerAddCondition(gg_trg_SyllusCageDeath, Condition(function Trig_SyllusCageDeath_Conditions)) 
    call TriggerAddAction(gg_trg_SyllusCageDeath, function Trig_SyllusCageDeath_Actions) 
endfunction 

