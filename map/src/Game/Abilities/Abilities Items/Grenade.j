//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Grenade_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A01D' ) ) then
        return false
    endif
    return true
endfunction

function DetermineNormal takes real x1, real y1, real offsetx, real offsety, real height returns real
local location a=Location(x1,y1+offsety)
    //local location b=Location(x1+offsetx,y1)
    
    if GetLocationZ(a)>height then
        call RemoveLocation(a)
        set a=null
        return 0.0
    else
        call RemoveLocation(a)
        set a=null
        return 90.0
    endif
    
endfunction

function Grenade_Slide takes nothing returns nothing
    local timer k=GetExpiredTimer()
    local unit l=LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide"))
    local real zvelocity=LoadReal(LS(),GetHandleId(k),StringHash("zvelocity"))
    local real c=LoadReal(LS(), GetHandleId(k), StringHash("angle"))
    local real height=LoadReal(LS(),GetHandleId(k),StringHash("height"))
    local real zforce=LoadReal(LS(),GetHandleId(k),StringHash("force"))
    local location a=GetUnitLoc(l)
    local location b=PolarProjectionBJ(a,zforce,c)

    call SetUnitFlyHeight(l,height-GetLocationZ(a),0)
    if GetLocationZ(b) > height then
        //If the collision is a result of the projectile falling then...
        if GetLocationZ(a) == GetLocationZ(b) then
            set height=GetLocationZ(b)
            set zvelocity=-0.5*zvelocity
        else
            if GetTerrainCliffLevelBJ(b)>GetTerrainCliffLevelBJ(a) then
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

    call SetUnitPositionLoc(l,b)
    call SetUnitFacing(l,c)
    call RemoveLocation(b)
    call RemoveLocation(a)
    
    if IsUnitDeadBJ(l) then
        call PauseTimer(k)
        call DestroyTimer(k)
    endif
    
    call SaveReal(LS(),GetHandleId(k),StringHash("height"),height+zvelocity/25.0)
    call SaveReal(LS(),GetHandleId(k),StringHash("zvelocity"),zvelocity-40)
    call SaveReal(LS(),GetHandleId(k),StringHash("angle"),c)
endfunction


function Trig_Grenade_Actions takes nothing returns nothing
    local timer k=CreateTimer()
    local real r
    local unit p=GetSpellAbilityUnit()

    if TimerGetElapsed(udg_GameTimer)-udg_Unit_LastGrenadeTime[GetUnitAN(p)]<1.0 then
        call DestroyTimer(k)
        return
    endif
    
    set udg_Unit_LastGrenadeTime[GetUnitAN(p)]=TimerGetElapsed(udg_GameTimer)
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    set udg_TempPoint2 = GetSpellTargetLoc()
    set r=DistanceBetweenPoints(udg_TempPoint,udg_TempPoint2)
    if r > 900.0 then
        set r=900.0
        set udg_TempPoint4=PolarProjectionBJ(udg_TempPoint,900.0,AngleBetweenPoints(udg_TempPoint,udg_TempPoint2))
        call BasicAI_IssueDangerArea(udg_TempPoint4,220.0,2.1)
        call RemoveLocation(udg_TempPoint4)
    else
        call BasicAI_IssueDangerArea(udg_TempPoint2,220.0,2.1)
    endif
    
    call SetUnitAnimation(GetSpellAbilityUnit(),"spell throw")
        call SaveReal(LS(),GetHandleId(k),StringHash("height"),GetLocationZ(udg_TempPoint))
            call SaveReal(LS(),GetHandleId(k),StringHash("force"),r/900.0*450/25.0)
    set udg_TempBool = false
    call CreateNUnitsAtLoc( 1, 'e007', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) )
    call RemoveLocation( udg_TempPoint )
    call RemoveLocation( udg_TempPoint2 )
    call RemoveLocation( udg_TempPoint3 )
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
    call TimerStart(k,0.04,true,function Grenade_Slide)
    call SaveReal(LS(),GetHandleId(k),StringHash("angle"),GetUnitFacing(GetLastCreatedUnit()))
    call SaveReal(LS(),GetHandleId(k),StringHash("zvelocity"),500.0)
endfunction

//===========================================================================
function InitTrig_Grenade takes nothing returns nothing
    set gg_trg_Grenade = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Grenade, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Grenade, Condition( function Trig_Grenade_Conditions ) )
    call TriggerAddAction( gg_trg_Grenade, function Trig_Grenade_Actions )
endfunction

