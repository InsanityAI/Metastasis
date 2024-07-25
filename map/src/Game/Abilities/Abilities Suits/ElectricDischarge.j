function Trig_ElectricDischarge_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A02F')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ElectricDischarge_Func006Func002C takes nothing returns boolean 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h039')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h037')) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_ElectricDischarge_Func006C takes nothing returns boolean 
    if(not Trig_ElectricDischarge_Func006Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ElectricDischarge_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempPoint2 = GetUnitLoc(GetSpellTargetUnit()) 
    set udg_TempReal = DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2) 
    if(Trig_ElectricDischarge_Func006C()) then 
    else 
        call UnitDamageTargetBJ(GetSpellAbilityUnit(), GetSpellTargetUnit(), (GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) * (0.05 + ((udg_TempReal / 1000.00) / 10.00))), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL) 
    endif 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
endfunction 

//=========================================================================== 
function InitTrig_ElectricDischarge takes nothing returns nothing 
    set gg_trg_ElectricDischarge = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ElectricDischarge, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_ElectricDischarge, Condition(function Trig_ElectricDischarge_Conditions)) 
    call TriggerAddAction(gg_trg_ElectricDischarge, function Trig_ElectricDischarge_Actions) 
endfunction 

