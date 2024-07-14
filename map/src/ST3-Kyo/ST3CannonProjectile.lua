function Trig_Cannon_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A005' ) ) then
        return false
    endif
    return true
endfunction

function Cannon_Slide takes nothing returns nothing
    local timer k=GetExpiredTimer()
    local unit l=LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide"))
    local location a=GetUnitLoc(l)
    local unit oq=LoadUnitHandle(LS(), GetHandleId(k), StringHash("target"))
    local location i=GetUnitLoc(oq)
    local real q=AngleBetweenPoints(a,i)
    local location b=PolarProjectionBJ(a,4.8,GetUnitFacing(l))
    if RectContainsUnit(gg_rct_Space,oq)==false then
        call SaveUnitHandle(LS(),GetHandleId(k),StringHash("target"),gg_unit_h008_0196)
    endif
    if IsUnitDeadBJ(oq) then
        set oq = gg_unit_h008_0196
        call SaveUnitHandle(LS(),GetHandleId(k),StringHash("target"),oq)
    endif

    call SetUnitX(l, GetLocationX(b))
    call SetUnitY(l, GetLocationY(b))
    call SetUnitFacingTimed(l,q,0.75)
    call RemoveLocation(b)
    call RemoveLocation(a)
    call RemoveLocation(i)
    if IsUnitDeadBJ(l) then
        call PauseTimer(k)
        call DestroyTimer(k)
    endif
endfunction

function Cannon_Damage takes nothing returns nothing
    local trigger t=GetTriggeringTrigger()
    local integer i=0
    local unit a=LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit"))
    local unit b=GetTriggerUnit()
    if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul')==0 and IsUnitStation(GetTriggerUnit())==true and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() and udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==false then
        call SetUnitAnimation(a,"death")
        call SizeUnitOverTime(a,5.5,3.0,0.1,true)
        call DestroyTrigger(t)
        call DamageUnitOverTime(b,a,5.0,200000)
    endif
endfunction

function Cannon_Dies takes nothing returns nothing
    local trigger q=GetTriggeringTrigger()
    local trigger t=LoadTriggerHandle(LS(), GetHandleId(q), StringHash("t"))
    local trigger o=LoadTriggerHandle(LS(), GetHandleId(q), StringHash("o"))
    call FlushChildHashtable(LS(), GetHandleId(GetTriggerUnit()))
    call FlushChildHashtable(LS(), GetHandleId(q))
    call FlushChildHashtable(LS(), GetHandleId(t))
    call FlushChildHashtable(LS(), GetHandleId(o))
    call DestroyTrigger(q)
    call DestroyTrigger(t)
    call DestroyTrigger(o)
endfunction

function Trig_Cannon_Actions takes nothing returns nothing
    local timer k=CreateTimer()
    local trigger t=CreateTrigger()
    local trigger q=CreateTrigger()
    local unit b=GetSpellTargetUnit()
    local unit c=GetSpellAbilityUnit()
    local unit kyoBallOfDoomUnit
    set udg_TempPoint2 = GetUnitLoc(GetSpellTargetUnit())
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    set udg_TempPoint3=PolarProjectionBJ(udg_TempPoint,0.0,AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
    set udg_TempBool = false
    set kyoBallOfDoomUnit = CreateUnitAtLoc(Player(15), 'e00Z', udg_TempPoint3, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) )
    call SetUnitFlyHeight(kyoBallOfDoomUnit,60.0,100.0)
    call SaveReal(LS(), GetHandleId(kyoBallOfDoomUnit), StringHash("angle"),AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))  

    call TriggerRegisterUnitEvent(q, kyoBallOfDoomUnit, EVENT_UNIT_DEATH)
    call TriggerAddAction(q,function Cannon_Dies)
    call SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t)
    call RemoveLocation( udg_TempPoint )
    call RemoveLocation( udg_TempPoint2 )
    call RemoveLocation( udg_TempPoint3 )
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), kyoBallOfDoomUnit)
    call TimerStart(k,0.04,true,function Cannon_Slide)
    call TriggerRegisterUnitInRangeSimple(t,100.0, kyoBallOfDoomUnit)
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("target"), b)
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), kyoBallOfDoomUnit)
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), c)   
    call TriggerAddAction(t, function Cannon_Damage)
    call SetUnitPathing(kyoBallOfDoomUnit, false)

    // Who the fuck added these 4 lines, not only does the KYO missile hang in the air for 40 seconds
    // before firing off, but also it makes HP Bars disappear! And because of the condition it activates only for 1.29+ versions!
    // if (JASS_MAX_ARRAY_SIZE > 8200) then
    //     call PolledWait(40.0)//Ytrec, this line literally crashes reforge. I hope you notice it :P
    //     call EnablePreSelect( false, false )
    // endif

endfunction

//===========================================================================
function InitTrig_ST3CannonProjectile takes nothing returns nothing
    set gg_trg_ST3CannonProjectile = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ST3CannonProjectile, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ST3CannonProjectile, Condition( function Trig_Cannon_Conditions ) )
    call TriggerAddAction( gg_trg_ST3CannonProjectile, function Trig_Cannon_Actions )
endfunction
