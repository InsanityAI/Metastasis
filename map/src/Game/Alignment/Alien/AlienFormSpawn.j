function Trig_AlienFormSpawn_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A02W')) then 
        return false 
    endif 
    if(not(udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienFormSpawn_Actions takes nothing returns nothing 
    // Pretty much the same as AlienForm trigger. 
    set udg_TempUnit3 = GetSpellAbilityUnit() 
    call ShowUnitHide(udg_TempUnit3) 
    set udg_TempPoint = GetUnitLoc(udg_TempUnit3) 
    call CreateNUnitsAtLoc(1, udg_ParasiteChildInfectee, GetOwningPlayer(udg_TempUnit3), udg_TempPoint, GetUnitFacing(GetSpellAbilityUnit())) 
    set udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))] = GetLastCreatedUnit() 
    call SetUnitLifePercentBJ(GetLastCreatedUnit(), GetUnitLifePercent(GetSpellAbilityUnit())) 
    call SetUnitManaPercentBJ(GetLastCreatedUnit(), GetUnitManaPercent(GetSpellAbilityUnit())) 
    call SelectUnitForPlayerSingle(GetLastCreatedUnit(), GetOwningPlayer(GetSpellAbilityUnit())) 
    call SetUnitPositionLoc(GetLastCreatedUnit(), udg_TempPoint) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call UnitAddItemSwapped(UnitItemInSlotBJ(udg_TempUnit3, GetForLoopIndexA()), GetLastCreatedUnit()) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call SetUnitPositionLoc(udg_TempUnit3, udg_HoldZone) 
    call RemoveUnit(udg_TempUnit3) 
    call CreateNUnitsAtLoc(1, 'e00H', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, GetUnitFacing(GetSpellAbilityUnit())) 
    call SetUnitAnimation(GetLastCreatedUnit(), "death") 
    set udg_TempUnit = GetLastCreatedUnit() 
    call Remove2() 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_AlienFormSpawn takes nothing returns nothing 
    set gg_trg_AlienFormSpawn = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AlienFormSpawn, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_AlienFormSpawn, Condition(function Trig_AlienFormSpawn_Conditions)) 
    call TriggerAddAction(gg_trg_AlienFormSpawn, function Trig_AlienFormSpawn_Actions) 
endfunction 

