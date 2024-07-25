function Trig_HandMissile_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A00A')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_HandMissile_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetTriggerUnit()) 
    call CreateNUnitsAtLoc(1, 'e000', GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, GetUnitFacing(GetTriggerUnit())) 
    call RemoveLocation(udg_TempPoint) 
    set udg_TempPoint = GetSpellTargetLoc() 
    call IssuePointOrderLocBJ(GetLastCreatedUnit(), "clusterrockets", udg_TempPoint) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_HandMissile takes nothing returns nothing 
    set gg_trg_HandMissile = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_HandMissile, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_HandMissile, Condition(function Trig_HandMissile_Conditions)) 
    call TriggerAddAction(gg_trg_HandMissile, function Trig_HandMissile_Actions) 
endfunction 

