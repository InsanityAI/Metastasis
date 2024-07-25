function Trig_Charge_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A08R')) then 
        return false 
    endif 
    return true 
endfunction 

function Charge_DragAlong takes nothing returns nothing 
    local real x 
    local real y 
    if LoadBoolean(LS(), GetHandleId(GetEnumUnit()), StringHash("DragGroupDraggable_" + I2S(GetUnitAN(udg_TempUnit2)))) then 
        set x = GetUnitX(udg_TempUnit2) + LoadReal(LS(), GetHandleId(GetEnumUnit()), StringHash("DragGroupXOffset_" + I2S(GetUnitAN(udg_TempUnit2)))) 
        set y = GetUnitY(udg_TempUnit2) + LoadReal(LS(), GetHandleId(GetEnumUnit()), StringHash("DragGroupYOffset_" + I2S(GetUnitAN(udg_TempUnit2)))) 
        if IsPointPathable(x, y, false) then 
            call SetUnitX(GetEnumUnit(), x) 
            call SetUnitY(GetEnumUnit(), y) 
        else 
            call UnitDamageTarget(udg_TempUnit2, GetEnumUnit(), 155, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
            set bj_lastCreatedEffect = AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", GetEnumUnit(), "origin") 
            call SFXThreadClean() 
            call SaveBoolean(LS(), GetHandleId(GetEnumUnit()), StringHash("DragGroupDraggable_" + I2S(GetUnitAN(udg_TempUnit2))), false) 
        endif 
    endif 
endfunction 

function Charge_Slide takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local unit l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) 
    local location a = GetUnitLoc(l) 
    local location b = PolarProjectionBJ(a, 25.0, GetUnitFacing(l)) 
    local group g = LoadGroupHandle(LS(), GetHandleId(k), StringHash("draggroup")) 
    local integer i = LoadInteger(LS(), GetHandleId(k), StringHash("i")) 
    //local integer r=LoadInteger(LS(),GetHandleId(k),StringHash("r")) 
    call PauseUnit(l, true) 
    if i == 0 then 
        call PlaySound3D("Sound\\Units\\Footsteps\\Step1.wav", GetLocationX(b), GetLocationY(b)) 
        set i = 10 
    endif 
    //if r == 0 then 

    //et r=12 
    //endif 
    call SaveInteger(LS(), GetHandleId(k), StringHash("i"), i - 1) 
    //call SaveInteger(LS(),GetHandleId(k),StringHash("r"),r-1) 
    call EnumDestructablesInCircleBJ(150.0, b, function RubbleDestroy) 

    if IsPointPathable(GetLocationX(b), GetLocationY(b), false) == false or LoadBoolean(LS(), GetHandleId(k), StringHash("over")) then 
        call DestroyTrigger(LoadTriggerHandle(LS(), GetHandleId(k), StringHash("trig"))) 
        call FlushChildHashtable(LS(), GetHandleId(k)) 
        call PauseTimer(k) 
        call DestroyTimer(k) 
        call DestroyGroup(g) 
        call PauseUnit(l, false) 
        call SetUnitTimeScale(l, 1.0) 
        call SetUnitAnimation(l, "stand") 
    endif 

    call RemoveLocation(a) 
    call SetUnitX(l, GetLocationX(b)) 
    call SetUnitY(l, GetLocationY(b)) 
    call RemoveLocation(b) 
    set udg_TempUnit2 = l 
    call ForGroup(g, function Charge_DragAlong) 
endfunction 

function Charge_Damage takes nothing returns nothing 
    local trigger t = GetTriggeringTrigger() 
    local unit a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) 
    local unit b = GetTriggerUnit() 
    local group g = LoadGroupHandle(LS(), GetHandleId(t), StringHash("draggroup")) 
    if not(IsUnitInGroup(b, g)) and GetUnitAbilityLevel(GetTriggerUnit(), 'Avul') == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 then 
        call UnitDamageTarget(a, GetTriggerUnit(), 155, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
        call GroupAddUnit(g, b) 
        call SaveReal(LS(), GetHandleId(b), StringHash("DragGroupXOffset_" + I2S(GetUnitAN(a))), GetUnitX(b) -GetUnitX(a)) 
        call SaveReal(LS(), GetHandleId(b), StringHash("DragGroupYOffset_" + I2S(GetUnitAN(a))), GetUnitY(b) -GetUnitY(a)) 
        call SaveBoolean(LS(), GetHandleId(b), StringHash("DragGroupDraggable_" + I2S(GetUnitAN(a))), true) 
        set bj_lastCreatedEffect = AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", b, "origin") 
        call SFXThreadClean() 
    endif 
endfunction 

function Trig_Charge_Actions takes nothing returns nothing 
    local unit b = GetSpellAbilityUnit() 
    local timer k = CreateTimer() 
    local trigger t = CreateTrigger() 
    local group g = CreateGroup() 
    set udg_TempPoint = GetUnitLoc(b) 
    set udg_TempPoint2 = GetSpellTargetLoc() 
    set udg_TempBool = false 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
    call RemoveLocation(udg_TempPoint3) 
    call SaveInteger(LS(), GetHandleId(k), StringHash("i"), 0) 
    // call SaveInteger(LS(),GetHandleId(k),StringHash("r"),0) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), b) 
    call SaveGroupHandle(LS(), GetHandleId(k), StringHash("draggroup"), g) 
    call SaveGroupHandle(LS(), GetHandleId(t), StringHash("draggroup"), g) 
    call TimerStart(k, 0.04, true, function Charge_Slide) 
    call SaveTriggerHandle(LS(), GetHandleId(k), StringHash("trig"), t) 
    call TriggerRegisterUnitInRangeSimple(t, 100.0, b) 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), b) 
    call TriggerAddAction(t, function Charge_Damage) 
    call SaveBoolean(LS(), GetHandleId(k), StringHash("over"), false) 
    call PauseUnitForPeriod(b, 3.5) 
    call SetUnitTimeScale(b, 2.0) 
    call SetUnitAnimationByIndex(b, 3) 
    call PolledWait(3.5) 
    call SaveBoolean(LS(), GetHandleId(k), StringHash("over"), true) 
endfunction 

//=========================================================================== 
function InitTrig_Charge takes nothing returns nothing 
    set gg_trg_Charge = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Charge, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Charge, Condition(function Trig_Charge_Conditions)) 
    call TriggerAddAction(gg_trg_Charge, function Trig_Charge_Actions) 
endfunction 

