//TESH.scrollpos=102
//TESH.alwaysfold=0
//Spell by: FelFox
// Tripwire
//Functions below are used for configuration of this spell.
//Sidenote: I had to gut most of my own spell to make it work for Metastasis.
function Trip_AbilCode takes nothing returns integer
return 'A05B'
//The rawcode of the spell.
endfunction

function Trip_Damage takes nothing returns real
return 160.0
//The damage the tripping unit takes.
endfunction

function Trip_TripDuration takes nothing returns real
return 2.0
//The duration for which the unit that trips the wire lies on the ground.
endfunction


function Trip_LightningCode takes nothing returns string
return "DRAL"
//The lightning's code.
endfunction

function Trip_MaxDist takes nothing returns real
return 900.0
//Maximum distance between two trees that can be wired.
endfunction


//Spell Engine
//Do not edit beyond this point on pain of death.
//
//

function Trip_RegionAddLineSeg takes region whichRegion, real x1, real y1, real x2, real y2 returns nothing
    local real dist = SquareRoot((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
    local real xdist = x2 - x1
    local real ydist = y2 - y1
    loop
        exitwhen x1 > x2 and xdist > 0
        exitwhen x2 > x1 and xdist < 0
        exitwhen y1 > y2 and ydist > 0
        exitwhen y2 > y1 and ydist < 0
        call RegionAddCell(whichRegion, x1, y1)
        exitwhen dist == 0
        set x1 = x1 + 32 * (xdist/dist)
        set y1 = y1 + 32 * (ydist/dist)
    endloop
//Function by Shvegait. [http://wc3jass.com/viewtopic.php?t=282]
endfunction

function Trip_AbilCheck takes nothing returns boolean
if GetSpellAbilityId()==Trip_AbilCode() then
     return true
endif
     return false
endfunction

function TripCollide takes nothing returns nothing
  local unit targetone=LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("target1"))
  local unit targettwo=LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()),StringHash("target2"))
  local lightning d=LoadLightningHandle(LS(), GetHandleId(targettwo),StringHash("lightning"))
  local unit f=GetTriggerUnit()
  local player p=LoadPlayerHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("wo"))
  if GetUnitPointValue(f) != 37 and GetUnitState(f,UNIT_STATE_LIFE)>0.00 and GetUnitAbilityLevel(f,'Avul')==0 and IsUnitType(f,UNIT_TYPE_MAGIC_IMMUNE)==false and udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(f))]==false and GetOwningPlayer(f) != Player(14) and GetOwningPlayer(f) != udg_Parasite and IsUnitType(f,UNIT_TYPE_FLYING)==false then
        call UnitDamageTarget(udg_Playerhero[GetConvertedPlayerId(p)], f, Trip_Damage(), true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
     call PauseUnit(GetTriggerUnit(),true)
     call SetUnitAnimation(GetTriggerUnit(),"death")
     call KillUnit(targetone)
     call PolledWait(Trip_TripDuration())
     call PauseUnit(f,false)

if GetUnitState(f,UNIT_STATE_LIFE)>0.00 then
     call SetUnitAnimation(f,"stand")
endif
endif
set targetone=null
set targettwo=null
set f=null
set d=null
set p=null
endfunction

function TripDisable takes nothing returns nothing
local trigger g=LoadTriggerHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("t"))
  local unit targetone=LoadUnitHandle(LS(), GetHandleId(g), StringHash("target1"))
  local unit targettwo=LoadUnitHandle(LS(), GetHandleId(g),StringHash("target2"))
  local lightning d=LoadLightningHandle(LS(), GetHandleId(targettwo),StringHash("lightning"))
  call DestroyTrigger(GetTriggeringTrigger())
call KillUnit(targetone)
call KillUnit(targettwo)
     call RemoveRegion(LoadRegionHandle(LS(), GetHandleId(g),StringHash("region")))
     call FlushChildHashtable(LS(), GetHandleId(GetTriggeringTrigger()))
     call FlushChildHashtable(LS(), GetHandleId(d))
     call DestroyLightning(d)
     call FlushChildHashtable(LS(), GetHandleId(targetone))
     call FlushChildHashtable(LS(), GetHandleId(targettwo))
     endfunction
function TripAct2 takes nothing returns nothing
local unit q=GetSpellAbilityUnit()
  local unit targetone=LoadUnitHandle(LS(), GetHandleId(q), StringHash("target1"))
  local unit targettwo=CreateUnit(Player(15),'e01B',GetSpellTargetX(), GetSpellTargetY(), GetRandomDirectionDeg())
    local location a=GetUnitLoc(targetone)
  local location b=GetUnitLoc(targettwo)
  local lightning d=AddLightningEx(Trip_LightningCode(),false,GetUnitX(targetone),GetUnitY(targetone),GetLocationZ(a)+20.0,GetUnitX(targettwo),GetUnitY(targettwo),GetLocationZ(b)+20.0)
  local trigger triptrigger=CreateTrigger()
  local region hitrect=CreateRegion()
  local trigger disabletrigger=CreateTrigger()
  call SaveBoolean(LS(), GetHandleId(d), StringHash("w"),true)
  call RemoveLocation(a)
  call RemoveLocation(b)
  set a=null
  set b=null
  call TriggerRegisterUnitEvent(disabletrigger,targetone,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(disabletrigger,targettwo,EVENT_UNIT_DEATH)
call TriggerAddAction(disabletrigger, function TripDisable)
call SaveTriggerHandle(LS(), GetHandleId(disabletrigger), StringHash("t"), triptrigger)
     call Trip_RegionAddLineSeg(hitrect,GetUnitX(targettwo),GetUnitY(targettwo),GetUnitX(targetone),GetUnitY(targetone))
     call SaveUnitHandle(LS(), GetHandleId(triptrigger),StringHash("target1"),targetone)
     call SaveUnitHandle(LS(), GetHandleId(triptrigger),StringHash("target2"),targettwo)
     call SaveLightningHandle(LS(), GetHandleId(targettwo),StringHash("lightning"),d)
     call SaveUnitHandle(LS(), GetHandleId(q),StringHash("target1"),udg_TheNullUnit)
     call SaveRegionHandle(LS(), GetHandleId(triptrigger),StringHash("region"),hitrect)
     call SavePlayerHandle(LS(), GetHandleId(triptrigger),StringHash("wo"),GetOwningPlayer(GetSpellAbilityUnit()))
     call TriggerAddAction(triptrigger,function TripCollide)
     call TriggerRegisterEnterRegion(triptrigger,hitrect,null)
set triptrigger=null
set hitrect=null
call LoopDynamicLightningVisibility(d,GetUnitX(targetone), GetUnitY(targetone), GetUnitX(targettwo), GetUnitY(targettwo))
endfunction

function TripAct takes nothing returns nothing
local unit q=GetSpellAbilityUnit()
  local unit targetone=CreateUnit(Player(15),'e01B',GetSpellTargetX(), GetSpellTargetY(), GetRandomDirectionDeg())
     call SaveUnitHandle(LS(), GetHandleId(q),StringHash("target1"),targetone)
endfunction

function TripDirectAct takes nothing returns nothing
  local unit v=LoadUnitHandle(LS(), GetHandleId(GetSpellAbilityUnit()),StringHash("target1"))
  local location a=GetUnitLoc(v)
  local location b=GetSpellTargetLoc()
  local player o=GetOwningPlayer(GetSpellAbilityUnit())
  if o==Player(14) then
  set o=udg_Parasite
  endif
if v==udg_TheNullUnit or v==null then
     call TripAct()
elseif DistanceBetweenPoints(a,b) <= Trip_MaxDist() then
     call TripAct2()
else
     call SetUnitState(GetSpellAbilityUnit(),UNIT_STATE_MANA,GetUnitState(GetSpellAbilityUnit(),UNIT_STATE_MANA)+15)
     call DisplayTextToPlayer(o,0.0,0.0,"|cffffcc00The selected points are too far apart.")
     call PingMinimapForPlayer(o,GetUnitX(v),GetUnitY(v),4.0)
     endif
     call RemoveLocation(a)
     call RemoveLocation(b)
     set a=null
     set b=null
endfunction
//===========================================================================
function InitTrig_Tripwire takes nothing returns nothing
    set gg_trg_Tripwire = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Tripwire, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Tripwire, Condition( function Trip_AbilCheck) )
    call TriggerAddAction( gg_trg_Tripwire, function TripDirectAct )
endfunction

