//TESH.scrollpos=58
//TESH.alwaysfold=0
function Trig_Setup_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A08Q' ) ) then
        return false
    endif
    return true
endfunction

globals
integer EffectGroupCount = 0
endglobals

function CreateEffectGroup takes nothing returns integer
set EffectGroupCount=EffectGroupCount+1
call SaveInteger(LS(),StringHash("EffectGroup_"+I2S(EffectGroupCount)),StringHash("effects_count"),0)
return EffectGroupCount
endfunction

function AddEffectToEffectGroup takes integer groupie, effect a returns nothing
local integer i=LoadInteger(LS(),StringHash("EffectGroup_"+I2S(groupie)),StringHash("effects_count"))+1
call SaveEffectHandle(LS(),StringHash("EffectGroup_"+I2S(groupie)),StringHash("effect_"+I2S(i)),a)
call SaveInteger(LS(),StringHash("EffectGroup_"+I2S(groupie)),StringHash("effects_count"),i)
endfunction

function DestroyEffectsInEffectGroup takes integer groupie returns nothing
local integer i=LoadInteger(LS(),StringHash("EffectGroup_"+I2S(groupie)),StringHash("effects_count"))
local integer b=1
loop
exitwhen b > i
call DestroyEffect(LoadEffectHandle(LS(),StringHash("EffectGroup_"+I2S(groupie)),StringHash("effect_"+I2S(b))))
set b=b+1
endloop
call FlushChildHashtable(LS(),StringHash("EffectGroup_"+I2S(groupie)))
endfunction

function DifferenceBetweenAngles takes real angle1, real angle2 returns real
if angle2 > angle1 then
    if angle2-angle1 > 180 then
        return (360-angle2)+angle1
    else
        return angle2-angle1
    endif
else
    if angle1-angle2 > 180 then
        return (360-angle1)+angle2
    else
        return angle1-angle2
    endif
endif
endfunction

function DistanceBetweenUnitAndPoint takes unit a, location b returns real
local location c=GetUnitLoc(a)
local real d=DistanceBetweenPoints(c,b)
call RemoveLocation(c)
return d
endfunction

function Trig_Setup_Actions takes nothing returns nothing
    local unit a=GetSpellAbilityUnit()
    local location c=GetSpellTargetLoc()
    local location d=GetUnitLoc(GetSpellAbilityUnit())
    local real r=AngleBetweenPoints(d,c)
    local integer effectgroup=CreateEffectGroup()
    
    call AddEffectToEffectGroup(effectgroup,AddSpecialEffectTarget("Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedTarget.mdl",a,"origin"))
    call RemoveLocation(c)
    call UnitAddAbilityBJ( 'A08S', GetSpellAbilityUnit() )
    set udg_TempPoint2 = d
    
    
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 10
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        
        set udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, ( 60.00 * I2R(GetForLoopIndexA()) ), ( GetUnitFacing(GetSpellAbilityUnit()) + 30.00 ))
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Orc\\Bloodlust\\BloodlustTarget.mdl" )
        call AddEffectToEffectGroup(effectgroup,bj_lastCreatedEffect)
        call RemoveLocation( udg_TempPoint )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    
    
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 10
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        
        set udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, ( 60.00 * I2R(GetForLoopIndexA()) ), ( GetUnitFacing(GetSpellAbilityUnit()) - 30.00 ))
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Orc\\Bloodlust\\BloodlustTarget.mdl" )
        call AddEffectToEffectGroup(effectgroup,bj_lastCreatedEffect)
        call RemoveLocation( udg_TempPoint )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    
    
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 5
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        
        set udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 600.00, ( GetUnitFacing(GetSpellAbilityUnit()) + ( -30.00 + ( I2R(GetForLoopIndexA()) * 12.00 ) ) ))
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Orc\\Bloodlust\\BloodlustTarget.mdl" )
        call AddEffectToEffectGroup(effectgroup,bj_lastCreatedEffect)
        call RemoveLocation( udg_TempPoint )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    
    loop
        exitwhen DifferenceBetweenAngles(GetUnitFacing(a),r)>30.0 or DistanceBetweenUnitAndPoint(a,d)>50.0
        call TriggerSleepAction( 0.10 )
    endloop
    set udg_TempUnit=a
    call UnitRemoveAbilityBJ( 'A08S', udg_TempUnit )
    call DestroyEffectsInEffectGroup(effectgroup)
    call RemoveLocation( d )
endfunction

//===========================================================================
function InitTrig_Setup takes nothing returns nothing
    set gg_trg_Setup = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Setup, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Setup, Condition( function Trig_Setup_Conditions ) )
    call TriggerAddAction( gg_trg_Setup, function Trig_Setup_Actions )
endfunction

