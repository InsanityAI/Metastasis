function Trig_AllSectorsTargetCheck_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() != 'A03I')) then 
        return false 
    endif 
    if(not(GetSpellAbilityId() != 'A082')) then 
        return false 
    endif 
    if(not(GetSpellAbilityId() != 'A087')) then 
        return false 
    endif 
    if(not(GetSpellAbilityId() != 'A08H')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AllSectorsTargetCheck_Func010C takes nothing returns boolean 
    if(not(GetSpellTargetUnit() != null)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AllSectorsTargetCheck_Func011C takes nothing returns boolean 
    if(not(GetLocationX(udg_TempPoint) == 0.00)) then 
        return false 
    endif 
    if(not(GetLocationY(udg_TempPoint) == 0.00)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AllSectorsTargetCheck_Func014C takes nothing returns boolean 
    if(not(udg_TempBool == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AllSectorsTargetCheck_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempInt = GetSector(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint) 
    set udg_TempPoint = GetSpellTargetLoc() 
    if(Trig_AllSectorsTargetCheck_Func010C()) then 
        call RemoveLocation(udg_TempPoint) 
        return 
    else 
    endif 
    if(Trig_AllSectorsTargetCheck_Func011C()) then 
        call RemoveLocation(udg_TempPoint) 
        return 
    else 
    endif 
    set udg_TempBool = LocInSector(udg_TempPoint, udg_TempInt) 
    call RemoveLocation(udg_TempPoint) 
    if(Trig_AllSectorsTargetCheck_Func014C()) then 
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop") 
        call PauseUnitForPeriod(GetSpellAbilityUnit(), 0.1) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_AllSectorsTargetCheck takes nothing returns nothing 
    set gg_trg_AllSectorsTargetCheck = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AllSectorsTargetCheck, EVENT_PLAYER_UNIT_SPELL_CAST) 
    call TriggerAddCondition(gg_trg_AllSectorsTargetCheck, Condition(function Trig_AllSectorsTargetCheck_Conditions)) 
    call TriggerAddAction(gg_trg_AllSectorsTargetCheck, function Trig_AllSectorsTargetCheck_Actions) 
endfunction 

