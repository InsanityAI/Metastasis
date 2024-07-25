function Trig_HumanFormSpawn_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A02X')) then 
        return false 
    endif 
    if(not(udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_HumanFormSpawn_Actions takes nothing returns nothing 
    local unit c 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    call CreateNUnitsAtLoc(1, 'e00H', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, GetUnitFacing(GetSpellAbilityUnit())) 
    call SetUnitAnimation(GetLastCreatedUnit(), "death") 
    set udg_TempUnit = GetLastCreatedUnit() 
    call Remove2() 
    call CreateNUnitsAtLoc(1, 'h00H', GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, GetUnitFacing(GetSpellAbilityUnit())) 
    set udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))] = GetLastCreatedUnit() 
    set udg_TempUnit = GetLastCreatedUnit() 
    set c = udg_TempUnit 
    call SetUnitPositionLoc(GetSpellAbilityUnit(), udg_HoldZone) 
    call SetUnitLifePercentBJ(udg_TempUnit, GetUnitLifePercent(GetSpellAbilityUnit())) 
    call SetUnitManaPercentBJ(udg_TempUnit, GetUnitManaPercent(GetSpellAbilityUnit())) 
    set udg_TempUnit = c 
    call SetUnitPositionLoc(udg_TempUnit, udg_TempPoint) 
    set udg_TempUnit = c 
    call SelectUnitForPlayerSingle(udg_TempUnit, udg_TempPlayer) 
    call UnitAddAbilityBJ(udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]], GetLastCreatedUnit()) 
    call UnitAddAbilityBJ('A02W', GetLastCreatedUnit()) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        set udg_TempUnit = c 
        call UnitAddItemSwapped(UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()), udg_TempUnit) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call RemoveUnit(GetSpellAbilityUnit()) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_HumanFormSpawn takes nothing returns nothing 
    set gg_trg_HumanFormSpawn = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_HumanFormSpawn, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_HumanFormSpawn, Condition(function Trig_HumanFormSpawn_Conditions)) 
    call TriggerAddAction(gg_trg_HumanFormSpawn, function Trig_HumanFormSpawn_Actions) 
endfunction 

