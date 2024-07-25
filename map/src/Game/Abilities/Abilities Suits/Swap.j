function Trig_Swap_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A04E')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Swap_Func005002002001 takes nothing returns boolean 
    return(GetUnitTypeId(GetFilterUnit()) == 'h00M') 
endfunction 

function Trig_Swap_Func005002002002 takes nothing returns boolean 
    return(IsUnitIllusionBJ(GetFilterUnit()) == true) 
endfunction 

function Trig_Swap_Func005002002 takes nothing returns boolean 
    return GetBooleanAnd(Trig_Swap_Func005002002001(), Trig_Swap_Func005002002002()) 
endfunction 

function Trig_Swap_Func007A takes nothing returns nothing 
    set udg_TempReal2 = GetUnitFacing(GetEnumUnit()) 
    set udg_TempPoint2 = GetUnitLoc(GetEnumUnit()) 
    call SetUnitPositionLocFacingBJ(GetEnumUnit(), udg_TempPoint, udg_TempReal) 
    set udg_TempReal2 = GetUnitFacing(GetEnumUnit()) 
    call SetUnitPositionLocFacingBJ(udg_TempUnit, udg_TempPoint2, udg_TempReal2) 
    call SetUnitPositionLocFacingBJ(GetEnumUnit(), udg_TempPoint, udg_TempReal) 
    call SetUnitPositionLocFacingBJ(udg_TempUnit, udg_TempPoint2, udg_TempReal2) 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
endfunction 

function Trig_Swap_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempReal = GetUnitFacing(GetSpellAbilityUnit()) 
    set udg_TempUnitGroup = GetUnitsOfPlayerMatching(GetOwningPlayer(GetSpellAbilityUnit()), Condition(function Trig_Swap_Func005002002)) 
    set udg_TempUnit = GetSpellAbilityUnit() 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_Swap_Func007A) 
endfunction 

//=========================================================================== 
function InitTrig_Swap takes nothing returns nothing 
    set gg_trg_Swap = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Swap, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Swap, Condition(function Trig_Swap_Conditions)) 
    call TriggerAddAction(gg_trg_Swap, function Trig_Swap_Actions) 
endfunction 

