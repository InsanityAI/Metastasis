//TESH.scrollpos=15
//TESH.alwaysfold=0
function Trig_ThingyCannon_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A07R' ) ) then
        return false
    endif
    return true
endfunction


function ThingyCannon_Asplode takes nothing returns nothing
    local timer k=GetExpiredTimer()
    local location b=LoadLocationHandle(LS(),GetHandleId(k),StringHash("loc"))
    local player p=LoadPlayerHandle(LS(),GetHandleId(k),StringHash("player"))
    
    call DamageAreaForPlayerTK(p,150.0,220.0,GetLocationX(b),GetLocationY(b))
    call AddSpecialEffectLoc("war3mapImported\\UDeath.MDX",b)
    call SFXThreadClean()
    call RemoveLocation(b)
    call FlushChildHashtable(LS(),GetHandleId(k))
    call DestroyTimer(k)
endfunction

function Trig_ThingyCannon_Actions takes nothing returns nothing
    local location b=GetSpellTargetLoc()
    local location c=GetUnitLoc(GetSpellAbilityUnit())
    local timer k=CreateTimer()
    local unit a=CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), 'e02L',c,GetRandomDirectionDeg())
    
    call SaveLocationHandle(LS(),GetHandleId(k),StringHash("loc"),b)
    call SavePlayerHandle(LS(),GetHandleId(k),StringHash("player"),GetOwningPlayer(GetSpellAbilityUnit()))
    call TimerStart(k,2.3,false,function ThingyCannon_Asplode)
    call AddSpecialEffectLoc("Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl",c)
    call SFXThreadClean()
    call BasicAI_IssueDangerArea(b,220.0,2.4)
    call SetUnitFlyHeight(a,3500,600.0)
    call SizeUnitOverTime(a,2.3,0.1,2.5,false)//(unit, duration, start, end, bool)
    call FadeUnitOverTime(a,2.4,true)
    call RemoveLocation(c)
endfunction


//===========================================================================
function InitTrig_ThingyCannon takes nothing returns nothing
    set gg_trg_ThingyCannon = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ThingyCannon, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ThingyCannon, Condition( function Trig_ThingyCannon_Conditions ) )
    call TriggerAddAction( gg_trg_ThingyCannon, function Trig_ThingyCannon_Actions )
endfunction

