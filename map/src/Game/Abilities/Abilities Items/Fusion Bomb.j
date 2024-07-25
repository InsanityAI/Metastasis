function Trig_Fusion_Bomb_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A019')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Fusion_Bomb_Actions takes nothing returns nothing 
    local location a = GetSpellTargetLoc() 
    set udg_TempPoint = a 
    call CreateNUnitsAtLoc(1, 'h013', GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING) 
    call SetUnitTimeScalePercent(GetLastCreatedUnit(), 200.00) 
    set udg_TempUnit = GetLastCreatedUnit() 
    set udg_CountUpBarColor = "|cffFF0000" 
    call BasicAI_IssueDangerArea(a, 800.0, 3.1) 
    call CountUpBar(udg_TempUnit, 60, 0.05, "FusionBombExplosion") 
    call RemoveLocation(a) 
endfunction 

//=========================================================================== 
function InitTrig_Fusion_Bomb takes nothing returns nothing 
    set gg_trg_Fusion_Bomb = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Fusion_Bomb, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Fusion_Bomb, Condition(function Trig_Fusion_Bomb_Conditions)) 
    call TriggerAddAction(gg_trg_Fusion_Bomb, function Trig_Fusion_Bomb_Actions) 
endfunction 

