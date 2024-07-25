function Trig_WormFood_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A03W')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_WormFood_Func003Func001Func001Func001C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetSpellAbilityUnit()) == GetOwningPlayer(gg_unit_n006_0218))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_WormFood_Func003Func001Func001C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'n006')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_WormFood_Func003Func001C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'h02E')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_WormFood_Func003C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'n003')) then 
        return false 
    endif 
    if(not(GetOwningPlayer(GetSpellTargetUnit()) == Player(PLAYER_NEUTRAL_PASSIVE))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_WormFood_Actions takes nothing returns nothing 
    if(Trig_WormFood_Func003C()) then 
        call SetUnitOwner(GetSpellTargetUnit(), GetOwningPlayer(GetSpellAbilityUnit()), true) 
        call IssueTargetOrderBJ(GetSpellTargetUnit(), "move", GetSpellAbilityUnit()) 
    else 
        if(Trig_WormFood_Func003Func001C()) then 
            call SetUnitOwner(GetSpellTargetUnit(), GetOwningPlayer(GetSpellAbilityUnit()), true) 
            call IssueTargetOrderBJ(GetSpellTargetUnit(), "move", GetSpellAbilityUnit()) 
            call UnitApplyTimedLife(GetSpellTargetUnit(), 'Broa', 25) 
        else 
            if(Trig_WormFood_Func003Func001Func001C()) then 
                if(Trig_WormFood_Func003Func001Func001Func001C()) then 
                    set udg_TempPoint = GetUnitLoc(GetSpellTargetUnit()) 
                    call CreateTextTagLocBJ("TRIGSTR_5372", udg_TempPoint, 0, 10, 100, 100, 100, 0) 
                    call ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll()) 
                    call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90) 
                    call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false) 
                    call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00) 
                    call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00) 
                    call RemoveLocation(udg_TempPoint) 
                    call SetUnitOwner(GetSpellTargetUnit(), GetOwningPlayer(GetSpellAbilityUnit()), true) 
                    call IssueTargetOrderBJ(GetSpellTargetUnit(), "move", GetSpellAbilityUnit()) 
                else 
                    set udg_TempPoint = GetUnitLoc(GetSpellTargetUnit()) 
                    call CreateTextTagLocBJ("TRIGSTR_5373", udg_TempPoint, 0, 10, 100, 100, 100, 0) 
                    call ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll()) 
                    call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90) 
                    call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false) 
                    call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00) 
                    call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00) 
                    call RemoveLocation(udg_TempPoint) 
                    call SetUnitOwner(GetSpellTargetUnit(), GetOwningPlayer(GetSpellAbilityUnit()), true) 
                    call IssueTargetOrderBJ(GetSpellTargetUnit(), "move", GetSpellAbilityUnit()) 
                endif 
            else 
            endif 
        endif 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_WormFood takes nothing returns nothing 
    set gg_trg_WormFood = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_WormFood, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_WormFood, Condition(function Trig_WormFood_Conditions)) 
    call TriggerAddAction(gg_trg_WormFood, function Trig_WormFood_Actions) 
endfunction 

