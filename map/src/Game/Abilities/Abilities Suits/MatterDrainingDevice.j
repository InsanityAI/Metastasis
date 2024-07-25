function Trig_MatterDrainingDevice_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A02Q')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MatterDrainingDevice_Func004Func001C takes nothing returns boolean 
    if((GetOwningPlayer(GetSpellTargetUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return true 
    endif 
    if((GetOwningPlayer(GetSpellTargetUnit()) == Player(PLAYER_NEUTRAL_PASSIVE))) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_MatterDrainingDevice_Func004C takes nothing returns boolean 
    if(not Trig_MatterDrainingDevice_Func004Func001C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MatterDrainingDevice_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    if(Trig_MatterDrainingDevice_Func004C()) then 
        call CreateNUnitsAtLoc(1, 'e00I', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING) 
    else 
        call CreateNUnitsAtLoc(1, 'e00I', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING) 
    endif 
    call IssueTargetOrderBJ(GetLastCreatedUnit(), "drain", GetSpellTargetUnit()) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_MatterDrainingDevice takes nothing returns nothing 
    set gg_trg_MatterDrainingDevice = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_MatterDrainingDevice, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_MatterDrainingDevice, Condition(function Trig_MatterDrainingDevice_Conditions)) 
    call TriggerAddAction(gg_trg_MatterDrainingDevice, function Trig_MatterDrainingDevice_Actions) 
endfunction 

