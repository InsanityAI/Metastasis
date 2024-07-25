function Trig_SpatialRelocation_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A03C')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SpatialRelocation_Func015C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetSpellAbilityUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SpatialRelocation_Actions takes nothing returns nothing 
    set udg_TempUnit3 = GetSpellAbilityUnit() 
    call SetUnitScalePercent(GetSpellAbilityUnit(), 25.00, 25.00, 25.00) 
    set udg_TempPoint = GetRandomLocInRect(gg_rct_Space) 
    set udg_TempPoint2 = GetUnitLoc(GetSpellAbilityUnit()) 
    call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl") 
    call SFXThreadClean() 
    call AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl") 
    call SFXThreadClean() 
    call SetUnitPositionLoc(GetSpellAbilityUnit(), udg_TempPoint2) 
    call UnitAddTypeBJ(UNIT_TYPE_FLYING, GetSpellAbilityUnit()) 
    call SetUnitPositionLoc(GetSpellAbilityUnit(), udg_TempPoint) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        set udg_TempItem = UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()) 
        call SetItemVisibleBJ(false, udg_TempItem) 
        call SetItemPositionLoc(udg_TempItem, udg_HoldZone) 
        call SaveItemHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("ihold" + I2S(bj_forLoopAIndex)), udg_TempItem) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    if(Trig_SpatialRelocation_Func015C()) then 
        call PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0) 
    else 
        call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0) 
    endif 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
    set udg_TempUnitType = 'e00M' 
    set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit()) 
    call ExecuteFunc("AlienRequirementRemove") 
    call SetUnitMoveSpeed(GetSpellAbilityUnit(), (GetUnitDefaultMoveSpeed(GetSpellAbilityUnit()) / 2.00)) 
    call UnitAddAbilityBJ('A03B', udg_TempUnit3) 
    call UnitAddAbilityBJ('A03H', udg_TempUnit3) 
    call UnitAddAbilityBJ('A03G', udg_TempUnit3) 
    call UnitRemoveAbilityBJ('A03I', udg_TempUnit3) 
    call UnitRemoveAbilityBJ('A02S', udg_TempUnit3) 
    call UnitRemoveAbilityBJ('A02X', udg_TempUnit3) 
    call UnitRemoveAbilityBJ('A03C', udg_TempUnit3) 
endfunction 

//=========================================================================== 
function InitTrig_SpatialRelocation takes nothing returns nothing 
    set gg_trg_SpatialRelocation = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SpatialRelocation, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_SpatialRelocation, Condition(function Trig_SpatialRelocation_Conditions)) 
    call TriggerAddAction(gg_trg_SpatialRelocation, function Trig_SpatialRelocation_Actions) 
endfunction 

