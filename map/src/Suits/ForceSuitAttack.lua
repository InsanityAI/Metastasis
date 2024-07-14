//===========================================================================
// Trigger: ForceSuitAttack
//===========================================================================
//TESH.scrollpos=30
//TESH.alwaysfold=0
function Trig_ForceSuitAttack_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetAttacker()) == 'h03L' and not udg_ForceSuit_LastAttackTime[GetUnitUserData(GetAttacker())]
endfunction

function ForceSuitAttack_Slide takes nothing returns nothing
    local timer k=GetExpiredTimer()
    local unit l=LoadUnitHandle((udg_hash) , GetHandleId(k) , StringHash("slide")) // INLINED!!
    local location a=GetUnitLoc(l)
    local location b=PolarProjectionBJ(a , 45.0 , GetUnitFacing(l))
    local real c=LoadReal((udg_hash) , GetHandleId(l) , StringHash("angle")) // INLINED!!
    local integer s=LoadInteger((udg_hash) , GetHandleId(l) , StringHash("sector")) // INLINED!!

    if GetLocationZ(b) > GetLocationZ(a) + 60.0 then
        call KillUnit(l)
    endif
    //if IsPointPathable(GetLocationX(b), GetLocationY(b), false) == false then
        //call KillUnit(l)
    //endif
    if not ( LocInSector(b , s) ) then
        call KillUnit(l)
    else
        call SetUnitX(l , GetLocationX(b))
        call SetUnitY(l , GetLocationY(b))
        //call SetUnitPositionLoc(l,b)
        call SetUnitFacing(l , c)
    endif
    call RemoveLocation(b)
    call RemoveLocation(a)
    if IsUnitDeadBJ(l) then
        call PauseTimer(k)
        call DestroyTimer(k)
    endif
endfunction

function ForceSuitAttack_Damage takes nothing returns nothing
    local trigger t=GetTriggeringTrigger()
    local unit a=LoadUnitHandle((udg_hash) , GetHandleId(t) , StringHash("unit")) // INLINED!!

    if GetUnitAbilityLevel(GetTriggerUnit() , 'Avul') == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle((udg_hash) , GetHandleId(t) , StringHash("caster")) != GetTriggerUnit() then // INLINED!!
        call KillUnit(a)
        call UnitDamageTarget(a , GetTriggerUnit() , 30.0 , true , true , ATTACK_TYPE_NORMAL , DAMAGE_TYPE_NORMAL , WEAPON_TYPE_WHOKNOWS)
        
        //Apply Corporal buff
        if ( GetUnitAbilityLevel(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(a))] , udg_RoleAbility[10]) == 1 ) then
            call UnitDamageTarget(a , GetTriggerUnit() , 5.0 , true , true , ATTACK_TYPE_NORMAL , DAMAGE_TYPE_NORMAL , WEAPON_TYPE_WHOKNOWS)
        endif
        
        if ( GetUnitAbilityLevel(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(a))] , 'A097') == 1 ) then
            call Push2(GetTriggerUnit() , 300.0 , 230.0 , GetUnitFacing(a))
        else
            call Push2(GetTriggerUnit() , 300.0 , 230.0 , AngleBetweenUnits(GetTriggerUnit() , udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(a))]))
        endif
        
        call DestroyTrigger(t)
    endif
endfunction

function ForceSuitAttack_Dies takes nothing returns nothing
    local trigger q=GetTriggeringTrigger()
    local trigger t=LoadTriggerHandle((udg_hash) , GetHandleId(q) , StringHash("t")) // INLINED!!
    call FlushChildHashtable((udg_hash) , GetHandleId(GetTriggerUnit())) // INLINED!!
    call FlushChildHashtable((udg_hash) , GetHandleId(q)) // INLINED!!
    call FlushChildHashtable((udg_hash) , GetHandleId(t)) // INLINED!!
    call DestroyTrigger(q)
    call DestroyTrigger(t)
endfunction

function ForceSuitAttack_EnableAttack takes nothing returns nothing
    local timer om=GetExpiredTimer()
    local integer unitId = LoadInteger((udg_hash) , GetHandleId(om) , StringHash("t"))
    set udg_ForceSuit_LastAttackTime[unitId]=false
    set om = null
endfunction

function Trig_ForceSuitAttack_Actions takes nothing returns nothing
    local timer k=CreateTimer()
    local trigger t=CreateTrigger()
    local trigger q=CreateTrigger()
    local timer om=CreateTimer()
    local location ob
    set udg_TempPoint = GetUnitLoc(GetAttacker())
    set udg_TempPoint2 = GetUnitLoc(GetAttackedUnitBJ())
    set udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint , - 30.0 , AngleBetweenPoints(udg_TempPoint , udg_TempPoint2))
    set ob = PolarProjectionBJ(udg_TempPoint3 , 22.5 , AngleBetweenPoints(udg_TempPoint , udg_TempPoint2) - 90.0)
    call RemoveLocation(udg_TempPoint3)
    set udg_TempPoint3 = ob
    set udg_TempBool = false
    call CreateNUnitsAtLoc(1 , 'e01J' , GetOwningPlayer(GetAttacker()) , udg_TempPoint3, AngleBetweenPoints(udg_TempPoint , udg_TempPoint2))
    call SaveInteger((udg_hash) , GetHandleId(GetLastCreatedUnit()) , StringHash("sector") , GetSector(udg_TempPoint)) // INLINED!!
    call SaveReal((udg_hash) , GetHandleId(GetLastCreatedUnit()) , StringHash("angle") , AngleBetweenPoints(udg_TempPoint , udg_TempPoint2)) // INLINED!!
    call TriggerRegisterUnitEvent(q , GetLastCreatedUnit() , EVENT_UNIT_DEATH)
    call TriggerAddAction(q , function ForceSuitAttack_Dies)
    call SaveTriggerHandle((udg_hash) , GetHandleId(q) , StringHash("t") , t) // INLINED!!
    call SaveUnitHandle((udg_hash) , GetHandleId(k) , StringHash("slide") , GetLastCreatedUnit()) // INLINED!!
    call TimerStart(k , 0.04 , true , function ForceSuitAttack_Slide)
    call TriggerRegisterUnitInRangeSimple(t , 80.0 , GetLastCreatedUnit())
    call SaveUnitHandle((udg_hash) , GetHandleId(t) , StringHash("unit") , GetLastCreatedUnit()) // INLINED!!
    call SaveUnitHandle((udg_hash) , GetHandleId(t) , StringHash("caster") , GetAttacker()) // INLINED!!
    call TriggerAddAction(t , function ForceSuitAttack_Damage)
    call SetUnitPathing(GetLastCreatedUnit() , false)
    call SetUnitPositionLoc(GetLastCreatedUnit() , udg_TempPoint3)
    call SetUnitX(GetLastCreatedUnit() , GetLocationX(udg_TempPoint3))
    call SetUnitY(GetLastCreatedUnit() , GetLocationY(udg_TempPoint3))
    call SaveInteger((udg_hash) , GetHandleId(om) , StringHash("t") , GetUnitUserData(GetAttacker())) // INLINED!!
    call SaveUnitHandle((udg_hash) , GetHandleId(om) , StringHash("a") , GetLastCreatedUnit()) // INLINED!!
    call TimerStart(om , 1.0 , false , function ForceSuitAttack_EnableAttack)
    set udg_ForceSuit_LastAttackTime[(GetUnitUserData((GetAttacker())))]=true
    call RemoveLocation(udg_TempPoint)
    call RemoveLocation(udg_TempPoint2)
    call RemoveLocation(udg_TempPoint3)
endfunction


//===========================================================================
function InitTrig_ForceSuitAttack takes nothing returns nothing
    set gg_trg_ForceSuitAttack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ForceSuitAttack , EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_ForceSuitAttack , Condition(function Trig_ForceSuitAttack_Conditions))
    call TriggerAddAction(gg_trg_ForceSuitAttack , function Trig_ForceSuitAttack_Actions)
endfunction