//TESH.scrollpos=58
//TESH.alwaysfold=0

function Trig_Lightning_Strike_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A03R' ) ) then
        return false
    endif
    return true
endfunction

function LightningStrikeDamage takes nothing returns nothing
if GetOwningPlayer(GetEnumUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) and GetOwningPlayer(GetEnumUnit()) != udg_Parasite and udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == false then
call UnitDamageTarget(udg_TempUnit4, GetEnumUnit(), 500.0, false, false ,ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
endif
endfunction

function Trig_Lightning_Strike_Actions takes nothing returns nothing
    //45 Degree Lightings
    local lightning a
    local lightning b
    local lightning c
    local lightning d
	
	//90 degree lightings
     local lightning aa
     local lightning bb
     local lightning cc
     local lightning dd
	
    local location e= GetSpellTargetLoc()
    local location f
    local location j
    local unit g= GetSpellAbilityUnit()
    
	
	//45 Degree Lightings
    set f=PolarProjectionBJ(e, 340, 45.00)
    call AddLightningLoc("CLPB", f, e)
    set a=GetLastCreatedLightningBJ()
    call RemoveLocation(f)
    set f=PolarProjectionBJ(e, 340, 135.00)
    call AddLightningLoc("CLPB", f, e)
    set b=GetLastCreatedLightningBJ()
    call RemoveLocation(f)
    set f=PolarProjectionBJ(e, 340, 225.00)
    call AddLightningLoc("CLPB", f, e)
    set c=GetLastCreatedLightningBJ()
    call RemoveLocation(f)
    set f=PolarProjectionBJ(e, 340, 315.00)
    call AddLightningLoc("CLPB", f, e)
    set d=GetLastCreatedLightningBJ()
	
	//90 Degree Lightings
    set f=PolarProjectionBJ(e, 340, 0.00)
    call AddLightningLoc("CLPB", f, e)
    set aa=GetLastCreatedLightningBJ()
    call RemoveLocation(f)
    set f=PolarProjectionBJ(e, 340, 90.00)
    call AddLightningLoc("CLPB", f, e)
    set bb=GetLastCreatedLightningBJ()
    call RemoveLocation(f)
    set f=PolarProjectionBJ(e, 340, 180.00)
    call AddLightningLoc("CLPB", f, e)
    set cc=GetLastCreatedLightningBJ()
    call RemoveLocation(f)
    set f=PolarProjectionBJ(e, 340, 270.00)
    call AddLightningLoc("CLPB", f, e)
    set dd=GetLastCreatedLightningBJ()
	
	
    call RemoveLocation(f)
    set udg_TempUnitType='e00P'
    set udg_TempPlayer=GetOwningPlayer(GetSpellAbilityUnit())
    set udg_TempReal=20.00
    call ExecuteFunc("AlienRequirementRemove")
    call ExecuteFunc("AlienRequirementRestore")
    call PolledWait(2.5)
    set udg_TempUnit4=g
    set udg_TempUnitGroup=GetUnitsInRangeOfLocAll(340.0, e)
    call ForGroup(udg_TempUnitGroup, function LightningStrikeDamage)
    call DestroyGroup(udg_TempUnitGroup)
    
    call DestroyLightning(a)
    call DestroyLightning(b)
    call DestroyLightning(c)
    call DestroyLightning(d)
	
	call DestroyLightning(aa)
    call DestroyLightning(bb)
    call DestroyLightning(cc)
    call DestroyLightning(dd)
      
    set g=null

    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=35
    call SetSoundPositionLocBJ(gg_snd_MonsoonLightningHit, e, 0)
    call PlaySoundBJ(gg_snd_MonsoonLightningHit)
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set j=PolarProjectionBJ(e, GetRandomReal(0, 300.00), GetRandomDirectionDeg())
        call AddSpecialEffectLocBJ(j, "Doodads\\Cinematic\\Lightningbolt\\Lightningbolt.mdl")
        call RemoveLocation(j)
        call SFXThreadClean()
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call RemoveLocation(e)
    set e=null

endfunction

//===========================================================================
function InitTrig_Lightning_Strike takes nothing returns nothing
    set gg_trg_Lightning_Strike = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Lightning_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Lightning_Strike, Condition( function Trig_Lightning_Strike_Conditions ) )
    call TriggerAddAction( gg_trg_Lightning_Strike, function Trig_Lightning_Strike_Actions )
endfunction

