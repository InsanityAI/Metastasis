//TESH.scrollpos=14
//TESH.alwaysfold=0
function Trig_AnyDeath_Actions takes nothing returns nothing
local unit a=GetDyingUnit()
local unit b
local player c=GetOwningPlayer(a)
local boolean o = (a==udg_Playerhero[GetConvertedPlayerId(c)])
if GetUnitPointValue(a)!= 37 and IsUnitIllusion(a)==false and o then
set udg_Unit_DeathTime[GetUnitUserData(a)]=TimerGetElapsed(udg_GameTimer)
set b=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),GetUnitTypeId(a),GetUnitX(a),GetUnitY(a),GetUnitFacing(a))
call SetUnitPathing(b,false)
call SetUnitX(b,GetUnitX(a))
call SetUnitY(b,GetUnitY(a))
call UnitAddAbility(b,'Avul')
call UnitAddAbility(b,'Aloc')
call UnitAddAbility(b,'A077')
if GetOwningPlayer(a)==udg_HiddenAndroid then
call UnitAddAbility(b,'A07P')
endif
call SetUnitAnimation(b,"death")
call SetUnitVertexColor(a,0,0,0,0)
call SaveUnitHandle(LS(),GetHandleId(a),StringHash("Corpse"),b)
call SetUnitColor(b,GetPlayerColor(GetOwningPlayer(a)))

call PolledWait(1.0)
if udg_Player_IsParasiteSpawn[GetConvertedPlayerId(c)] and IsUnitType(b,UNIT_TYPE_MECHANICAL)==false then
call SetUnitColor(b,ConvertPlayerColor(PLAYER_NEUTRAL_AGGRESSIVE))
//call FadeUnitOverTime(b,5.0,true)
endif
call PolledWait(25.0)
if not(o) and a!=null then
call SetUnitPosition(a,GetLocationX(udg_HoldZone),GetLocationY(udg_HoldZone))
set udg_UnitAssignation[GetUnitAN(a)]=udg_TheNullUnit
call RemoveUnit(a)
endif
endif
endfunction

//===========================================================================
function InitTrig_AnyDeath takes nothing returns nothing
    set gg_trg_AnyDeath = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_AnyDeath, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddAction( gg_trg_AnyDeath, function Trig_AnyDeath_Actions )
endfunction

