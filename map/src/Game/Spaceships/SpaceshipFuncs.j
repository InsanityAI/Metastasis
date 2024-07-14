//TESH.scrollpos=107
//TESH.alwaysfold=0

function SSEnter takes nothing returns nothing
//set udg_TempUnit=GetHandleUnit(GetTriggeringTrigger(), "q")
set udg_TempUnit=LoadUnitHandle(LS(),GetHandleId(GetTriggeringTrigger()), StringHash("q"))
call ConditionalTriggerExecute( gg_trg_SSGenEnter )
endfunction
function SSControl takes nothing returns nothing
set udg_TempUnit=LoadUnitHandle(LS(),GetHandleId(GetTriggeringTrigger()), StringHash("q"))
call ConditionalTriggerExecute( gg_trg_SSGenControl )
endfunction
function SSControlLoss takes nothing returns nothing
set udg_TempUnit=LoadUnitHandle(LS(),GetHandleId(GetTriggeringTrigger()), StringHash("q"))
call ConditionalTriggerExecute( gg_trg_SSGenControlLoss )
endfunction
function SSExit takes nothing returns nothing
set udg_TempUnit=LoadUnitHandle(LS(),GetHandleId(GetTriggeringTrigger()), StringHash("q"))
call ConditionalTriggerExecute( gg_trg_SSGenExit )
endfunction
function SSDeath takes nothing returns nothing
set udg_TempUnit=LoadUnitHandle(LS(),GetHandleId(GetTriggeringTrigger()), StringHash("q"))
call ConditionalTriggerExecute( gg_trg_SSGenDeath )
endfunction

function SSDamage_Reset takes nothing returns nothing
local timer t=GetExpiredTimer()
local trigger m=LoadTriggerHandle(LS(),GetHandleId(t),StringHash("trig"))
set udg_TempUnit=LoadUnitHandle(LS(),GetHandleId(m),StringHash("q"))
call SetStackedSoundBJ( false, gg_snd_WWII_submarine_dive_klaxon, udg_SpaceObject_Rect[GetUnitAN(udg_TempUnit)] )
call SaveBoolean(LS(),GetHandleId(m),StringHash("underattack"),false)
endfunction

function SSDamage takes nothing returns nothing
local trigger m=GetTriggeringTrigger()
local timer t=LoadTimerHandle(LS(),GetHandleId(m),StringHash("timer"))
set udg_TempUnit=LoadUnitHandle(LS(),GetHandleId(m),StringHash("q"))
    call DisableTrigger( m)
    if LoadBoolean(LS(),GetHandleId(m),StringHash("underattack"))==false then
        call SetStackedSoundBJ( true, gg_snd_WWII_submarine_dive_klaxon, udg_SpaceObject_Rect[GetUnitAN(udg_TempUnit)] )
        call SaveBoolean(LS(),GetHandleId(m),StringHash("underattack"),true)
    endif
    call TimerStart(t,10.0,false,function SSDamage_Reset)
    call PolledWait( 5.00 )
    call EnableTrigger( m )
endfunction

globals
    integer SpaceshipID=0
endglobals

function Spaceship_Build takes unit landed, unit space, unit console, rect mainsrect, rect enterexit, rect controlrect, integer sector returns nothing
    
    local trigger enter=CreateTrigger()
    local trigger exit=CreateTrigger()
    local trigger control=CreateTrigger()
    local trigger controlLoss=CreateTrigger()
    local trigger death=CreateTrigger()
    local integer i
    local trigger damage=CreateTrigger()
    local timer DamageTimer=CreateTimer()

    set udg_Sector_Space[sector]=space
    set SpaceshipID=SpaceshipID+1
    set udg_SpaceshipID_Space[SpaceshipID]=space

    call TriggerRegisterUnitInRangeSimple( enter, 128.00, landed )
    call TriggerRegisterEnterRectSimple( control, controlrect )
    call TriggerRegisterLeaveRectSimple( controlLoss, controlrect )
    call TriggerRegisterEnterRectSimple( exit, enterexit )
    call TriggerRegisterUnitEvent( death, landed, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( death, space, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent(damage,landed,EVENT_UNIT_DAMAGED)
    call TriggerRegisterUnitEvent(damage,space,EVENT_UNIT_DAMAGED)
    call TriggerAddAction(enter, function SSEnter)
    call TriggerAddAction(control, function SSControl)
    call TriggerAddAction(controlLoss, function SSControlLoss)
    call TriggerAddAction(exit, function SSExit)
    call TriggerAddAction(death, function SSDeath)
    call TriggerAddAction(damage, function SSDamage)

    //call SetHandleHandle(enter, "q", landed) 
    //call SetHandleHandle(exit, "q", landed) 
    //call SetHandleHandle(control, "q", landed) 
    //call SetHandleHandle(controlLoss, "q", landed) 
    //call SetHandleHandle(death, "q", landed)

    call SaveUnitHandle(LS(), GetHandleId(enter), StringHash("q"), landed)
    call SaveUnitHandle(LS(), GetHandleId(exit), StringHash("q"), landed)
    call SaveUnitHandle(LS(), GetHandleId(control), StringHash("q"), landed)
    call SaveUnitHandle(LS(), GetHandleId(controlLoss), StringHash("q"), landed)
    call SaveUnitHandle(LS(), GetHandleId(death), StringHash("q"), landed)
    call SaveUnitHandle(LS(), GetHandleId(damage), StringHash("q"), landed)
    call SaveBoolean(LS(),GetHandleId(damage),StringHash("underattack"),false)
    call SaveTimerHandle(LS(),GetHandleId(damage),StringHash("timer"),DamageTimer)
    call SaveTriggerHandle(LS(),GetHandleId(DamageTimer),StringHash("trig"),damage)
    
    //NewUnitRegister, gives the spaceship its own new and unique custom unit value!
    call NewUnitRegister(landed)
    call NewUnitRegister(space)
    
    //Note that the custom value for each spaceship is different
    //Landed and Space equivalent, have different custom values!

    set i=GetUnitAN(landed)//Literally i = GetUnitUserData(landed)
    set udg_SpaceObject_Rect[i]=mainsrect
    set udg_SpaceObject_Rect[GetUnitAN(space)]=mainsrect
    set udg_Spaceship_Console[i]=console
    set udg_Spaceship_ControlLossTrig[i]=controlLoss
    set udg_Spaceship_ControlRect[i]=controlrect
    set udg_Spaceship_ControlTrig[i]=control
    set udg_Spaceship_Death[i]=death
    set udg_Spaceship_EnterExit[i]=enterexit
    set udg_Spaceship_EnterTrig[i]=enter
    set udg_Spaceship_ExitTrig[i]=exit
    set udg_Spaceship_Rect[i]=mainsrect
    set udg_SS_Landed[i]=landed
    set udg_SS_Space[i]=space

    set i=GetUnitAN(space)//Literally i = GetUnitUserData(space)
    set udg_Spaceship_Console[i]=console
    set udg_Spaceship_ControlLossTrig[i]=controlLoss
    set udg_Spaceship_ControlRect[i]=controlrect
    set udg_Spaceship_ControlTrig[i]=control
    set udg_Spaceship_Death[i]=death
    set udg_Spaceship_EnterExit[i]=enterexit
    set udg_Spaceship_EnterTrig[i]=enter
    set udg_Spaceship_ExitTrig[i]=exit
    set udg_Spaceship_Rect[i]=mainsrect
    set udg_SS_Landed[i]=landed
    set udg_SS_Space[i]=space
    
    call SetUnitTimeScalePercent( landed, 0.00 )
endfunction
//===========================================================================
function InitTrig_SpaceshipFuncs takes nothing returns nothing
endfunction

