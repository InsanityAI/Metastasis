function Trig_BGrenade_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A06O')) then 
        return false 
    endif 
    return true 
endfunction 

function BGrenade_Slide takes nothing returns nothing 
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
            set zvelocity = -0.5 * zvelocity 
        else 
            if GetTerrainCliffLevelBJ(b) > GetTerrainCliffLevelBJ(a) then 
                call KillUnit(l) 
            endif 
            //Else the collision is a result of the terrain 
            //set height=GetLocationZ(b) 
            //set zvelocity=-0.5*zvelocity 
            //set c= 360+2*DetermineNormal(GetUnitX(l),GetUnitY(l),zforce*Cos(GetUnitFacing(l)*bj_DEGTORAD),zforce*Sin(GetUnitFacing(l)*bj_DEGTORAD),height)-c 
        endif 
    endif 
    //if IsPointPathable(GetLocationX(b), GetLocationY(b), false) == false then 
    //call KillUnit(l) 
    //endif 
    call SetUnitPositionLoc(l, b) 
    call SetUnitFacing(l, c) 
    call RemoveLocation(b) 
    call RemoveLocation(a) 
    if IsUnitDeadBJ(l) then 
        call PauseTimer(k) 
        call DestroyTimer(k) 
    endif 
    call SaveReal(LS(), GetHandleId(k), StringHash("height"), height + zvelocity / 25.0) 
    call SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), zvelocity - 40) 
    call SaveReal(LS(), GetHandleId(k), StringHash("angle"), c) 
endfunction 


function Trig_BGrenade_Actions takes nothing returns nothing 
    local timer k = CreateTimer() 
    local real r 
    local unit p = GetSpellAbilityUnit() 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempPoint2 = GetSpellTargetLoc() 
    set r = DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2) 
    if r > 900.0 then 
        set r = 900.0 
    endif 
    call SetUnitAnimation(GetSpellAbilityUnit(), "spell throw") 
    call SaveReal(LS(), GetHandleId(k), StringHash("height"), GetLocationZ(udg_TempPoint)) 
    call SaveReal(LS(), GetHandleId(k), StringHash("force"), r / 900.0 * 225 / 25.0 * GetRandomReal(0.5, 2)) 
    set udg_TempBool = false 
    call CreateNUnitsAtLoc(1, 'e007', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) + GetRandomReal(-15.0, 15.0)) 
    call RemoveLocation(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint2) 
    call RemoveLocation(udg_TempPoint3) 
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit()) 
    call TimerStart(k, 0.04, true, function BGrenade_Slide) 
    call SaveReal(LS(), GetHandleId(k), StringHash("angle"), GetUnitFacing(GetLastCreatedUnit())) 
    call SaveReal(LS(), GetHandleId(k), StringHash("zvelocity"), 500.0 + GetRandomReal(-150.0, 150.0)) 
    call UnitAddAbility(GetLastCreatedUnit(), 'A03G') 
    call UnitApplyTimedLife(GetLastCreatedUnit(), 'B000', 4 + GetRandomReal(-0.6, 0.6)) 
endfunction 

function BGrenade takes nothing returns nothing 
    local integer i = 0 
    loop 
        exitwhen i > 7 
        call Trig_BGrenade_Actions() 
        set i = i + 1 
    endloop 
endfunction 

//=========================================================================== 
function InitTrig_BurstGrenade takes nothing returns nothing 
    set gg_trg_BurstGrenade = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_BurstGrenade, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_BurstGrenade, Condition(function Trig_BGrenade_Conditions)) 
    call TriggerAddAction(gg_trg_BurstGrenade, function BGrenade) 
endfunction 

