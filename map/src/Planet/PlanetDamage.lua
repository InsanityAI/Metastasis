//TESH.scrollpos=67
//TESH.alwaysfold=0
function RedoArray takes integer start, integer end, integer hashid returns integer
local integer i=start
local integer b=start
local location eval
loop
exitwhen i > end
set eval=LoadLocationHandle(LS(), hashid, i)
if eval != null then
call SaveLocationHandle(LS(), hashid,b,eval)
set b=b+1
endif
set i=i+1
endloop
return b
endfunction

function Trig_PlanetDamage_Func002Func011Func001Func001C takes nothing returns boolean
    if GetDestructableTypeId(GetEnumDestructable()) == 'DTrx' then
        return false
    endif
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'YT40' ) ) then
        return false
    endif
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'YT16' ) ) then
        return false
    endif
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'YT30' ) ) then
        return false
    endif
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'YT06' ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlanetDamage_Func002Func011Func001C takes nothing returns boolean
    return Trig_PlanetDamage_Func002Func011Func001Func001C()
endfunction

function Trig_PlanetDamage_Func002Func011A takes nothing returns nothing
    if ( Trig_PlanetDamage_Func002Func011Func001C() ) then
        call KillDestructable( GetEnumDestructable() )
    else
    endif
        if GetDestructableTypeId(GetEnumDestructable()) == 'B006' then
    call RemoveDestructable(GetEnumDestructable())
    endif
endfunction
function PBomb_Cleanup takes nothing returns nothing
local timer k=GetExpiredTimer()
call DestroyEffect(LoadEffectHandle(LS(), GetHandleId(k), StringHash("ti")))
call FlushChildHashtable(LS(), GetHandleId(k))
call DestroyTimer(k)
endfunction

function PBomb_SFXClean takes nothing returns nothing
local timer k=CreateTimer()
call SaveEffectHandle(LS(), GetHandleId(k), StringHash("ti"), GetLastCreatedEffectBJ())
call TimerStart(k,10.0,false,function PBomb_Cleanup)
endfunction
function PBombardment_Damage takes nothing returns nothing
if IsUnitExplorer(GetEnumUnit()) then
call UnitDamageTarget(GetEventDamageSource(),GetEnumUnit(), 10000.0,true,false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
else
        call UnitDamageTarget(GetEventDamageSource(),GetEnumUnit(), 4900.0,true,false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        endif
endfunction

function Trig_PlanetDamage_Actions takes nothing returns nothing
local location a
local real h
local integer d
    set udg_MinerthaDamageCounter = ( udg_MinerthaDamageCounter + GetEventDamage() )
    loop
        exitwhen udg_MinerthaDamageCounter < 30000
        set udg_MinerthaDamageCounter = ( udg_MinerthaDamageCounter - 30000.00 )
        set udg_TempPoint=GetRandomLocInRect(gg_rct_Planet)
        ///set udg_TempInt=GetRandomInt(1,udg_PlanetBombardmentPool_End)

        //Swaggerboi
            //This was almost at the bottom.
            //Tbh, swagger should take a lot less dmg when in minertha, cuz atmosphere y'know.
            //Though, swagger should take normal dmg methinks, but the dmg it takes, doesnt fall to the planet? -> wtf m8, planetary shield? xD
            if udg_Swagger_Grounded == true and IsUnitAliveBJ(gg_unit_h00X_0049) then
                call UnitDamageTarget(GetEventDamageSource(), gg_unit_h00X_0049, 20000,true,false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
                set h=GetUnitState(gg_unit_h00X_0049,UNIT_STATE_LIFE)/20000.0
                    if I2R(R2I(h))==h then
                        set d=R2I(h)
                    else
                        set d=R2I(h)+1
                    endif
                call DisplayTextToForce(GetPlayersAll(), "|cffFF0000WARNING: Atmospheric disturbance is damaging U.S.I. Swagger hull integrity. An immediate launch is recommended. Estimated " + I2S(d) + " impacts remaining before hull integrity failure.")
            endif
        
        //set udg_TempPoint = LoadLocationHandle(LS(), GetHandleId(gg_trg_PlanetDamage),udg_TempInt)
        //call SaveLocationHandle(LS(), GetHandleId(gg_trg_PlanetDamage),udg_TempInt,null)
       // set udg_PlanetBombardmentPool_End= RedoArray(1,udg_PlanetBombardmentPool_End, GetHandleId(gg_trg_PlanetDamage))
        //if udg_TempPoint==null or (GetLocationX(udg_TempPoint)==0 and GetLocationY(udg_TempPoint)==0) then
        //set udg_TempPoint=GetRandomLocInRect(gg_rct_Planet)
        //endif
        set a=udg_TempPoint
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd = 36
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            set udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, 600.00, ( 10.00 * I2R(GetForLoopIndexB()) ))
            call AddSpecialEffectLocBJ( udg_TempPoint2, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl" )
            //call ExecuteFunc( "SFXClean" )
            call PBomb_SFXClean()
            call RemoveLocation( udg_TempPoint2 )
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
        set udg_MinerthaDamagePerSecond=udg_MinerthaDamagePerSecond+3.0
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd = 36
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            set udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, GetRandomReal(0, 590.00), GetRandomDirectionDeg())
            call AddSpecialEffectLocBJ( udg_TempPoint2, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl" )
            //call ExecuteFunc( "SFXClean" )
            call PBomb_SFXClean()
            call RemoveLocation( udg_TempPoint2 )
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop        
        call PingMinimapLocForForceEx( GetPlayersAll(), udg_TempPoint, 10.00, bj_MINIMAPPINGSTYLE_SIMPLE, 25.00, 25.00, 100 )
        
        
        call PolledWait( 10.00 )
        
        
        set udg_TempPoint=a
        call CreateNUnitsAtLoc( 1, 'e00E', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
        call SetUnitScalePercent( GetLastCreatedUnit(), 200.00, 200.00, 200.00 )
        call SetUnitTimeScalePercent( GetLastCreatedUnit(), 75.00 )
        //set bj_forLoopBIndex = 1
        //set bj_forLoopBIndexEnd = 36
        //loop
        //    exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        //    set udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, GetRandomReal(0.00, 600.00), GetRandomDirectionDeg())
        //    call AddSpecialEffectLocBJ( udg_TempPoint2, "Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl" )
        //    //call ExecuteFunc( "SFXClean" )
        //    call PBomb_SFXClean()
        //    call RemoveLocation( udg_TempPoint2 )
        //    set bj_forLoopBIndex = bj_forLoopBIndex + 1
        //endloop
        call EnumDestructablesInCircleBJ( 712.00, udg_TempPoint, function Trig_PlanetDamage_Func002Func011A )
        set udg_TempUnitGroup=GetUnitsInRangeOfLocAll(600.0, udg_TempPoint)
        call ForGroup(udg_TempUnitGroup, function PBombardment_Damage)
        call DestroyGroup(udg_TempUnitGroup)
        call TerrainDeformationCraterBJ( 0.50, true, udg_TempPoint, 600.00, 128.00 )
        call SetBlightRadiusLocBJ( true, Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, 600.00 )
        call SetUnitTimeScalePercent(CreateUnitAtLoc(Player(PLAYER_NEUTRAL_AGGRESSIVE), 'e014', udg_TempPoint, GetRandomDirectionDeg()), 0.0)
        call RemoveLocation( udg_TempPoint )
        
    endloop
    call SetUnitManaBJ(gg_unit_h008_0196, udg_MinerthaDamageCounter)
endfunction

//===========================================================================
function InitTrig_PlanetDamage takes nothing returns nothing
//ocal integer x=0
//local integer y=1
//local integer end=1
    set gg_trg_PlanetDamage = CreateTrigger(  )
//loop
//exitwhen x >= 19
//set x=x+1
//set y=0
//loop
//exitwhen y >= 21
//set y=y+1
//call SaveLocationHandle(LS(),GetHandleId(gg_trg_PlanetDamage),end, Location(3726+424*(x),1693+424*(y)))
//set end=end+1
//endloop
//endloop
//set udg_PlanetBombardmentPool_End=end
    call TriggerRegisterUnitEvent( gg_trg_PlanetDamage, gg_unit_h008_0196, EVENT_UNIT_DAMAGED )
    call TriggerAddAction( gg_trg_PlanetDamage, function Trig_PlanetDamage_Actions )
endfunction

