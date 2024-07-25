function Trig_GooSpray_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07Y')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GooSpray_Actions takes nothing returns nothing 
    local location a = GetSpellTargetLoc() 
    call TriggerSleepAction(0.40) 
    set udg_TempPoint = a 
    call AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl") 
    call SFXThreadClean() 
    call CreateNUnitsAtLoc(1, 'e036', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_GooSpray takes nothing returns nothing 
    set gg_trg_GooSpray = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_GooSpray, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_GooSpray, Condition(function Trig_GooSpray_Conditions)) 
    call TriggerAddAction(gg_trg_GooSpray, function Trig_GooSpray_Actions) 
endfunction 

