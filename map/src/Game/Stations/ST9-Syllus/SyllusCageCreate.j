function Trig_SyllusCageCreate_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTrainedUnit()) == 'e02S')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SyllusCageCreate_Func008A takes nothing returns nothing 
    set udg_TempPoint2 = GetUnitLoc(GetEnumUnit()) 
    set udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 256.00, 270.00) 
    call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl") 
    call SFXThreadClean() 
    call AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl") 
    call SFXThreadClean() 
    call SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint) 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
endfunction 

function Trig_SyllusCageCreate_Actions takes nothing returns nothing 
    call PauseUnitBJ(true, gg_unit_h04R_0258) 
    set udg_TempUnit = gg_unit_h04R_0258 
    set udg_CountUpBarColor = "|cffFF0080" 
    call CountUpBar(udg_TempUnit, 30, 0.333, "DoNothing") 
    call PauseUnitBJ(false, gg_unit_h04R_0258) 
    call ForGroupBJ(GetUnitsInRectAll(gg_rct_Cage_Transport), function Trig_SyllusCageCreate_Func008A) 
    set udg_TempPoint2 = GetRectCenter(gg_rct_Cage_Transport) 
    call AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl") 
    call SFXThreadClean() 
    call CreateNUnitsAtLoc(1, 'h04Q', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, 45.00) 
    call SaveGroupHandle(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("CageGroup"), CreateGroup()) 
    call SaveInteger(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("Cage_Weight"), 0) 
    call RemoveLocation(udg_TempPoint2) 
endfunction 

//=========================================================================== 
function InitTrig_SyllusCageCreate takes nothing returns nothing 
    set gg_trg_SyllusCageCreate = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SyllusCageCreate, EVENT_PLAYER_UNIT_TRAIN_FINISH) 
    call TriggerAddCondition(gg_trg_SyllusCageCreate, Condition(function Trig_SyllusCageCreate_Conditions)) 
    call TriggerAddAction(gg_trg_SyllusCageCreate, function Trig_SyllusCageCreate_Actions) 
endfunction 

