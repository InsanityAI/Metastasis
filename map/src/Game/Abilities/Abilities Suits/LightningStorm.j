function Trig_LightningStorm_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A092')) then 
        return false 
    endif 
    return true 
endfunction 

function LightningAI_ScoreUnit takes unit q, unit consider returns real 
    local real retz = 0.0 
    set retz = retz - DistanceBetweenUnits(consider, q) / 600.0 
    set retz = retz - 5 * B2I(IsUnitType(consider, UNIT_TYPE_STRUCTURE)) 
    return retz 
endfunction 

function LightningRange_ConsiderTargets takes unit q returns unit 
    //Considers all groups within a range of acquirerange and returns the best target, will return null if none 
    local group g 
    local group m 
    local real acquirerange = 350.0 
    local unit target = null 
    local unit consider 
    local real score 
    local location a 
    set a = GetUnitLoc(q) 
    set g = GetUnitsInRangeOfLocAll(acquirerange, a) 
    call RemoveLocation(a) 
    set m = CreateGroup() 
    loop 
        exitwhen FirstOfGroup(g) == null 
        set consider = FirstOfGroup(g) 
        if consider != q and GetUnitAbilityLevel(consider, 'Avul') == 0 and IsUnitAliveBJ(consider) and GetUnitTypeId(consider) != 'n00A' then 
            call GroupAddUnit(m, consider) 
        endif 
        call GroupRemoveUnit(g, consider) 
    endloop 
    call DestroyGroup(g) 
    if CountUnitsInGroup(m) > 0 then 
        if CountUnitsInGroup(m) > 1 then 
            set score = -999 
            loop 
                exitwhen FirstOfGroup(m) == null 
                set consider = FirstOfGroup(m) 
                if score <= LightningAI_ScoreUnit(q, consider) then 
                    set target = consider 
                    set score = LightningAI_ScoreUnit(q, consider) 
                endif 
                call GroupRemoveUnit(m, consider) 
            endloop 
        else 
            set target = FirstOfGroup(m) 
        endif 
    endif 
    call DestroyGroup(m) 
    return target 
endfunction 

function LightningStorm_Callback takes nothing returns nothing 
    local timer t = GetExpiredTimer() 
    local unit target = null 
    local unit lasttarget = LoadUnitHandle(LS(), GetHandleId(t), StringHash("lt")) 
    local unit l = LoadUnitHandle(LS(), GetHandleId(t), StringHash("l")) 
    if IsUnitDeadBJ(l) then 
        call PauseTimer(t) 
        call FlushChildHashtable(LS(), GetHandleId(t)) 
        call DestroyTimer(t) 
        call PolledWait(4.0) 
        call RemoveUnit(l) 
    else 
        set target = LightningRange_ConsiderTargets(l) 
        if target != lasttarget then 
            call IssueTargetOrder(l, "attack", target) 
            set lasttarget = target 
            call SaveUnitHandle(LS(), GetHandleId(t), StringHash("lt"), lasttarget) 
        endif 
    endif 
endfunction 

function LightningStorm takes unit l returns nothing 
    local unit target = null 
    local unit lasttarget = null 
    local timer t = CreateTimer() 
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("l"), l) 
    call TimerStart(t, 0.5, true, function LightningStorm_Callback) 
endfunction 

function LightningStorm_Slide takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local unit l = LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide")) 
    local real zvelocity = LoadReal(LS(), GetHandleId(k), StringHash("zvelocity")) 
    local real c = LoadReal(LS(), GetHandleId(k), StringHash("angle")) 
    local real height = LoadReal(LS(), GetHandleId(k), StringHash("height")) 
    local real zforce = LoadReal(LS(), GetHandleId(k), StringHash("force")) 
    local location a = GetUnitLoc(l) 
    local location b = PolarProjectionBJ(a, zforce, c) 
    call SetUnitFlyHeight(l, height - GetLocationZ(a), 0) 
    if GetLocationZ(b) > height then 
        //If the collision is a result of the projectile falling then... 
        if GetLocationZ(a) == GetLocationZ(b) then 
            set height = GetLocationZ(b) 
            set zvelocity = -1.0 * zvelocity 
        else 
            if GetTerrainCliffLevelBJ(b) > GetTerrainCliffLevelBJ(a) then 
                call KillUnit(l) 
            endif 
        endif 
    endif 
    call SetUnitPositionLoc(l, b) 
    call SetUnitFacing(l, c) 
    call RemoveLocation(b) 
    call RemoveLocation(a) 
    if IsUnitDeadBJ(l) then 
        call PauseTimer(k) 
        call DestroyTimer(k) 
        set udg_TempUnit = l 
        set udg_TempPoint = GetUnitLoc(l) 
        set bj_lastCreatedUnit = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), 'h01Q', udg_TempPoint, GetRandomDirectionDeg()) 
        call LightningStorm(GetLastCreatedUnit()) 
        call RemoveLocation(udg_TempPoint) 
        call DestroyGroup(udg_TempUnitGroup) 
        call CreateScaledEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl", 4.0, 4.0, GetUnitX(l), GetUnitY(l)) 
        return 
    endif 
    call SaveReal(LS(), GetHandleId(k), StringHash("height"), height + zvelocity / 25.0) 
    call SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), zvelocity - 50) 
    call SaveReal(LS(), GetHandleId(k), StringHash("angle"), c) 
endfunction 


function Trig_LightningStorm_Actions takes nothing returns nothing 
    local timer k = CreateTimer() 
    local real r 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempPoint2 = GetSpellTargetLoc() 
    set r = DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2) 
    if r > 900.0 then 
        set r = 900.0 
    endif 
    call SetUnitAnimation(GetSpellAbilityUnit(), "spell throw") 
    call SaveReal(LS(), GetHandleId(k), StringHash("height"), GetLocationZ(udg_TempPoint)) 
    call SaveReal(LS(), GetHandleId(k), StringHash("force"), r / 900.0 * 675 / 25.0) 
    set udg_TempBool = false 
    call CreateNUnitsAtLoc(1, 'e037', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2)) 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
    call RemoveLocation(udg_TempPoint3) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit()) 
    call TimerStart(k, 0.04, true, function LightningStorm_Slide) 
    call SaveReal(LS(), GetHandleId(k), StringHash("angle"), GetUnitFacing(GetLastCreatedUnit())) 
    call SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), 450.0) 


endfunction 

//=========================================================================== 
function InitTrig_LightningStorm takes nothing returns nothing 
    set gg_trg_LightningStorm = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LightningStorm, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_LightningStorm, Condition(function Trig_LightningStorm_Conditions)) 
    call TriggerAddAction(gg_trg_LightningStorm, function Trig_LightningStorm_Actions) 
endfunction 

