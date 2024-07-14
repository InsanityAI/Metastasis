//TESH.scrollpos=24
//TESH.alwaysfold=0
function Trig_PulseSuitAttack_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetAttacker())=='h04M' then
        return true
    endif
    return false
endfunction


function PulseResetAttack takes nothing returns nothing
local timer k=GetExpiredTimer()

local unit r=LoadUnitHandle(LS(),GetHandleId(k),StringHash("unit"))
local lightning b=LoadLightningHandle(LS(),GetHandleId(r),StringHash("attackLightning"))
local sound s=LoadSoundHandle(LS(),GetHandleId(k),StringHash("loopingSound"))
call StopSound(s,true,true)
call SetUnitTimeScale(r,1)
call DestroyLightning(b)
call DestroyTimer(k)
call SaveBoolean(LS(),GetHandleId(r),StringHash("attackInt"),false)
call StopSound(gg_snd_MagicLariatLoop1,false,true)
endfunction

function Cap takes real a, real b returns real
if a > b then
return b
endif
return a
endfunction

function Trig_PulseSuitAttack_Actions takes nothing returns nothing

    local timer k
    local lightning b
    local unit m=GetTriggerUnit()
    local unit r=GetAttacker()
    local real vb=GetUnitFacing(r)*bj_DEGTORAD
    local location zget=GetUnitLoc(r)
    local location zget2=GetUnitLoc(m)
    local real z1=GetLocationZ(zget)
    local real z2=GetLocationZ(zget2)
    local real currentMana = GetUnitState(r,UNIT_STATE_MANA)
    local real usedMana = (85* currentMana /100) * 0.05
    local real damage = usedMana * 3
    local sound s

set damage=Cap(damage,175*0.05)
call SetUnitState(r,UNIT_STATE_MANA,currentMana - usedMana)
if IsUnitIllusionBJ(GetAttacker()) == false then
call UnitDamageTarget(r,m,damage,true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
else
endif
if GetRandomReal(0,1.2)<=damage/7.2 then
call AddSpecialEffect("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosDone.mdl",GetUnitX(m),GetUnitY(m))
call SFXThreadClean()
endif
call RemoveLocation(zget)
call RemoveLocation(zget2)
set zget=null
set zget2=null
if HaveSavedBoolean(LS(),GetHandleId(r),StringHash("attackInt")) and LoadBoolean(LS(),GetHandleId(r),StringHash("attackInt"))==true then
set k=LoadTimerHandle(LS(),GetHandleId(r),StringHash("attackResetTimer"))
set b=LoadLightningHandle(LS(),GetHandleId(r),StringHash("attackLightning"))
call TimerStart(k,.2,false,function PulseResetAttack)
call MoveLightningEx(b,false,GetUnitX(r)+50.0*Cos(vb)+19*Cos(vb-bj_PI/2),GetUnitY(r)+50.0*Sin(vb)+19*Sin(vb-bj_PI/2),z1+50,GetUnitX(m)+20.0*Cos(vb),GetUnitY(m)+20.0*Sin(vb),z2+30)
call SetLightningColor(b,1,1,1,Cap((damage)/7*1+0.1,1))
call SetSoundVolume(LoadSoundHandle(LS(),GetHandleId(k),StringHash("loopingSound")),R2I(Cap(damage/7*125+50,126)))
else
call SetUnitTimeScale(r,2)
set k=CreateTimer()
set s=CreateSound("Sound\\Ambient\\DoodadEffects\\EnchantedCellLoop.wav",true,true,true,126,126,"")
call SetSoundPitch(s,1.3)
call SetSoundPosition(s,GetUnitX(r),GetUnitY(r),0.0)
call PlaySoundBJ(s)
call SaveBoolean(LS(),GetHandleId(r),StringHash("attackInt"),true)
call TimerStart(k,.2,false,function PulseResetAttack)
call SaveSoundHandle(LS(),GetHandleId(k),StringHash("loopingSound"),s)
call SaveTimerHandle(LS(),GetHandleId(r),StringHash("attackResetTimer"),k)
call SaveUnitHandle(LS(),GetHandleId(k),StringHash("unit"),r)
call SaveLightningHandle(LS(),GetHandleId(r),StringHash("attackLightning"),AddLightningEx("AFOD",false,GetUnitX(r)+50.0*Cos(vb)+19*Cos(vb-bj_PI/2),GetUnitY(r)+50.0*Sin(vb)+19*Sin(vb-bj_PI/2),z1+30,GetUnitX(m)+20.0*Cos(vb),GetUnitY(m)+20.0*Sin(vb),z2+30))

set s=CreateSound("Abilities\\Spells\\Human\\InnerFire\\InnerFireBirth.wav",false,true,true,126,126,"")
call SetSoundPosition(s,GetUnitX(r),GetUnitY(r),0.0)

call StartSound(s)
call KillSoundWhenDone(s)
endif
endfunction

//===========================================================================
function InitTrig_PulseSuitAttack takes nothing returns nothing
    set gg_trg_PulseSuitAttack = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_PulseSuitAttack, EVENT_PLAYER_UNIT_ATTACKED )
    call TriggerAddCondition( gg_trg_PulseSuitAttack, Condition( function Trig_PulseSuitAttack_Conditions ) )
    call TriggerAddAction( gg_trg_PulseSuitAttack, function Trig_PulseSuitAttack_Actions )
endfunction

