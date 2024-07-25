function Trig_AlienEggDeath_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetDyingUnit()) == 'e01H')) then 
        return false 
    endif 
    if(not(IsUnitInGroup(GetTriggerUnit(), udg_Parasite_EggGroup) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienEggDeath_Func006C takes nothing returns boolean 
    if(not(IsUnitType(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], UNIT_TYPE_MECHANICAL) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienEggDeath_Func013C takes nothing returns boolean 
    if not(GetLocalPlayer() == udg_Parasite) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienEggDeath_Actions takes nothing returns nothing 
    call GroupRemoveUnitSimple(GetTriggerUnit(), udg_Parasite_EggGroup) 
    set udg_UpgradePointsAlien = (udg_UpgradePointsAlien - 75.00) 
    if(Trig_AlienEggDeath_Func006C()) then 
        call UnitDamageTargetBJ(GetKillingUnitBJ(), udg_AlienForm_Alien, 100.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL) 
    else 
    endif 
    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) 
    call AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\NightElf\\NightElfBlood\\NightElfBloodHippogryph.mdl") 
    call CreateNUnitsAtLoc(1, 'e000', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING) 
    call IssueTargetOrderBJ(GetLastCreatedUnit(), "firebolt", udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) 
    call RemoveLocation(udg_TempPoint) 
    call CinematicFilterGenericForPlayer(udg_Parasite, 2.0, BLEND_MODE_BLEND, "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0, 100, 100, 25, 0, 0, 0, 100) 
    if(Trig_AlienEggDeath_Func013C()) then 
        call StartSound(gg_snd_EggSackDeath1) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_AlienEggDeath takes nothing returns nothing 
    set gg_trg_AlienEggDeath = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AlienEggDeath, EVENT_PLAYER_UNIT_DEATH) 
    call TriggerAddCondition(gg_trg_AlienEggDeath, Condition(function Trig_AlienEggDeath_Conditions)) 
    call TriggerAddAction(gg_trg_AlienEggDeath, function Trig_AlienEggDeath_Actions) 
endfunction 

