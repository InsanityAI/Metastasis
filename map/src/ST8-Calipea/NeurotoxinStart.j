//TESH.scrollpos=8
//TESH.alwaysfold=0
function Trig_NeurotoxinStart_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A07D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_NeurotoxinStart_Func001C takes nothing returns boolean
    if ( not  ( not(IsUnitExplorer(GetSpellTargetUnit()) or IsUnitStation(GetSpellTargetUnit())) ) ) then
        return false
    endif
    return true
endfunction

function NeurotoxicDamage2 takes nothing returns nothing
local group o
local player p

if GetPlayerheroU(GetEnumUnit())==GetEnumUnit() and IsUnitType(GetEnumUnit(),UNIT_TYPE_STRUCTURE)==false and udg_HiddenAndroid!=GetOwningPlayer(GetEnumUnit()) and GetOwningPlayer(GetEnumUnit())!=Player(PLAYER_NEUTRAL_PASSIVE) then
call UnitDamageTarget(GetEnumUnit(),GetEnumUnit(),udg_TempReal,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
if udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] <=0 then
set p=GetOwningPlayer(GetEnumUnit())
if p==Player(bj_PLAYER_NEUTRAL_EXTRA) then
set p=udg_Parasite
endif
  call CinematicFilterGenericForPlayer(p, 12.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 20,100,20,0,0,0,0,100)
endif
endif
if IsUnitExplorer(GetEnumUnit()) then
set o=GetUnitsInRectAll(udg_SpaceObject_Rect[GetUnitAN(GetEnumUnit())])
call ForGroup(o,function NeurotoxicDamage2)
call DestroyGroup(o)
endif
endfunction

function NeurotoxinDamage takes nothing returns nothing
local timer k=GetExpiredTimer()
local real damage=LoadReal(LS(),GetHandleId(k),StringHash("damage"))
local rect m=LoadRectHandle(LS(),GetHandleId(k),StringHash("rect"))
local group o=GetUnitsInRectAll(m)
set udg_TempReal=damage
call ForGroup(o,function NeurotoxicDamage2)
call SaveReal(LS(),GetHandleId(k),StringHash("damage"),damage+0.03)
call DestroyGroup(o)
endfunction

function Trig_NeurotoxinStart_Actions takes nothing returns nothing
local timer k
local unit m=GetSpellTargetUnit()
local real vb=GetUnitFacing(GetSpellAbilityUnit())
    if ( Trig_NeurotoxinStart_Func001C() ) or udg_SpaceObject_Rect[GetUnitAN(m)]==null then
        call IssueImmediateOrderBJ( gg_unit_h04E_0259, "stop" )
        return
    else
    endif
    set k=CreateTimer()
    //bizarre but there are no hashtable functions for weather effects
call SaveLightningHandle(LS(),GetHandleId(gg_unit_h04E_0259),StringHash("neuroLightning"),AddLightningEx("DRAL",false,GetUnitX(m)+20.0*Cos(vb),GetUnitY(m)+20.0*Sin(vb),-170.0,GetUnitX(gg_unit_h04E_0259)+90.0*Cos(vb),GetUnitY(gg_unit_h04E_0259)+90.0*Sin(vb),-170.0))

call TimerStart(k,1,true,function NeurotoxinDamage)
call SaveReal(LS(),GetHandleId(k),StringHash("damage"),5.0)
call SaveRectHandle(LS(),GetHandleId(k),StringHash("rect"),udg_SpaceObject_Rect[GetUnitAN(m)])
call SaveTimerHandle(LS(),GetHandleId(GetSpellAbilityUnit()),StringHash("neurotoxin_unit"),k)
    endfunction

//===========================================================================
function InitTrig_NeurotoxinStart takes nothing returns nothing
    set gg_trg_NeurotoxinStart = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_NeurotoxinStart, gg_unit_h04E_0259, EVENT_UNIT_SPELL_CHANNEL )
    call TriggerAddCondition( gg_trg_NeurotoxinStart, Condition( function Trig_NeurotoxinStart_Conditions ) )
    call TriggerAddAction( gg_trg_NeurotoxinStart, function Trig_NeurotoxinStart_Actions )
endfunction

