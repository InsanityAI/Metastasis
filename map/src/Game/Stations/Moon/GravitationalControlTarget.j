function Trig_GravitationalControlTarget_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A02V')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GravitationalControlTarget_Func004Func001C takes nothing returns boolean 
    if((RectContainsLoc(gg_rct_Space, udg_TempPoint) == false)) then 
        return true 
    endif 
    if((IsUnitIdType(GetUnitTypeId(GetSpellTargetUnit()), UNIT_TYPE_STRUCTURE) == true)) then 
        return true 
    endif 
    if((GetSpellTargetUnit() == gg_unit_h03T_0209)) then 
        return true 
    endif 
    if((GetSpellTargetUnit() == gg_unit_h008_0196)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_GravitationalControlTarget_Func004C takes nothing returns boolean 
    if(not Trig_GravitationalControlTarget_Func004Func001C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GravitationalControlTarget_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellTargetUnit()) 
    if(Trig_GravitationalControlTarget_Func004C()) then 
        call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "|cffFF0000ERROR: Invalid target.|r") 
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop") 
        call ForceUIKeyBJ(GetOwningPlayer(GetSpellAbilityUnit()), "J") 
        call RemoveLocation(udg_TempPoint) 
        return 
    else 
    endif 
    set udg_GravitationalControl_Target = GetSpellTargetUnit() 
    call ForceUIKeyBJ(GetOwningPlayer(GetSpellAbilityUnit()), "K") 
    call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "|cff00FF00Target accepted. Select correction angle.|r") 
endfunction 

//=========================================================================== 
function InitTrig_GravitationalControlTarget takes nothing returns nothing 
    set gg_trg_GravitationalControlTarget = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_GravitationalControlTarget, EVENT_PLAYER_UNIT_SPELL_CAST) 
    call TriggerAddCondition(gg_trg_GravitationalControlTarget, Condition(function Trig_GravitationalControlTarget_Conditions)) 
    call TriggerAddAction(gg_trg_GravitationalControlTarget, function Trig_GravitationalControlTarget_Actions) 
endfunction 

