function Trig_ForceSuitAttackGround_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A08A')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ForceSuitAttackGround_Actions takes nothing returns nothing 
    local location a = GetSpellTargetLoc() 
    local location b = GetUnitLoc(GetSpellAbilityUnit()) 
    local location c = PolarProjectionBJ(b, 100.0, AngleBetweenPoints(b, a)) 
    call CreateNUnitsAtLoc(1, 'e030', GetOwningPlayer(GetSpellAbilityUnit()), c, bj_UNIT_FACING) 
    call IssueTargetOrderBJ(GetSpellAbilityUnit(), "attack", GetLastCreatedUnit()) 
    call RemoveLocation(a) 
    call RemoveLocation(b) 
    call RemoveLocation(c) 
endfunction 

//=========================================================================== 
function InitTrig_ForceSuitAttackGround takes nothing returns nothing 
    set gg_trg_ForceSuitAttackGround = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ForceSuitAttackGround, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_ForceSuitAttackGround, Condition(function Trig_ForceSuitAttackGround_Conditions)) 
    call TriggerAddAction(gg_trg_ForceSuitAttackGround, function Trig_ForceSuitAttackGround_Actions) 
endfunction 

