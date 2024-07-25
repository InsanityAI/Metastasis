function Trig_Barrels_Explosion_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTriggerUnit()) == 'n00J')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Barrels_Explosion_Func005A takes nothing returns nothing 
    call UnitDamageTargetBJ(GetTriggerUnit(), GetEnumUnit(), 150.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL) 
endfunction 

function Trig_Barrels_Explosion_Func008A takes nothing returns nothing 
    call UnitDamageTargetBJ(GetTriggerUnit(), GetEnumUnit(), 150.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL) 
endfunction 

function Trig_Barrels_Explosion_Actions takes nothing returns nothing 
    set udg_TempLoc = GetUnitLoc(GetTriggerUnit()) 
    set udg_TempUnitGroup = GetUnitsInRangeOfLocAll(300.00, udg_TempLoc) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_Barrels_Explosion_Func005A) 
    call DestroyGroup(udg_TempUnitGroup) 
    set udg_TempUnitGroup = GetUnitsInRangeOfLocAll(150.00, udg_TempLoc) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_Barrels_Explosion_Func008A) 
    call AddSpecialEffectLocBJ(udg_TempLoc, "Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl") 
    call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
    call AddSpecialEffectLocBJ(udg_TempLoc, "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl") 
    call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
    call DestroyGroup(udg_TempUnitGroup) 
    call RemoveUnit(GetTriggerUnit()) 
    call RemoveLocation(udg_TempLoc) 
endfunction 

//=========================================================================== 
function InitTrig_Barrels_Explosion takes nothing returns nothing 
    set gg_trg_Barrels_Explosion = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Barrels_Explosion, EVENT_PLAYER_UNIT_DEATH) 
    call TriggerAddCondition(gg_trg_Barrels_Explosion, Condition(function Trig_Barrels_Explosion_Conditions)) 
    call TriggerAddAction(gg_trg_Barrels_Explosion, function Trig_Barrels_Explosion_Actions) 
endfunction 

