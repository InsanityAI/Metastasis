//TESH.scrollpos=78
//TESH.alwaysfold=0
function Trig_DamageSys_Func001C takes nothing returns boolean
    if ( not ( udg_TempInt != 37 ) ) then
        return false
    endif
    return true
endfunction

function VendorDisabling_Damage takes nothing returns nothing
if GetUnitAbilityLevel(GetEnumUnit(),'A07Q')>=1 then
call VendorIsDamaged(GetEnumUnit())
//call UnitDamageTarget(udg_TempUnit,GetEnumUnit(),0.1,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
//call SetUnitLifeBJ(GetEnumUnit(),GetUnitState(GetEnumUnit(),UNIT_STATE_LIFE)+0.1)
endif
endfunction

function VendorDisabling takes unit a returns nothing
local location c
local group g
loop
exitwhen GetGameTime()-udg_Unit_VendorDisablingTime[GetUnitAN(a)]>9.5
set c=GetUnitLoc(a)
set g=GetUnitsInRangeOfLocAll(650.0,c)
set udg_TempUnit=a
call ForGroup(g,function VendorDisabling_Damage)
call RemoveLocation(c)
call DestroyGroup(g)
call PolledWait(0.25)
endloop
set udg_Unit_VendorDisabling[GetUnitAN(a)]=false
endfunction


function UponDamage takes nothing returns nothing
local unit a=GetEventDamageSource()
local real k=GetEventDamage()
local unit r=GetTriggerUnit()
local real o=GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE)
local group ag
local unit op
local integer ir=0
if k > o then
set k=o
endif
//

if UnitHasBuffBJ(r, 'B009') or UnitHasBuffBJ(r, 'B01F') then
set udg_Unit_IsInfected[GetUnitAN(r)]=true
set udg_Unit_InfectionType[GetUnitAN(r)]=1
else
if UnitHasBuffBJ(r, 'B00H') or UnitHasBuffBJ(r, 'B01G') then
set udg_Unit_IsInfected[GetUnitAN(r)]=true
set udg_Unit_InfectionType[GetUnitAN(r)]=2
else
set udg_Unit_IsInfected[GetUnitAN(r)]=false
endif
endif
//if udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(r))] == r then
//set udg_Player_DamageTaken[GetConvertedPlayerId(GetOwningPlayer(r))] = udg_Player_DamageTaken[GetConvertedPlayerId(GetOwningPlayer(r))] + k
//endif
if k == 4.39 or k==6.53 or k==8.53 or k==0.0 then
//Exact damage of acid suit's acid and various infections
return
endif
//Force suit attack detection
if GetUnitTypeId(a)=='h03L'  and (TimerGetElapsed(udg_GameTimer)-udg_ForceSuit_LastAttackTime[GetUnitAN(a)]==0.375 or TimerGetElapsed(udg_GameTimer)-udg_ForceSuit_LastAttackTime[GetUnitAN(a)]==0.5) then
call ExecuteFunc("Trig_ForceSuitAttack_Actions")
return
endif
//

if (GetOwningPlayer(a) == udg_Mutant or udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(a))]) and r == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(r))] and GetOwningPlayer(r) != udg_Mutant and udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(r))] == false and RectContainsUnit(gg_rct_Space, r) == false then
if udg_Mutant_DamageToPlayer[GetConvertedPlayerId(GetOwningPlayer(r))]<1 then
set udg_Mutant_DamageToPlayer[GetConvertedPlayerId(GetOwningPlayer(r))]=udg_Mutant_DamageToPlayer[GetConvertedPlayerId(GetOwningPlayer(r))]+k/GetUnitState(r,UNIT_STATE_MAX_LIFE)
if udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(a))] then

set udg_UpgradePointsMutant = udg_UpgradePointsMutant + (k/GetUnitState(r,UNIT_STATE_MAX_LIFE))*50
else
if udg_Mutant_IsPerfection then
set udg_UpgradePointsMutant = udg_UpgradePointsMutant + (k/GetUnitState(r,UNIT_STATE_MAX_LIFE))*200
else
set udg_UpgradePointsMutant = udg_UpgradePointsMutant + (k/GetUnitState(r,UNIT_STATE_MAX_LIFE))*50
endif
endif
endif
endif


if a != null and (GetOwningPlayer(a)==udg_HiddenAndroid or GetOwningPlayer(r)==udg_HiddenAndroid) and r==udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(r))] then
call LogTKPoints(GetOwningPlayer(a),GetOwningPlayer(r),k)
endif
if IsUnitPlayerhero(r) then
set udg_Unit_VendorDisablingTime[GetUnitAN(r)]=GetGameTime()
if not(udg_Unit_VendorDisabling[GetUnitAN(r)]) then
set udg_Unit_VendorDisabling[GetUnitAN(r)]=true
call VendorDisabling(r)
endif
endif
endfunction


function Trig_DamageSys_Actions takes nothing returns nothing
    if ( Trig_DamageSys_Func001C() ) then
    call TriggerRegisterUnitEvent( udg_DamageTrig, GetTriggerUnit(), EVENT_UNIT_DAMAGED )
    endif
endfunction
function Trig_DamageSys_2Actions takes nothing returns nothing
    if ( Trig_DamageSys_Func001C() ) then
    call TriggerRegisterUnitEvent( udg_DamageTrig, GetEnumUnit(), EVENT_UNIT_DAMAGED )
    endif
endfunction

//===========================================================================
function InitTrig_DamageSys takes nothing returns nothing
    set gg_trg_DamageSys = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_DamageSys, GetPlayableMapRect() )
    call TriggerAddAction( gg_trg_DamageSys, function Trig_DamageSys_Actions )
    set udg_DamageTrig=CreateTrigger()
    call TriggerAddAction(udg_DamageTrig, function UponDamage)
    set udg_TempUnitGroup=GetUnitsInRectAll(GetPlayableMapRect())
    call ForGroup(udg_TempUnitGroup,function Trig_DamageSys_2Actions)
    call DestroyGroup(udg_TempUnitGroup)
endfunction

