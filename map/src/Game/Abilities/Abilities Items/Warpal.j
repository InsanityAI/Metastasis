function Trig_Warpal_Conditions takes nothing returns boolean 
    if(not(GetItemTypeId(GetManipulatedItem()) == 'I02X')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Warpal_Func014Func001Func002C takes nothing returns boolean 
    if((GetTriggerUnit() == GetEnumUnit())) then 
        return true 
    endif 
    if((GetUnitTypeId(GetEnumUnit()) == 'H03I')) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_Warpal_Func014Func001C takes nothing returns boolean 
    if(not Trig_Warpal_Func014Func001Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Warpal_Func014A takes nothing returns nothing 
    if(Trig_Warpal_Func014Func001C()) then 
    else 
        call UnitDamageTargetBJ(GetTriggerUnit(), GetEnumUnit(), udg_TempReal, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNKNOWN) 
    endif 
endfunction 

function Trig_Warpal_Actions takes nothing returns nothing 
    set udg_TempReal = GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit()) 
    set udg_TempLoc = GetUnitLoc(GetTriggerUnit()) 
    call SetUnitManaBJ(GetTriggerUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit()) -udg_Manacurrent1)) 
    call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()), "war3mapImported\\TwilightSparkle.mdx") 
    call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
    call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()), "war3mapImported\\Unleash-the-power.mdx") 
    call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
    call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()), "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl") 
    call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
    call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()), "war3mapImported\\Energy-Spark.mdx") 
    call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
    call ForGroupBJ(GetUnitsInRangeOfLocAll(300.00, GetUnitLoc(GetTriggerUnit())), function Trig_Warpal_Func014A) 
    call SetUnitManaBJ(GetTriggerUnit(), 0) 
    call RemoveLocation(udg_TempLoc) 
endfunction 

//=========================================================================== 
function InitTrig_Warpal takes nothing returns nothing 
    set gg_trg_Warpal = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Warpal, EVENT_PLAYER_UNIT_USE_ITEM) 
    call TriggerAddCondition(gg_trg_Warpal, Condition(function Trig_Warpal_Conditions)) 
    call TriggerAddAction(gg_trg_Warpal, function Trig_Warpal_Actions) 
endfunction 

