function Trig_TotalInfection_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A01V')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_TotalInfection_Actions takes nothing returns nothing 
    local integer a 
    local integer b 
    set a = 1 
    set b = 12 
    loop 
        exitwhen a > b 
        if(udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(udg_Playerhero[a]))] == false) then 
            if(GetOwningPlayer(udg_Playerhero[a]) != udg_Mutant) then 
                set udg_TempPoint = GetUnitLoc(udg_Playerhero[a]) 
                call CreateNUnitsAtLoc(1, 'e000', udg_Mutant, udg_TempPoint, bj_UNIT_FACING) 
                call RemoveLocation(udg_TempPoint) 
                call IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", udg_Playerhero[a]) 
            endif 
        endif 
        set a = a + 1 
    endloop 
endfunction 

//=========================================================================== 
function InitTrig_TotalInfection takes nothing returns nothing 
    set gg_trg_TotalInfection = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_TotalInfection, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_TotalInfection, Condition(function Trig_TotalInfection_Conditions)) 
    call TriggerAddAction(gg_trg_TotalInfection, function Trig_TotalInfection_Actions) 
endfunction