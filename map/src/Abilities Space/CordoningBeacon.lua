//TESH.scrollpos=178
//TESH.alwaysfold=0
//Spell by: FelFox
// Tripwire
//Functions below are used for configuration of this spell.
//Sidenote: I had to gut most of my own spell to make it work for Metastasis.
function Cord_AbilCode takes nothing returns integer
return 'A07A'
//The rawcode of the spell.
endfunction

function Cord_Damage takes nothing returns real
return 160.0
//The damage the tripping unit takes.
endfunction

function Cord_CordDuration takes nothing returns real
return 2.0
//The duration for which the unit that trips the wire lies on the ground.
endfunction


function Cord_LightningCode takes nothing returns string
return "AWES"
//The lightning's code.
endfunction

function Cord_MaxDist takes nothing returns real
return 3100.0
//Maximum distance between two trees that can be wired.
endfunction


//Spell Engine
//Do not edit beyond this point on pain of death.
//
//

function Cord_RegionAddLineSeg takes region whichRegion, real x1, real y1, real x2, real y2 returns nothing
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
        set x1 = x1 + 16 * (xdist/dist)
        set y1 = y1 + 16 * (ydist/dist)
    endloop
//Function by Shvegait. [http://wc3jass.com/viewtopic.php?t=282]
endfunction

function Cord_AbilCheck takes nothing returns boolean
if GetSpellAbilityId()==Cord_AbilCode() then
     return true
endif
     return false
endfunction

function CordPush_Determine takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit f=LoadUnitHandle(LS(),GetHandleId(k),StringHash("f"))
local location r=LoadLocationHandle(LS(),GetHandleId(k),StringHash("r"))
local location b=GetUnitLoc(f)
call FlushChildHashtable(LS(),GetHandleId(k))
call DestroyTimer(k)
call IssueImmediateOrder(f,"stop")
call PauseUnitForPeriod(f,2)
call Push(f,20,10.0,AngleBetweenPoints(b,r))
call RemoveLocation(b)
call RemoveLocation(r)
set r=null
set b=null
set k=null
endfunction

function CordCollide takes nothing returns nothing
  local unit targetone=LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("target1"))
  local unit targettwo=LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()),StringHash("target2"))
  //local hashtable h=LoadLightningHandle(LS(), GetHandleId(targettwo),StringHash("lightning"))
  local unit f=GetTriggerUnit()
  local player p=LoadPlayerHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("wo"))
  local timer k
  local location r1=GetUnitLoc(f)
  local real angle=LoadReal(LS(),GetHandleId(GetTriggeringTrigger()),StringHash("angle"))
  local real startx=LoadReal(LS(),GetHandleId(GetTriggeringTrigger()),StringHash("startx"))
    local real starty=LoadReal(LS(),GetHandleId(GetTriggeringTrigger()),StringHash("starty"))
  local real pushangle
  if GetUnitY(f) < (TanBJ(angle)*(GetUnitX(f)-startx)+starty) then
  set pushangle=angle+90
  else
  set pushangle=angle-90
  endif
  if IsUnitExplorer(f) and GetUnitTypeId(f)!='h02Q' and GetUnitTypeId(f) != 'h04E' then
      // set k=CreateTimer()
//call SaveUnitHandle(LS(),GetHandleId(k),StringHash("f"),f)
//call SaveLocationHandle(LS(),GetHandleId(k),StringHash("r"),GetUnitLoc(f))
//call TimerStart(k,0.01,false, function CordPush_Determine)
call IssueImmediateOrder(f,"stop")
call PauseUnitForPeriod(f,1.5)
call Push(f,200,150.0,pushangle)
endif
set targetone=null
set targettwo=null
set f=null
set p=null
endfunction

function CordDisable takes nothing returns nothing
local trigger g=LoadTriggerHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("t"))
  local unit targetone=LoadUnitHandle(LS(), GetHandleId(g), StringHash("target1"))
  local unit targettwo=LoadUnitHandle(LS(), GetHandleId(g),StringHash("target2"))
  local hashtable h=LoadHashtableHandle(LS(), GetHandleId(targettwo),StringHash("lightning"))
  call DestroyTrigger(GetTriggeringTrigger())
call KillUnit(targetone)
call KillUnit(targettwo)
     call RemoveRegion(LoadRegionHandle(LS(), GetHandleId(g),StringHash("region")))
     call FlushChildHashtable(LS(), GetHandleId(GetTriggeringTrigger()))
call Delightningize(h)
call FlushParentHashtable(h)
     call FlushChildHashtable(LS(), GetHandleId(targetone))
     call FlushChildHashtable(LS(), GetHandleId(targettwo))
     endfunction
function CordAct2 takes nothing returns nothing
local unit q=GetSpellAbilityUnit()
  local unit targetone=LoadUnitHandle(LS(), GetHandleId(q), StringHash("target1"))
  local unit targettwo=CreateUnit(Player(15),'e024',GetSpellTargetX(), GetSpellTargetY(), GetRandomDirectionDeg())
    local location a=GetUnitLoc(targetone)
  local location b=GetUnitLoc(targettwo)
  local hashtable h=InitHashtable()
  local trigger Cordtrigger=CreateTrigger()
  local region hitrect=CreateRegion()
  local trigger disabletrigger=CreateTrigger()
  local real angle
  local real startx
  local real starty
  if GetLocationX(a)<GetLocationX(b) then
  set starty=GetLocationY(a)
  set startx=GetLocationX(a)
  set angle=AngleBetweenPoints(b,a)
  else
  set startx=GetLocationX(b)
  set starty=GetLocationY(b)
  set angle=AngleBetweenPoints(a,b)
  endif
  call LightningizeLocs(Cord_LightningCode(),a,b,500.0,h)
  call RemoveLocation(a)
  call RemoveLocation(b)
  set a=null
  set b=null
  call TriggerRegisterUnitEvent(disabletrigger,targetone,EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(disabletrigger,targettwo,EVENT_UNIT_DEATH)
call TriggerAddAction(disabletrigger, function CordDisable)
call SaveTriggerHandle(LS(), GetHandleId(disabletrigger), StringHash("t"), Cordtrigger)
     call Cord_RegionAddLineSeg(hitrect,GetUnitX(targettwo),GetUnitY(targettwo),GetUnitX(targetone),GetUnitY(targetone))
     call SaveUnitHandle(LS(), GetHandleId(Cordtrigger),StringHash("target1"),targetone)
     call SaveUnitHandle(LS(), GetHandleId(Cordtrigger),StringHash("target2"),targettwo)
          call SaveReal(LS(), GetHandleId(Cordtrigger),StringHash("angle"),angle)
                    call SaveReal(LS(), GetHandleId(Cordtrigger),StringHash("startx"),startx)
                              call SaveReal(LS(), GetHandleId(Cordtrigger),StringHash("starty"),starty)
     call SaveHashtableHandle(LS(), GetHandleId(targettwo),StringHash("lightning"),h)
     call SaveUnitHandle(LS(), GetHandleId(q),StringHash("target1"),udg_TheNullUnit)
     call SaveRegionHandle(LS(), GetHandleId(Cordtrigger),StringHash("region"),hitrect)
     call SavePlayerHandle(LS(), GetHandleId(Cordtrigger),StringHash("wo"),GetOwningPlayer(GetSpellAbilityUnit()))
     call TriggerAddAction(Cordtrigger,function CordCollide)
     call TriggerRegisterEnterRegion(Cordtrigger,hitrect,null)
set Cordtrigger=null
set hitrect=null

endfunction

function CordAct takes nothing returns nothing
local unit q=GetSpellAbilityUnit()
  local unit targetone=CreateUnit(Player(15),'e024',GetSpellTargetX(), GetSpellTargetY(), GetRandomDirectionDeg())
     call SaveUnitHandle(LS(), GetHandleId(q),StringHash("target1"),targetone)
endfunction

function CordDirectAct takes nothing returns nothing
  local unit v=LoadUnitHandle(LS(), GetHandleId(GetSpellAbilityUnit()),StringHash("target1"))
  local location a=GetUnitLoc(v)
  local location b=GetSpellTargetLoc()
  local player o=GetOwningPlayer(GetSpellAbilityUnit())
  if o==Player(14) then
  set o=udg_Parasite
  endif
if v==udg_TheNullUnit or v==null then
     call CordAct()
else
     call CordAct2()
endif
     call RemoveLocation(a)
     call RemoveLocation(b)
     set a=null
     set b=null
endfunction
//===========================================================================
function InitTrig_CordoningBeacon takes nothing returns nothing
    set gg_trg_CordoningBeacon = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_CordoningBeacon, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_CordoningBeacon, Condition( function Cord_AbilCheck) )
    call TriggerAddAction( gg_trg_CordoningBeacon, function CordDirectAct )
endfunction

