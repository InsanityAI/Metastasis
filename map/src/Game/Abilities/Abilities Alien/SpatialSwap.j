function Trig_SpatialSwap_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A03I')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SpatialSwap_Func003Func002Func001Func001C takes nothing returns boolean 
    local integer a = GetUnitTypeId(GetEnumUnit()) 
    if((GetOwningPlayer(GetEnumUnit()) == Player(PLAYER_NEUTRAL_PASSIVE))) then 
        return true 
    endif 
    if GetUnitPointValue(GetEnumUnit()) == 37 then 
        return true 
    endif 
    if a == 'h02A' or a == 'h004' or a == 'h00A' or a == 'h006' or a == 'h00Y' or a == 'h000' then 
        return true 
    endif 
    if((GetUnitAbilityLevelSwapped('Avul', GetEnumUnit()) != 0)) then 
        return true 
    endif 
    if((IsUnitPausedBJ(GetEnumUnit()) == true)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_SpatialSwap_Func003Func002Func001C takes nothing returns boolean 
    if Trig_SpatialSwap_Func003Func002Func001Func001C() then 
        return true 
    endif 
    return false 
endfunction 

function Trig_SpatialSwap_Func003Func002A takes nothing returns nothing 
    if(Trig_SpatialSwap_Func003Func002Func001C()) then 
        call GroupRemoveUnitSimple(GetEnumUnit(), udg_TempUnitGroup) 
    else 
        call UnitAddAbilityBJ('Avul', GetEnumUnit()) 
        call PauseUnitBJ(true, GetEnumUnit()) 
    endif 
endfunction 



function Trig_SpatialSwap_Func003Func016A takes nothing returns nothing 
    call PauseUnitBJ(false, GetEnumUnit()) 
    call UnitRemoveAbilityBJ('Avul', GetEnumUnit()) 
    set udg_TempPoint3 = GetUnitLoc(GetEnumUnit()) 
    call AddSpecialEffectLocBJ(udg_TempPoint3, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl") 
    call SFXThreadClean() 
    call RemoveLocation(udg_TempPoint3) 
    call SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint) 
    call PanCameraToLocForPlayer(GetOwningPlayer(GetEnumUnit()), udg_TempPoint) 
endfunction 


function SpatialSwap_Sort takes nothing returns nothing 
    if udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] != GetEnumUnit() then 
        call GroupRemoveUnit(udg_TempUnitGroup, GetEnumUnit()) 
    endif 
    if IsUnitAliveBJ(GetEnumUnit()) != true then 
        call GroupRemoveUnit(udg_TempUnitGroup, GetEnumUnit()) 
    endif 
endfunction 
function Trig_SpatialSwap_Actions takes nothing returns nothing 
    local location a 
    local location b 
    local group c 
    local effect d 
    local effect e 
    local unit sp = GetSpellAbilityUnit() 
    set udg_TempPoint = GetUnitLoc(sp) 
    set udg_TempPoint2 = GetSpellTargetLoc() 

    if RectContainsLoc(gg_rct_Space, udg_TempPoint2) != true and RectContainsLoc(gg_rct_Timeout, udg_TempPoint2) != true then 
        set udg_TempUnitGroup = GetUnitsInRangeOfLocAll(200.00, udg_TempPoint2) 
        call ForGroup(udg_TempUnitGroup, function SpatialSwap_Sort) 
        call ForGroupBJ(udg_TempUnitGroup, function Trig_SpatialSwap_Func003Func002A) 
        if CountUnitsInGroup(udg_TempUnitGroup) == 0 or RectContainsLoc(gg_rct_Timeout, udg_TempPoint2) or RectContainsLoc(gg_rct_Timeout, udg_TempPoint) then 
            call DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffffcc00No players netted!|r") 
            call DestroyGroup(udg_TempUnitGroup) 
            call RemoveLocation(udg_TempPoint) 
            call RemoveLocation(udg_TempPoint2) 
            return 
        endif 
        call PauseUnitBJ(true, sp) 
        call UnitAddAbilityBJ('Avul', sp) 
        set d = AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl") 
        set e = AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl") 
        set a = udg_TempPoint 
        set b = udg_TempPoint2 
        set c = udg_TempUnitGroup 
        call PolledWait(3.00) 
        call PauseUnitBJ(false, sp) 
        call UnitRemoveAbilityBJ('Avul', sp) 
        set udg_TempPoint = a 
        set udg_TempPoint2 = b 
        set udg_TempUnitGroup = c 
        call ForGroupBJ(udg_TempUnitGroup, function Trig_SpatialSwap_Func003Func016A) 
        call DestroyEffectBJ(d) 
        call DestroyEffectBJ(e) 
        set udg_TempPoint3 = GetUnitLoc(sp) 
        call PanCameraToTimedLocForPlayer(GetOwningPlayer(sp), udg_TempPoint2, 0) 
        call SetUnitPositionLoc(sp, udg_TempPoint2) 
        call AddSpecialEffectLocBJ(udg_TempPoint3, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl") 
        call SFXThreadClean() 
        call RemoveLocation(udg_TempPoint3) 

        call DestroyGroup(udg_TempUnitGroup) 
    else 
    endif 
    call RemoveLocation(a) 
    call RemoveLocation(b) 
endfunction 

//=========================================================================== 
function InitTrig_SpatialSwap takes nothing returns nothing 
    set gg_trg_SpatialSwap = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SpatialSwap, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_SpatialSwap, Condition(function Trig_SpatialSwap_Conditions)) 
    call TriggerAddAction(gg_trg_SpatialSwap, function Trig_SpatialSwap_Actions) 
endfunction 

