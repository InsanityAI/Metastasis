function Trig_MutantCannibalize_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A076')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantCannibalize_Func004Func001Func002C takes nothing returns boolean 
    if(not(DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2) <= 140.00)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantCannibalize_Func004Func001C takes nothing returns boolean 
    if(not(GetUnitAbilityLevelSwapped('A077', GetEnumUnit()) == 1)) then 
        return false 
    endif 
    if(not(GetUnitAbilityLevelSwapped('A07P', GetEnumUnit()) == 0)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantCannibalize_Func004A takes nothing returns nothing 
    if(Trig_MutantCannibalize_Func004Func001C()) then 
        set udg_TempPoint2 = GetUnitLoc(GetEnumUnit()) 
        if(Trig_MutantCannibalize_Func004Func001Func002C()) then 
            call SetSoundPositionLocBJ(gg_snd_Devour, udg_TempPoint, 0) 
            call PlaySoundBJ(gg_snd_Devour) 
            call RemoveUnit(GetEnumUnit()) 
            set udg_UpgradePointsMutant = (udg_UpgradePointsMutant + 220.00) 
            call AddSpecialEffectLocBJ(udg_TempPoint2, "Objects\\Spawnmodels\\Orc\\Orcblood\\BattrollBlood.mdl") 
            call SFXThreadClean() 
            call AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl") 
            call SFXThreadClean() 
        else 
        endif 
        call RemoveLocation(udg_TempPoint2) 
    else 
    endif 
endfunction 

function Trig_MutantCannibalize_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(PLAYER_NEUTRAL_PASSIVE)), function Trig_MutantCannibalize_Func004A) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_MutantCannibalize takes nothing returns nothing 
    set gg_trg_MutantCannibalize = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_MutantCannibalize, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_MutantCannibalize, Condition(function Trig_MutantCannibalize_Conditions)) 
    call TriggerAddAction(gg_trg_MutantCannibalize, function Trig_MutantCannibalize_Actions) 
endfunction 

