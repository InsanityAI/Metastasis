native UnitAlive takes unit u returns boolean
//TESH.scrollpos=1642
//TESH.alwaysfold=0
//The only time I ever had to use vJass!
globals
 hashtable udg_hash = InitHashtable()
 endglobals
// ===========================

library LS
function LS takes nothing returns hashtable
//Returns hashtable for use in saving data to handles
    return udg_hash
endfunction
endlibrary

function GetGameTime takes nothing returns real
return TimerGetElapsed(udg_GameTimer)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function GetPlayerhero takes player a returns unit
return udg_Playerhero[GetConvertedPlayerId(a)]
endfunction
function GetPlayerheroU takes unit o returns unit
return udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(o))]
endfunction
function IsUnitPlayerhero takes unit o returns boolean
return GetPlayerheroU(o)==o
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function IsPlayerAlien takes player a returns boolean
//If players is main alien or spawn returns true.
return udg_Parasite==a or udg_Player_IsParasiteSpawn[GetConvertedPlayerId(a)] or a==Player(bj_PLAYER_NEUTRAL_EXTRA)
endfunction
function IsPlayerMutant takes player a returns boolean
//If players is main mutant or spawn returns true.
return udg_Mutant==a or udg_Player_IsMutantSpawn[GetConvertedPlayerId(a)]
endfunction
function IsPlayerInfected takes player a returns boolean
    if IsPlayerAlien(a) or IsPlayerMutant(a) then
        return true
    else
        return false
    endif
endfunction

function IsPlayerMainInfected takes player a returns boolean
return udg_Parasite==a or udg_Mutant==a or a==Player(bj_PLAYER_NEUTRAL_EXTRA)
endfunction

function IsPlayerNonhuman takes player a returns boolean
if IsPlayerAlien(a) or IsPlayerMutant(a) or udg_HiddenAndroid==a then
return true
else
return false
endif
endfunction
function IsPlayerHuman takes player a returns boolean
return not(IsPlayerNonhuman(a))
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function CreateCTLRequirement takes nothing returns nothing
//Allows the temporal control alien to cast closed time-like loop 11 seconds after he is createed.
call PolledWait(11.0)
    call CreateNUnitsAtLoc( 1, 'e00K', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING )
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function SetHandleInt takes handle t, string h, integer value returns nothing
//Alias of SaveInteger, less work for my conversion from pre 1.24 to a post 1.24 world.
call SaveInteger(LS(), GetHandleId(t), StringHash(h), value)
endfunction

////////////////////////////////////////////////////////////////////////////////////////////////////////
function AddAbilityForPeriod_Remove takes nothing returns nothing
local timer o=GetExpiredTimer()
local unit a=LoadUnitHandle(LS(),GetHandleId(o),StringHash("unit"))
local integer theability=LoadInteger(LS(),GetHandleId(o),StringHash("Ability"))
call FlushChildHashtable(LS(),GetHandleId(o))
call DestroyTimer(o)
set o=null
call UnitRemoveAbility(a,theability)
endfunction
function UnitAddAbilityForPeriod takes unit a, integer theability, real duration returns nothing
//This function will add an ability to a unit for a period so that if this function is called again while the unit has the ability
//And adds it for another duration then only the later duration will remove the ability.
//For example, if you wanted to code a grace period of invulnerability for 3 seconds but then had an ability that also made the caster
//invulnerable and both were triggered, you should use this function so that as the grace period for invulnerability ends it does not
//short circuit the invulnerable ability.
local timer o=null
if HaveSavedHandle(LS(),GetHandleId(a),StringHash("AbilityTimed_Timer_" + I2S(theability))) then
set o=LoadTimerHandle(LS(),GetHandleId(a),StringHash("AbilityTimed_Timer_"+I2S(theability)))
endif
if o != null then
    if TimerGetRemaining(o) < duration then
    //If the ability is scheduled for removal at a later date than this addition will imply, we do nothing.
    //If not then we proceed regularly.
        call TimerStart(o,duration,false,function AddAbilityForPeriod_Remove)
    endif 
else
    if GetUnitAbilityLevel(a,theability)>=1 then
        return
    else
        set o=CreateTimer()
        call SaveInteger(LS(),GetHandleId(o),StringHash("Ability"),theability)
        call SaveUnitHandle(LS(),GetHandleId(o),StringHash("unit"),a)
        call SaveTimerHandle(LS(),GetHandleId(a),StringHash("AbilityTimed_Timer_"+I2S(theability)),o)
        call TimerStart(o,duration,false,function AddAbilityForPeriod_Remove)
        call UnitAddAbility(a,theability)
    endif
endif
endfunction

////////////////////////////////////////////////////////////////////////////////////////////////////////

function CloneUnit takes unit whichUnit, player cloneOwner, real cloneX, real cloneY, real cloneFacing returns unit
//Abuses gamecaches to make a clone of unit, which restores inventories, health, etc. Used by masquerader.
    local unit clone
    local gamecache g = InitGameCache("CloneCache.w3v")
    //Clones a unit. Got this function from somewhere.
    call StoreUnit(g, "clone", "clone", whichUnit)
    set clone = RestoreUnit(g, "clone", "clone", cloneOwner, cloneX, cloneY, cloneFacing)
    call SetUnitState(clone, UNIT_STATE_LIFE, GetUnitState(whichUnit, UNIT_STATE_LIFE))
    call SetUnitState(clone, UNIT_STATE_MANA, GetUnitState(whichUnit, UNIT_STATE_MANA))
    call FlushGameCache(g)
    set g = null
    return clone
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////

function AlienRequirementRestore takes nothing returns nothing
//I realize that using temporary globals is not the prettiest way to pass arguments, but seeing as I'm lazy
//And like the convenience of using GUI and JASS this will have to do.
//This function restores an alien requirement to use an ability after TempReal seconds to TempPlayer of TempUnitType.
//TempUnitType being the name of the unit type required for the ability to be cast.
local integer a=udg_TempUnitType
local player b=udg_TempPlayer
local real k=udg_TempReal
//Restores a requirement unit after k seconds.
//Use ExecuteFunc to not steal thread focus
call PolledWait(k)
call CreateUnitAtLoc(b,a,udg_HoldZone, 270)
endfunction

function AlienRequirementRemove_Child takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function AlienRequirementRemove takes nothing returns nothing
local group b=GetUnitsOfPlayerAndTypeId(udg_TempPlayer,udg_TempUnitType)
//Removes the requirements from tempplayer for the spell that needs tempunittype.
call ForGroup(b, function AlienRequirementRemove_Child)
call DestroyGroup(b)
set b=null
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////


function ParseEnteredString takes nothing returns nothing
    local string r = GetEventPlayerChatString()
    local integer lasti = 0
    local integer i = 0
    local integer argumenton = 1
    local integer k=StringLength(r)
    local integer n
    //Divides an entered string into spaces. "-liquidate lightblue" becomes udg_arguments[0]=-liquidate and udg_arguments[1]=lightblue
    loop
        exitwhen i > k
        if SubString(r,i-1,i) == " " then
            set n=lasti-1
            if n <0 then
                set n=0
            endif
            set udg_arguments[argumenton] = SubString(r,lasti-1, i-1)
            set argumenton = argumenton + 1
            set lasti = i+1
        endif
        set i = i + 1
    endloop
    set udg_arguments[argumenton] = SubString(r, lasti-1, 999)
endfunction

function ClearArguments takes nothing returns nothing
    local integer i=0
    //Preps the arguments bank so that arguments from the last are not considered
    loop
        exitwhen i > 100
        set udg_arguments[i]=""
        set i = i + 1
    endloop
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////

function MurderPart2 takes nothing returns nothing
local unit a=udg_TempUnit
local player b=udg_TempPlayer
//Executes the MurderPart2 trigger after 4 seconds, preserving local data.
//This hack brought to you by the Board of Hackery and Bad Code.
call PolledWait(1.1)
set udg_TempUnit=a
set udg_TempPlayer=b
call TriggerExecute(gg_trg_PlayerMurderPart2)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////






////////////////////////////////////////////////////////////////////////////////////////////////////////
//Counter bars!


function DestroyBar takes timer k returns nothing
//Given a timer k, this will destroy the associated countdown bar.
local texttag a = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"))
call FlushChildHashtable(LS(),GetHandleId(a))
call FlushChildHashtable(LS(),GetHandleId(k))
call PauseTimer(k)
call DestroyTimer(k)
call ShowTextTagForceBJ( false, a, GetPlayersAll() )
call DestroyTextTag(a)
endfunction

function DestroyUnitBar takes unit a returns nothing
//Destroys a countup bar given a unit a.
if HaveSavedHandle(LS(),GetHandleId(a),StringHash("CountupTimer")) then
call DestroyBar(LoadTimerHandle(LS(),GetHandleId(a),StringHash("CountupTimer")))
endif
endfunction

function DestroyBarStop takes timer k returns nothing
//Destroys a bar and stops its endfunction from executing
local texttag a = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"))
local timer end=LoadTimerHandle(LS(),GetHandleId(k),StringHash("endtimer"))
call FlushChildHashtable(LS(),GetHandleId(a))
call FlushChildHashtable(LS(),GetHandleId(k))
call FlushChildHashtable(LS(),GetHandleId(end))
call PauseTimer(end)
call DestroyTimer(end)
call PauseTimer(k)
call DestroyTimer(k)
call ShowTextTagForceBJ( false, a, GetPlayersAll() )
call DestroyTextTag(a)
endfunction
function DestroyUnitBarStop takes unit a returns nothing
//Destroys a countup bar given a unit a.
if HaveSavedHandle(LS(),GetHandleId(a),StringHash("CountupTimer")) then
call DestroyBarStop(LoadTimerHandle(LS(),GetHandleId(a),StringHash("CountupTimer")))
endif
endfunction

function CountUpBar_Execute takes nothing returns nothing
//This uses a seperate timer to precisely execute the necessary function.
local timer end=GetExpiredTimer()
local timer k=LoadTimerHandle(LS(), GetHandleId(end), StringHash("k"))
local unit whofor=LoadUnitHandle(LS(), GetHandleId(end), StringHash("whofor"))
local string endfunc=LoadStr(LS(), GetHandleId(end), StringHash("endfunc"))
call FlushChildHashtable(LS(), GetHandleId(end))
call DestroyTimer(end)
call DestroyBar(k)
set udg_CountupBarTemp=whofor
call ExecuteFunc(endfunc)
endfunction


function AddCountdown takes integer howmanybars, unit whatunit, real interval, timer k returns texttag
//Creates a text tag.
local string barcount = " "
local integer i=1
local texttag a
local location c=GetUnitLoc(whatunit)
loop
exitwhen i>howmanybars
set barcount=barcount+"I"
set i=i+1
endloop
call CreateTextTagLocBJ(barcount, c, 0, 6, 100, 100, 100, 0)
    call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
set a = bj_lastCreatedTextTag
    call SetTextTagFadepointBJ( a, howmanybars*interval )
    call SetTextTagLifespanBJ( a, howmanybars*interval+1 )
call SaveTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"),a)
call SaveInteger(LS(), GetHandleId(k), StringHash("progress"), 0)
call SaveInteger(LS(), GetHandleId(k), StringHash("barcount"), howmanybars)
call RemoveLocation(c)
return a
endfunction
function AddBarProgress takes timer k returns nothing
//Updates a countup texttag.
//Not sure why I coded things into so many seperate functions but I did.
local texttag a = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"))
local integer progress = LoadInteger(LS(), GetHandleId(k), StringHash("progress"))
local integer barcount = LoadInteger(LS(), GetHandleId(k), StringHash("barcount"))
local string barstring = LoadStr(LS(), GetHandleId(k), StringHash("barcolor"))
local integer i=1
if barcount <= progress then
call DestroyBar(k)
endif
loop
exitwhen i>progress
set barstring=barstring+"I"
set i=i+1
endloop
set barstring=barstring+"|r"
loop
exitwhen i>barcount
set barstring=barstring+"I"
set i=i+1
endloop
call SetTextTagTextBJ(a,barstring,6.0)
call SaveInteger(LS(), GetHandleId(k), StringHash("progress"), progress+1)
endfunction
function RegisterOnBarFull takes texttag a, string whatfunc, timer k returns nothing
call SaveStr(LS(), GetHandleId(k),StringHash("onend"), whatfunc)
endfunction
function BarCountUpLoop takes nothing returns nothing
//This is t he part that is called first every update.
local unit a = LoadUnitHandle(LS(), GetHandleId(GetExpiredTimer()), StringHash("countuploop"))
local texttag t=LoadTextTagHandle(LS(), GetHandleId(GetExpiredTimer()), StringHash("countdown"))
call SetTextTagPos(t,GetUnitX(a),GetUnitY(a),0.00)
call AddBarProgress(GetExpiredTimer())
endfunction


function CountUpBar takes unit whofor, integer howmanybars, real interval, string endfunc returns nothing
//Please note that because this uses a PolledWait for compatability that this function will time out code execution for its duration.
//This is mostly a compatability thing.
//udg_CountUpBarColor, a later introduction to this function, uses a global string variable to work now. If you don't se it before
//calling this function you will have no control over the color of the bar.
//If you set CountupBar_HideTempBool=true and provide a TempPlayerGroup with which not to show the text tag too this function will
//handle that. But it will also destroy the player group that you pass it.
local real duration = I2R(howmanybars)*interval
local timer k=CreateTimer()
local timer end=CreateTimer()
local texttag a = AddCountdown(howmanybars,whofor, interval,k)
call SaveStr(LS(), GetHandleId(k), StringHash("barcolor"), udg_CountUpBarColor)
call SaveInteger(LS(), GetHandleId(k), StringHash("progress"),1)
call RegisterOnBarFull(a,endfunc,k)
call SaveUnitHandle(LS(),GetHandleId(k), StringHash("countuploop"), whofor)
call TimerStart(k,interval,true,function BarCountUpLoop)
if udg_CountupBar_HideTempBool == true then
set udg_CountupBar_HideTempBool = false
call ShowTextTagForceBJ(false , a , udg_TempPlayerGroup)
call DestroyForce(udg_TempPlayerGroup)
endif
call SaveUnitHandle(LS(), GetHandleId(end), StringHash("whofor"),whofor)
call SaveStr(LS(), GetHandleId(end), StringHash("endfunc"),endfunc)
call SaveTimerHandle(LS(), GetHandleId(end), StringHash("k"),k)
call SaveTimerHandle(LS(), GetHandleId(whofor), StringHash("CountupTimer"),k)
call SaveTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"),a)
call SaveTimerHandle(LS(),GetHandleId(k),StringHash("end"),end)
call TimerStart(end,duration,false,function CountUpBar_Execute)
call PolledWait(duration)
set udg_CountupBarTemp=whofor
//PolledWait for compatibility with older versions
//call FlushChildHashtable(LS(), GetHandleId(k))
//call PauseTimer(k)
//call DestroyTimer(k)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
//This entire section below is basically the same as above but it dynamically checks for visibility to show the text tag.
//If you notice, fusion bombs don't do this but landing ships do.
////////////////////////////////////////////////
function CountdownBar_ShowLocal takes nothing returns nothing
if IsLocationVisibleToPlayer(udg_TempPoint, GetEnumPlayer()) then
if GetLocalPlayer() == GetEnumPlayer() then
call SetTextTagVisibility(udg_TempTexttag, true)
endif
else
if GetLocalPlayer() == GetEnumPlayer() then
call SetTextTagVisibility(udg_TempTexttag, false)
endif
endif
endfunction
function DestroyBar_Local takes timer k returns nothing
local texttag a = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"))
call FlushChildHashtable(LS(),GetHandleId(a))
call FlushChildHashtable(LS(),GetHandleId(k))
call PauseTimer(k)
call DestroyTimer(k)
call ShowTextTagForceBJ( false, a, GetPlayersAll() )
call DestroyTextTag(a)
endfunction

function CountUpBar_Execute_Local takes nothing returns nothing
local timer end=GetExpiredTimer()
local timer k=LoadTimerHandle(LS(), GetHandleId(end), StringHash("k"))
local unit whofor=LoadUnitHandle(LS(), GetHandleId(end), StringHash("whofor"))
local string endfunc=LoadStr(LS(), GetHandleId(end), StringHash("endfunc"))
call FlushChildHashtable(LS(), GetHandleId(end))
call DestroyTimer(end)
call DestroyBar_Local(k)
set udg_CountupBarTemp=whofor
call ExecuteFunc(endfunc)
endfunction


function AddCountdown_Local takes integer howmanybars, unit whatunit, real interval, timer k returns texttag
local string barcount = " "
local integer i=1
local texttag a
local location c=GetUnitLoc(whatunit)
loop
exitwhen i>howmanybars
set barcount=barcount+"I"
set i=i+1
endloop
call CreateTextTagLocBJ(barcount, c, 0, 6, 100, 100, 100, 0)
    call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
set a = bj_lastCreatedTextTag
    call SetTextTagFadepointBJ( a, howmanybars*interval )
    call SetTextTagLifespanBJ( a, howmanybars*interval+1 )
call SaveTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"),a)
call SaveInteger(LS(), GetHandleId(k), StringHash("progress"), 0)
call SaveInteger(LS(), GetHandleId(k), StringHash("barcount"), howmanybars)
call RemoveLocation(c)
return a
endfunction
function AddBarProgress_Local takes timer k returns nothing
local texttag a = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"))
local integer progress = LoadInteger(LS(), GetHandleId(k), StringHash("progress"))
local integer barcount = LoadInteger(LS(), GetHandleId(k), StringHash("barcount"))
local string barstring = LoadStr(LS(), GetHandleId(k), StringHash("barcolor"))
local integer i=1
if barcount <= progress then
call DestroyBar(k)
endif
loop
exitwhen i>progress
set barstring=barstring+"I"
set i=i+1
endloop
set barstring=barstring+"|r"
loop
exitwhen i>barcount
set barstring=barstring+"I"
set i=i+1
endloop
call SetTextTagTextBJ(a,barstring,6.0)
call SaveInteger(LS(), GetHandleId(k), StringHash("progress"), progress+1)
endfunction
function RegisterOnBarFull_Local takes texttag a, string whatfunc, timer k returns nothing
call SaveStr(LS(), GetHandleId(k),StringHash("onend"), whatfunc)
endfunction
function BarCountUpLoop_Local takes nothing returns nothing
local unit a = LoadUnitHandle(LS(), GetHandleId(GetExpiredTimer()), StringHash("countuploop"))
local texttag t=LoadTextTagHandle(LS(), GetHandleId(GetExpiredTimer()), StringHash("countdown"))
local location n=GetUnitLoc(a)
set udg_TempPoint = n
set udg_TempTexttag = t
call ForForce(GetPlayersAll() , function CountdownBar_ShowLocal)
call RemoveLocation(n)
call SetTextTagPos(t,GetUnitX(a),GetUnitY(a),0.00)
call AddBarProgress(GetExpiredTimer())
endfunction


function CountUpBar_Local takes unit whofor, integer howmanybars, real interval, string endfunc returns nothing
local real duration = I2R(howmanybars)*interval
local timer k=CreateTimer()
local boolexpr lolz
local timer end=CreateTimer()
local texttag a = AddCountdown(howmanybars,whofor, interval,k)
call SaveStr(LS(), GetHandleId(k), StringHash("barcolor"), udg_CountUpBarColor)
call SaveInteger(LS(), GetHandleId(k), StringHash("progress"),1)
call RegisterOnBarFull_Local(a,endfunc,k)
call SaveUnitHandle(LS(),GetHandleId(k), StringHash("countuploop"), whofor)
call TimerStart(k,interval,true,function BarCountUpLoop_Local)
if udg_CountupBar_HideTempBool == true then
set udg_CountupBar_HideTempBool = false
call ShowTextTagForceBJ(false , a , udg_TempPlayerGroup)
call DestroyForce(udg_TempPlayerGroup)
endif
call SaveUnitHandle(LS(), GetHandleId(end), StringHash("whofor"),whofor)
call SaveStr(LS(), GetHandleId(end), StringHash("endfunc"),endfunc)
call SaveTimerHandle(LS(), GetHandleId(end), StringHash("k"),k)
call SaveTimerHandle(LS(), GetHandleId(whofor), StringHash("CountupTimer"),k)
call SaveTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"),a)
call SaveTimerHandle(LS(),GetHandleId(k),StringHash("end"),end)
call TimerStart(end,duration,false,function CountUpBar_Execute_Local)
call PolledWait(duration)
set udg_CountupBarTemp=whofor
//PolledWait for compatibility with older versions
//call FlushChildHashtable(LS(), GetHandleId(k))
//call PauseTimer(k)
//call DestroyTimer(k)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function BarLocal_RunDummy takes nothing returns nothing
//This function, used in conjunction with ExecuteFunc(), won't block thread execution.
call CountUpBar_Local(udg_TempUnit, udg_TempInt, udg_TempReal, udg_TempString)
endfunction
//
//--------------------------

////////////////////////////////////////////////////////////////////////////////////////////////////////
//Various dummy functions to link JASS counter bars with GUI triggers.
function MutantUpgrade takes nothing returns nothing
    call TriggerExecute( gg_trg_MutantUpgradeFinish )
endfunction

function ParasiteUpgrade takes nothing returns nothing
    call TriggerExecute( gg_trg_ParasiteUpgradeFinish )
endfunction

function FusionBombExplosion takes nothing returns nothing
    call TriggerExecute( gg_trg_FusionBombExplode )
endfunction

function FusionBombExplosion2 takes nothing returns nothing
    call TriggerExecute( gg_trg_ProjectedExplosionExplode )
endfunction

function CarrierSackExplosion takes nothing returns nothing
    call TriggerExecute( gg_trg_CarrierSackExplode )
endfunction


function TeleportBombExplosion takes nothing returns nothing
    call TriggerExecute( gg_trg_TeleportBombExplode )
endfunction
function BlackHoleExplosion takes nothing returns nothing
    call TriggerExecute( gg_trg_BlackHoleExplode )
endfunction

function TacNukeExplosion takes nothing returns nothing
call TriggerExecute( gg_trg_TacticalNuclearExplosion )
endfunction

function ShieldsGoUp takes nothing returns nothing
    call TriggerExecute( gg_trg_ShieldsUp )
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//From trial and error we have learned the ExecuteFunc("SFXClean") many times in a row
//will disconnect the silly Macintosh users, a la planetary bombardment.
//Thinking about it maybe these still disconnect silly Macintosh users?
//Note that the stuff below just destroys the last created function after like 10 seconds.
function SFXClean takes nothing returns nothing
local effect a=GetLastCreatedEffectBJ()
call PolledWait(10.0)
call DestroyEffect(a)
endfunction

function CleanSFX takes nothing returns nothing
local effect a=GetLastCreatedEffectBJ()
call PolledWait(10.0)
call DestroyEffect(a)
endfunction


function SFXClean2 takes nothing returns nothing
local effect a=GetLastCreatedEffectBJ()
call PolledWait(0.5)
call DestroyEffect(a)
endfunction
function SFXThreadClean_Child takes nothing returns nothing
local timer t=GetExpiredTimer()
call DestroyEffect(LoadEffectHandle(LS(),GetHandleId(t),StringHash("a")))
call FlushChildHashtable(LS(),GetHandleId(t))
call DestroyTimer(t)
endfunction

function SFXThreadClean takes nothing returns nothing
//Uses a timer for thread safety.
local effect a=GetLastCreatedEffectBJ()
local timer t=CreateTimer()
call TimerStart(t,10.0,false,function SFXThreadClean_Child)
call SaveEffectHandle(LS(),GetHandleId(t),StringHash("a"),a)
endfunction
function SFXThreadCleanTimed takes nothing returns nothing
//Uses a timer for thread safety.
local effect a=GetLastCreatedEffectBJ()
local timer t=CreateTimer()
call TimerStart(t,udg_TempReal,false,function SFXThreadClean_Child)
call SaveEffectHandle(LS(),GetHandleId(t),StringHash("a"),a)
endfunction
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
//
function BombEndShaking takes nothing returns nothing
//This will stop shaking the camera after the player has viewed a fusion bomb.
local player a=udg_TempPlayer
    call PolledWait( 3.00 )
    call CameraClearNoiseForPlayer( a )
endfunction

function Remove2_CallBack takes nothing returns nothing
local timer t=GetExpiredTimer()
local unit a=LoadUnitHandle(LS(),GetHandleId(t),StringHash("u"))
call FlushChildHashtable(LS(),GetHandleId(t))
call DestroyTimer(t)
call RemoveUnit(a)
endfunction

function Remove2 takes nothing returns nothing
local timer t=CreateTimer()
//Removes a unit after like two seconds.
local unit a=udg_TempUnit
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("u"),a)
call TimerStart(t,2.0,false,function Remove2_CallBack)
endfunction
function Preserve4 takes nothing returns nothing
//Preserves a unit as tempunit for 4 seconds.
//Do not ExecuteFunc(), that would be pointless
local unit a =udg_TempUnit
call PolledWait(4)
set udg_TempUnit=a
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function CinematicFilterGenericForPlayer takes player whichPlayer, real duration, blendmode bmode, string tex, real red0, real green0, real blue0, real trans0, real red1, real green1, real blue1, real trans1 returns nothing
    //A cinematic filter that can be used locally.
    if udg_Player_Blinded[GetConvertedPlayerId(whichPlayer)] != true then
    if ( GetLocalPlayer() == whichPlayer ) then
        call SetCineFilterTexture(tex)
        call SetCineFilterBlendMode(bmode)
        call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
        call SetCineFilterStartUV(0, 0, 1, 1)
        call SetCineFilterEndUV(0, 0, 1, 1)
        call SetCineFilterStartColor(PercentTo255(red0), PercentTo255(green0), PercentTo255(blue0), PercentTo255(100-trans0))
        call SetCineFilterEndColor(PercentTo255(red1), PercentTo255(green1), PercentTo255(blue1), PercentTo255(100-trans1))
        call SetCineFilterDuration(duration)
        call DisplayCineFilter(true)
    endif
    endif
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////








///
///

//Returns the number of the 'sector' of the map that the point is in.
//Used to make sure units can't attack/damage nearby spaceships and the like.
//Unsure of the performance hit, if any.
//If a new sector is made then add that sector to this list.
function GetSector takes location l returns integer
    local integer x=0

    if RectContainsLoc(gg_rct_ST1, l) == true then
        set x = 1
    elseif RectContainsLoc(gg_rct_ST2, l) == true then
        set x = 2
    elseif RectContainsLoc(gg_rct_ST3, l) == true then
        set x = 3
    elseif RectContainsLoc(gg_rct_ST4S2, l) == true then
        set x = 4
    elseif RectContainsLoc(gg_rct_ST5, l) == true then
        set x = 5
    elseif RectContainsLoc(gg_rct_LostStation, l) == true then
        set x = 6
    elseif RectContainsLoc(gg_rct_PirateShip, l) == true then
        set x = 7
    elseif RectContainsLoc(gg_rct_Planet, l) == true then
        set x = 8
    elseif RectContainsLoc(gg_rct_SS1, l) == true then
        set x = 9
    elseif RectContainsLoc(gg_rct_SS2, l) == true then
        set x = 10
    elseif RectContainsLoc(gg_rct_SS3, l) == true then
        set x = 11
    elseif  RectContainsLoc(gg_rct_SS4, l) == true then
        set x = 12
    elseif RectContainsLoc(gg_rct_SS5, l) == true then
        set x = 13
    elseif RectContainsLoc(gg_rct_SS6, l) == true then
        set x = 14
    elseif RectContainsLoc(gg_rct_SS7, l) == true then
        set x = 15
    elseif RectContainsLoc(gg_rct_SS8, l) == true then
        set x = 16
    elseif RectContainsLoc(gg_rct_SS9, l) == true then
        set x = 17
    elseif RectContainsLoc(gg_rct_SS10, l) == true then
        set x = 18
    elseif RectContainsLoc(gg_rct_SS11, l) == true then
        set x = 19
    elseif RectContainsLoc(gg_rct_SS12, l) == true then
        set x = 20
    elseif RectContainsLoc(gg_rct_Space, l) == true then
        set x = 21
    elseif RectContainsLoc(gg_rct_MoonRect, l) == true then
        set x = 22
    elseif RectContainsLoc(gg_rct_ST8,l)==true then
        set x=23
    elseif RectContainsLoc(gg_rct_ST9,l)==true then
        set x=24
    elseif RectContainsLoc(gg_rct_ST10,l)==true then
        set x=25
    //Would be sheepyship
    //elseif RectContainsLoc(gg_rct_ST13,l)==true then
        //set x=26
    elseif RectContainsLoc(gg_rct_OverlordRect,l) then
        set x = 27
    elseif RectContainsLoc(gg_rct_Mirror_Arena,l) then
        set x = 28

    endif
    
    return x
endfunction

function GetUnitSector takes unit a returns integer
    local integer r
    local location b=GetUnitLoc(a)

    //Returns the sector of a unit
    set r=GetSector(b)
    call RemoveLocation(b)
    set b=null
    return r
    
endfunction

function LocInSector takes location a, integer i returns boolean
    //Checks if a loc is in a sector, given the sector's number.
    //Faster!
    if RectContainsLoc(udg_SectorId[i], a) then
        return true
    endif
        return false
endfunction

function UnitInSector takes unit a, integer i returns boolean
local location k=GetUnitLoc(a)

//Same thing as above but accepts a unit.
    if RectContainsLoc(udg_SectorId[i], k) then
        call RemoveLocation(k)
        set k=null
        return true
    endif
    
    call RemoveLocation(k)
    set k=null
    return false
endfunction

function UnitInSectorLax takes unit a, integer i returns boolean
    local location k=GetUnitLoc(a)
    
    //Same thing as above but returns true if the sector that the unit is in is contained within another sector. I.E. landed ships
    if RectContainsLoc(udg_SectorId[i], k) or (GetUnitAbilityLevel(udg_SS_Landed[GetUnitUserData(udg_Sector_Space[GetUnitSector(a)])],'A071')==1 and UnitInSector(udg_SS_Landed[GetUnitUserData(udg_Sector_Space[GetUnitSector(a)])],i)) then
        call RemoveLocation(k)
        set k=null
        return true
    endif
        call RemoveLocation(k)
        set k=null
        return false
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
///

function IsUnitExplorer takes unit a returns boolean
//local integer k=GetUnitTypeId(a)
//Returns true if the unit is an explorer class ship.
//if k=='h03K' or k=='h001' or k=='h02k' or k=='h02I' or k=='h012' or k=='h02S' or k=='h03J' or k=='h002' or k=='h02L' or k=='h02H' or k=='h02Q' then
//return true
//else
//return false
//endif
return GetUnitAbilityLevel(a,'A071')==1
endfunction
function IsUnitSuit takes unit a returns boolean
//local integer k=GetUnitTypeId(a)
//if k=='h02R' or k=='h00K' or k=='h00J' or k=='h00L' or k=='h00E' or k=='h03L' or k=='h02G' or k=='h00M' or k=='h03U' or k=='h024' or k=='h00F' or k=='h00D' or k=='h00N' or k=='h00C' or k=='h027' or k=='h00I' then
//return true
//else
//return false
//endif
return GetUnitAbilityLevel(a,'A070')==1
endfunction 

function IsUnitStation takes unit a returns boolean
//local integer i=GetUnitTypeId(q)
//if i=='h009' or i=='h003' or i=='h008' or i=='h007' or i=='h03T' or i=='h005' or i=='h00X' or i=='h02B' or i=='h040' or i=='h041' or i=='h042'  then
//return true
//else
//return false
//endif]
return GetUnitAbilityLevel(a,'A072')==1
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function PendUpgrade takes nothing returns nothing
local unit a=udg_TempUnit
local integer q=udg_TempUnitType
local integer b
local player k=udg_TempPlayer
local unit o
//Waits for a good time to apply spawn upgrades. A good time is considered as when you are not in an escape pod.
loop
call PolledWait(1.0)
exitwhen RectContainsUnit(gg_rct_Timeout, a)==false

endloop
set b=GetConvertedPlayerId(k)
set bj_forLoopBIndex = 1
            set bj_forLoopBIndexEnd = 6
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                set udg_TempItemArray[GetForLoopIndexB()] = UnitItemInSlotBJ(udg_Playerhero[b], GetForLoopIndexB())
                call UnitRemoveItemFromSlotSwapped( GetForLoopIndexB(), udg_Playerhero[b] )
                set bj_forLoopBIndex = bj_forLoopBIndex + 1
            endloop
//set k=GetOwningPlayer(a)
set o= ReplaceUnitBJ(a,q,bj_UNIT_STATE_METHOD_RELATIVE)
set udg_Playerhero[GetConvertedPlayerId(k)]=o
            set bj_forLoopBIndex = 1
            set bj_forLoopBIndexEnd = 6
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                call UnitAddItemSwapped( udg_TempItemArray[GetForLoopIndexB()], o )
                set udg_TempItemArray[GetForLoopIndexB()] = null
                set bj_forLoopBIndex = bj_forLoopBIndex + 1
            endloop
            call SelectUnitForPlayerSingle( o, GetOwningPlayer(o) )
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function DoorResetLock takes nothing returns nothing
//Used in the engineer's role ability, DoorHack.
//Opens and enables said door.
local unit a=udg_CountupBarTemp
local destructable k=LoadDestructableHandle(LS(), GetHandleId(a), StringHash("kittens"))
    set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(k), StringHash("t1")) 
        call EnableTrigger( udg_TempTrigger )
        call TriggerExecute( udg_TempTrigger )
        call KillDestructable(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")))
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////

function LoopDynamicLightningVisibility takes lightning l, real startx, real starty, real endx, real endy returns nothing
local real midx = (startx+endx)/2.0
local real midy= (starty+endy)/2.0
local integer i
local integer r=GetHandleId(l)
local boolean k
//WC3's lightning system sucks in that if you want to have lightning that lasts a long time and is only visible if you are next to it,
//The lightning will not show if you could not see its creation, or alternatively shows to everyone!
//With this system, lightning will dynamically check visibility to see if players should see the lightning.
//It hides the lightning with alpha!
loop
exitwhen LoadBoolean(LS(), GetHandleId(l),StringHash("w")) != true
set i=0
loop
exitwhen i > 11
if IsVisibleToPlayer(startx,starty,Player(i)) or IsVisibleToPlayer(midx,midy,Player(i)) or IsVisibleToPlayer(endx,endy,Player(i)) then
if GetLocalPlayer() == Player(i) then
call SetLightningColor(l,1,1,1,1)
endif
else
if GetLocalPlayer() == Player(i) then
call SetLightningColor(l,1,1,1,0)
endif
endif
set i=i+1
endloop
call PolledWait(0.2)
endloop
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////
function AwardAchievement takes integer achievement, player achiever returns nothing
call SaveBoolean(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("Player_" + I2S(GetConvertedPlayerId(achiever)) + "_won_" + I2S(achievement)),true)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////

function RubbleDestroy takes nothing returns nothing
if GetDestructableTypeId(GetEnumDestructable())=='B003' or GetDestructableTypeId(GetEnumDestructable())=='B007' then
call KillDestructable(GetEnumDestructable())
endif
endfunction

function FleshGolemLoop takes nothing returns nothing
//The flesh golem crushes nearby rubble and this is the triggering for it.
local unit a=udg_TempUnit
local location b
loop
exitwhen IsUnitDeadBJ(a)
set b=GetUnitLoc(a)
call EnumDestructablesInCircleBJ(225.0,b,function RubbleDestroy)
call RemoveLocation(b)
call PolledWait(0.1)
endloop
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
//Not documenting this function since force shields are no longer in the game!
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
function BlockDamage_RemoveAbility takes nothing returns nothing
local timer t=GetExpiredTimer()
local unit blockee=LoadUnitHandle(LS(), GetHandleId(t), StringHash("blockee"))
local real o=GetUnitState(blockee, UNIT_STATE_LIFE)
call UnitRemoveAbility(blockee,'A05G')
call SaveBoolean(LS(),GetHandleId(t),StringHash("DamageBlock_Thread"),false)
call SetUnitState(blockee, UNIT_STATE_LIFE, LoadReal(LS(), GetHandleId(t), StringHash("restore"))-(90000-o))
call FlushChildHashtable(LS(), GetHandleId(t))
call DestroyTimer(t)
endfunction

function BlockDamage takes unit blockee, real amount returns nothing
//Blocks the damage a unit would recieve.
//This needs to be executed before the damage happens, which is when AnyUnitIsDamaged triggers.
local timer t=CreateTimer()
local real o=GetUnitState(blockee, UNIT_STATE_LIFE)
if not(HaveSavedBoolean(LS(),GetHandleId(blockee),StringHash("DamageBlock_Thread")) and LoadBoolean(LS(),GetHandleId(blockee),StringHash("DamageBlock_Thread"))) then
call SaveUnitHandle(LS(), GetHandleId(t),StringHash("blockee"), blockee)
call SaveBoolean(LS(),GetHandleId(t),StringHash("DamageBlock_Thread"),true)
call SaveReal(LS(), GetHandleId(t), StringHash("restore"),o+amount)
call UnitAddAbility(GetTriggerUnit(),'A05G')
call SetUnitState(blockee, UNIT_STATE_LIFE, 90000)
call TimerStart(t,0,false,function BlockDamage_RemoveAbility)
endif
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
//All of these are mostly obvious, and use straightforward linear gradients.
function FadeUnitOverTime_Child takes nothing returns nothing
local timer t=GetExpiredTimer()
local real alpha=LoadReal(LS(),GetHandleId(t),StringHash("alpha"))
local real alphaPerTick=LoadReal(LS(),GetHandleId(t),StringHash("alphaPerTick"))
local unit a=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
call SetUnitVertexColorBJ(a,100,100,100,alpha+alphaPerTick)
if alpha+alphaPerTick<=0 then
if LoadBoolean(LS(),GetHandleId(t),StringHash("remove")) then
call RemoveUnit(a)
endif
call PauseTimer(t)
call DestroyTimer(t)
call FlushChildHashtable(LS(),GetHandleId(t))
return
endif
call SaveReal(LS(),GetHandleId(t), StringHash("alpha"),alpha+alphaPerTick)
endfunction

function FadeUnitOverTime takes unit a, real duration, boolean remove returns nothing
local timer t=CreateTimer()
call SaveReal(LS(),GetHandleId(t),StringHash("alpha"),100)
call SaveReal(LS(),GetHandleId(t),StringHash("alphaPerTick"),-100/(duration/0.04))
call SaveBoolean(LS(),GetHandleId(t),StringHash("remove"),remove)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),a)
call TimerStart(t,0.04,true,function FadeUnitOverTime_Child)
endfunction


function TintUnitOverTime_Child takes nothing returns nothing
local timer t=GetExpiredTimer()
local real red=LoadReal(LS(),GetHandleId(t),StringHash("red"))
local real green=LoadReal(LS(),GetHandleId(t),StringHash("green"))
local real blue=LoadReal(LS(),GetHandleId(t),StringHash("blue"))
local real redPerTick=LoadReal(LS(),GetHandleId(t),StringHash("redPerTick"))
local real greenPerTick=LoadReal(LS(),GetHandleId(t),StringHash("greenPerTick"))
local real bluePerTick=LoadReal(LS(),GetHandleId(t),StringHash("bluePerTick"))
local unit a=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
local real duration=LoadReal(LS(),GetHandleId(t),StringHash("duration"))
local real elapsed=LoadReal(LS(),GetHandleId(t),StringHash("elapsed"))
call SetUnitVertexColor(a,R2I(red+redPerTick),R2I(green+greenPerTick),R2I(blue+bluePerTick),255)
if elapsed>=duration then
call PauseTimer(t)
call DestroyTimer(t)
call FlushChildHashtable(LS(),GetHandleId(t))
return
endif
call SaveReal(LS(),GetHandleId(t), StringHash("elapsed"),elapsed+0.1)
call SaveReal(LS(),GetHandleId(t),StringHash("green"),green+greenPerTick)
call SaveReal(LS(),GetHandleId(t),StringHash("blue"),blue+bluePerTick)
call SaveReal(LS(),GetHandleId(t),StringHash("red"),red+redPerTick)
endfunction

function TintUnitOverTime takes unit a, real duration, integer red, integer green, integer blue returns nothing
local timer t=CreateTimer()
call SaveReal(LS(),GetHandleId(t),StringHash("red"),255)
call SaveReal(LS(),GetHandleId(t),StringHash("green"),255)
call SaveReal(LS(),GetHandleId(t),StringHash("blue"),255)
call SaveReal(LS(),GetHandleId(t),StringHash("greenPerTick"),(green-255)/(duration/0.10))
call SaveReal(LS(),GetHandleId(t),StringHash("bluePerTick"),(blue-255)/(duration/0.10))
call SaveReal(LS(),GetHandleId(t),StringHash("redPerTick"),(red-255)/(duration/0.10))
call SaveReal(LS(),GetHandleId(t),StringHash("duration"),duration)
call SaveReal(LS(),GetHandleId(t),StringHash("elapsed"),0)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),a)
call TimerStart(t,0.10,true,function TintUnitOverTime_Child)
endfunction

function SizeUnitOverTime_Child takes nothing returns nothing
local timer t=GetExpiredTimer()
local real startsize=LoadReal(LS(),GetHandleId(t),StringHash("startsize"))
local real sizePerTick=LoadReal(LS(),GetHandleId(t),StringHash("sizePerTick"))
local unit a=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
call SetUnitScale(a,startsize+sizePerTick,startsize+sizePerTick,startsize+sizePerTick)
if sizePerTick>0 then
if startsize+sizePerTick>=LoadReal(LS(),GetHandleId(t),StringHash("endsize")) then
if LoadBoolean(LS(),GetHandleId(t),StringHash("remove")) then
call RemoveUnit(a)
endif
call PauseTimer(t)
call DestroyTimer(t)
call FlushChildHashtable(LS(),GetHandleId(t))
return
endif
else
if startsize+sizePerTick<=LoadReal(LS(),GetHandleId(t),StringHash("endsize")) then
if LoadBoolean(LS(),GetHandleId(t),StringHash("remove")) then
call RemoveUnit(a)
endif
call PauseTimer(t)
call DestroyTimer(t)
call FlushChildHashtable(LS(),GetHandleId(t))
return
endif
endif
call SaveReal(LS(),GetHandleId(t), StringHash("startsize"),startsize+sizePerTick)
endfunction

function SizeUnitOverTime takes unit a, real duration, real startsize, real endsize, boolean remove returns nothing
//Sadly this function cannot get a unit's default size.
local timer t=CreateTimer()
call SaveReal(LS(),GetHandleId(t),StringHash("startsize"),startsize)
call SaveReal(LS(),GetHandleId(t),StringHash("endsize"),endsize)
call SaveReal(LS(),GetHandleId(t),StringHash("sizePerTick"),(endsize-startsize)/(duration/0.04))
call SaveBoolean(LS(),GetHandleId(t),StringHash("remove"),remove)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),a)
call TimerStart(t,0.04,true,function SizeUnitOverTime_Child)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////




function DamageUnitOverTime_Child takes nothing returns nothing
local timer t=GetExpiredTimer()
local real damage=LoadReal(LS(),GetHandleId(t),StringHash("damage"))
local unit a=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
local unit damager=LoadUnitHandle(LS(),GetHandleId(t),StringHash("damager"))
call UnitDamageTarget(damager,a,damage,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)

endfunction

function DamageUnitOverTime_End takes nothing returns nothing
local timer o=GetExpiredTimer()
local timer t=LoadTimerHandle(LS(),GetHandleId(o), StringHash("timer"))
call FlushChildHashtable(LS(),GetHandleId(t))
call FlushChildHashtable(LS(),GetHandleId(o))
call PauseTimer(t)
call DestroyTimer(t)
call DestroyTimer(o)
endfunction

function DamageUnitOverTime takes unit target, unit damager, real duration, real damage returns nothing
local timer t=CreateTimer()
local timer o=CreateTimer()
//Used in the Kyo cannon's hit.
call SaveReal(LS(),GetHandleId(t),StringHash("damage"),damage/duration/25)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),target)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("damager"),damager)
call SaveTimerHandle(LS(),GetHandleId(o),StringHash("timer"),t)
call TimerStart(t,0.04,true,function DamageUnitOverTime_Child)
call TimerStart(o,duration,false,function DamageUnitOverTime_End)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////




function Player_IsDead takes player p returns boolean
return IsPlayerInForce(p,udg_DeadGroup)
endfunction

////////////////////////////////////////////////////////////////////////////////////////////////////////

//Tiny push library
//Only for SPEHSS.
//As in, it won't work if the unit goes outside the space region.
//Literally.
//Don't try.
function Push_Move takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit a=LoadUnitHandle(LS(),GetHandleId(k),StringHash("pushlibrary_unit"))
local real dps=LoadReal(LS(),GetHandleId(k),StringHash("dps"))
local real angle=LoadReal(LS(),GetHandleId(k),StringHash("angle"))
local real decay=LoadReal(LS(),GetHandleId(k),StringHash("decay"))
local real x=GetUnitX(a)+dps*Cos(angle*bj_DEGTORAD)/25.0
local real y=GetUnitY(a)+dps*Sin(angle*bj_DEGTORAD)/25.0
if dps<=0.0 then
call FlushChildHashtable(LS(),GetHandleId(k))
call PauseTimer(k)
call DestroyTimer(k)
return
endif
if RectContainsCoords(gg_rct_Space,x,y) then
if GetUnitMoveSpeed(a) == 0.0 then
call SetUnitPosition(a,x,y)
else
call SetUnitX(a,x)
call SetUnitY(a,y)
endif
endif
call SaveReal(LS(),GetHandleId(k),StringHash("dps"),dps-decay/25.0)
endfunction

function Push takes unit a, real dps, real decay, real angle returns nothing
local timer k=CreateTimer()
call SaveUnitHandle(LS(),GetHandleId(k),StringHash("pushlibrary_unit"),a)
call TimerStart(k,0.04,true,function Push_Move)
call SaveReal(LS(),GetHandleId(k),StringHash("angle"),angle)
call SaveReal(LS(),GetHandleId(k),StringHash("dps"),dps)
call SaveReal(LS(),GetHandleId(k),StringHash("decay"),decay)
endfunction


////////////
//This push can be used in stations and has pathing
//Scaled by unit's mass index, which is saved in the UnitCustomData init trigger.
//Default for a non-registered unit is 100.
function Push2_Move takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit a=LoadUnitHandle(LS(),GetHandleId(k),StringHash("pushlibrary_unit"))
local real dps=LoadReal(LS(),GetHandleId(k),StringHash("dps"))
local real angle=LoadReal(LS(),GetHandleId(k),StringHash("angle"))
local real decay=LoadReal(LS(),GetHandleId(k),StringHash("decay"))
local real x=GetUnitX(a)+dps*Cos(angle*bj_DEGTORAD)/50.0
local real y=GetUnitY(a)+dps*Sin(angle*bj_DEGTORAD)/50.0
local location b=Location(x,y)
local real height=GetLocationZ(b)
local real hay
call RemoveLocation(b)
set b=null
set b=GetUnitLoc(a)
set hay=GetLocationZ(b)
call RemoveLocation(b)
set b=null
if dps<=0.0 then
call FlushChildHashtable(LS(),GetHandleId(k))
call PauseTimer(k)
call DestroyTimer(k)
return
endif
if IsPointPathable(x, y, false) and height <= hay+20.0 and GetTerrainCliffLevel(GetUnitX(a),GetUnitY(a))==GetTerrainCliffLevel(x,y) then
if GetUnitMoveSpeed(a) == 0.0 then
call SetUnitPosition(a,x,y)
else
call SetUnitX(a,x)
call SetUnitY(a,y)
endif
endif
call SaveReal(LS(),GetHandleId(k),StringHash("dps"),dps-decay/50.0)
endfunction

function Push2 takes unit a, real dps, real decay, real angle returns nothing
local timer k=CreateTimer()
call SaveUnitHandle(LS(),GetHandleId(k),StringHash("pushlibrary_unit"),a)
call TimerStart(k,0.02,true,function Push2_Move)
call SaveReal(LS(),GetHandleId(k),StringHash("angle"),angle)
call SaveReal(LS(),GetHandleId(k),StringHash("dps"),dps*100/GetUnitMass(a))
call SaveReal(LS(),GetHandleId(k),StringHash("decay"),decay)
endfunction

//This one uses SetUnitPosition instead of SetUnitX
//Its original purpose, of being used for units with 0 move speed, is obsolete. However you may still want to use this for
//making a unit unable to move while being pushed.
function Push3_Move takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit a=LoadUnitHandle(LS(),GetHandleId(k),StringHash("pushlibrary_unit"))
local real dps=LoadReal(LS(),GetHandleId(k),StringHash("dps"))
local real angle=LoadReal(LS(),GetHandleId(k),StringHash("angle"))
local real decay=LoadReal(LS(),GetHandleId(k),StringHash("decay"))
local real x=GetUnitX(a)+dps*Cos(angle*bj_DEGTORAD)/25.0
local real y=GetUnitY(a)+dps*Sin(angle*bj_DEGTORAD)/25.0
if dps<=0.0 then
call FlushChildHashtable(LS(),GetHandleId(k))
call PauseTimer(k)
call DestroyTimer(k)
return
endif
if RectContainsCoords(gg_rct_Space,x,y) then
call SetUnitPosition(a,x,y)
endif
call SaveReal(LS(),GetHandleId(k),StringHash("dps"),dps-decay/25.0)
endfunction

function Push3 takes unit a, real dps, real decay, real angle returns nothing
local timer k=CreateTimer()
call SaveUnitHandle(LS(),GetHandleId(k),StringHash("pushlibrary_unit"),a)
call TimerStart(k,0.04,true,function Push3_Move)
call SaveReal(LS(),GetHandleId(k),StringHash("angle"),angle)
call SaveReal(LS(),GetHandleId(k),StringHash("dps"),dps)
call SaveReal(LS(),GetHandleId(k),StringHash("decay"),decay)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////

/////

/////////////
function SunLoop_Blind takes nothing returns nothing
    local player p = GetOwningPlayer(GetEnumUnit())
    if GetEnumUnit()==GetPlayerheroU(GetEnumUnit()) then
        if p == Player(bj_PLAYER_NEUTRAL_EXTRA) then
            set p = udg_Parasite
        endif
        call CinematicFilterGenericForPlayer(p, 7.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100,100,100,udg_TempReal/9,0,0,0,100)
    endif
    set p = null
endfunction

function SunLoop takes unit a returns nothing
local unit sun=gg_unit_h01A_0197
local location q
local location b
local real r
local rect om=udg_SpaceObject_Rect[GetUnitUserData(a)]
local group g
loop
set q=GetUnitLoc(a)
set b=GetUnitLoc(sun)
set r=DistanceBetweenPoints(q,b)
call RemoveLocation(q)
call RemoveLocation(b)
exitwhen r>850
call UnitDamageTarget(sun,a,udg_SunDamage*(850-r),false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
if om != null then
set g=GetUnitsInRectAll(om)
set udg_TempReal=r
call ForGroup(g,function SunLoop_Blind)
call DestroyGroup(g)
endif
call PolledWait(1.0)
endloop

endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////

function AngleBetweenUnits takes unit a, unit b returns real
//local location c=GetUnitLoc(a)
//local location d=GetUnitLoc(b)
//local real r=AngleBetweenPoints(c,d)
//call RemoveLocation(c)
//set c=null
//call RemoveLocation(d)
//set d=null
//return r
return bj_RADTODEG * Atan2(GetUnitY(b) - GetUnitY(a), GetUnitX(b) - GetUnitX(a))
endfunction

function DistanceBetweenUnits takes unit unitA, unit unitB returns real
    return SquareRoot((GetUnitX(unitB) - GetUnitX(unitA)) * (GetUnitX(unitB) - GetUnitX(unitA)) + (GetUnitY(unitB) - GetUnitY(unitA)) * (GetUnitY(unitB) - GetUnitY(unitA)))
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function DefilerGoo_Create takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit a=LoadUnitHandle(LS(),GetHandleId(k),StringHash("a"))
local location b
local region r=LoadRegionHandle(LS(),GetHandleId(k),StringHash("r"))
local rect q
if Player_IsDead(GetOwningPlayer(a)) then
call PauseTimer(k)
call FlushChildHashtable(LS(),GetHandleId(k))
call RemoveRegion(r)
call DestroyTimer(k)
else
set b=GetUnitLoc(a)
if not(IsLocationInRegion(r,b)) then
call AddSpecialEffectLoc("Abilities\\Spells\\NightElf\\MoonWell\\MoonWellTarget.mdl",b)
set q=Rect(GetLocationX(b)-20.0,GetLocationY(b)-20.0,GetLocationX(b)+20.0,GetLocationY(b)+20.0)
call RegionAddRect(r,q)
call RemoveRect(q)
set q=null
endif
call RemoveLocation(b)
set b=null
endif
endfunction

function DefilerGoo_UnDamage takes nothing returns nothing
call SaveBoolean(LS(),GetHandleId(GetTriggerUnit()),StringHash("DefilerGoo_Thread"),true)
endfunction

function DefilerGoo_Damage takes nothing returns nothing
local region r=LoadRegionHandle(LS(),GetHandleId(GetTriggeringTrigger()),StringHash("r"))
local unit b=GetTriggerUnit()
local boolean m
if not(HaveSavedBoolean(LS(),GetHandleId(b),StringHash("DefilerGoo_Thread"))) then
set m=true
else
set m=LoadBoolean(LS(),GetHandleId(b),StringHash("DefilerGoo_Thread"))
endif
if m and not(IsPlayerMutant(GetOwningPlayer(b))) then
call SaveBoolean(LS(),GetHandleId(b),StringHash("DefilerGoo_Thread"),true)
loop
exitwhen IsUnitInRegion(r,b)==false
call UnitDamageTarget(b,b,10.0,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call PolledWait(0.5)
endloop
endif
endfunction

function DefilerGoo takes nothing returns nothing
local unit a=GetLastCreatedUnit()
local timer k=CreateTimer()
local region r=CreateRegion()
local trigger b=CreateTrigger()
local trigger c=CreateTrigger()
call SaveUnitHandle(LS(),GetHandleId(k),StringHash("a"),a)
call SaveRegionHandle(LS(),GetHandleId(b),StringHash("r"),r)
call SaveRegionHandle(LS(),GetHandleId(k),StringHash("r"),r)
call TimerStart(k,0.1,true,function DefilerGoo_Create)
call TriggerRegisterEnterRegionSimple(b,r)
call TriggerAddAction(b,function DefilerGoo_Damage)
call TriggerRegisterLeaveRegionSimple(b,r)
call TriggerAddAction(b,function DefilerGoo_UnDamage)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function HostileSpaceAI_Cond takes nothing returns boolean
if GetOwningPlayer(GetFilterUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) and IsUnitAliveBJ(GetFilterUnit()) then
return true
endif
return false

endfunction

function HostileSpaceAI takes unit a returns nothing
//Will break thread execution!
//Use below function to circumvent this.
//Basic AI is to just attack towards units in space. Will not attack Minertha until everything else is dead.
local group g
local location o

	loop
		exitwhen IsUnitDeadBJ(a)
			set o = GetUnitLoc(a)
			set g = GetUnitsInRectMatching(gg_rct_Space , Condition(function HostileSpaceAI_Cond))
			call RemoveLocation(o)

			set o = GetUnitLoc(FirstOfGroup(g))
			call IssuePointOrderLoc(a , "attack" , o)
			call RemoveLocation(o)
			call DestroyGroup(g)

			call PolledWait(10.0)
	endloop
endfunction

function HostileSpaceAIForTempUnit takes nothing returns nothing
//For continued thread execution.
call HostileSpaceAI(udg_TempUnit)
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function PlaySoundForPlayer takes sound toplay, player playfor returns nothing
if GetLocalPlayer()==playfor then
call StartSound(toplay)
endif
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////



function PauseUnitForPeriod_Remove takes nothing returns nothing
local timer o=GetExpiredTimer()
local unit a=LoadUnitHandle(LS(),GetHandleId(o),StringHash("unit"))
call FlushChildHashtable(LS(),GetHandleId(o))
call SaveTimerHandle(LS(),GetHandleId(a),StringHash("PauseTimed_Timer"),null)
call DestroyTimer(o)
set o=null
call PauseUnit(a,false)
endfunction
function PauseUnitForPeriod takes unit a, real duration returns nothing
//This ability is like UnitAddAbilityForPeriod, but instead of adding an ability it pauses the unit.
local timer o=null
set o=LoadTimerHandle(LS(),GetHandleId(a),StringHash("PauseTimed_Timer"))
if o != null and HaveSavedHandle(LS(),GetHandleId(a),StringHash("PauseTimed_Timer")) then
if TimerGetRemaining(o) < duration then
//If the ability is scheduled for removal at a later date than this addition will imply, we do nothing.
//If not then we proceed regularly.
call TimerStart(o,duration,false,function PauseUnitForPeriod_Remove)
endif 
else
set o=CreateTimer()
call SaveUnitHandle(LS(),GetHandleId(o),StringHash("unit"),a)
call SaveTimerHandle(LS(),GetHandleId(a),StringHash("PauseTimed_Timer"),o)
call TimerStart(o,duration,false,function PauseUnitForPeriod_Remove)
call PauseUnit(a,true)
endif
endfunction

function RemoveUnitPeriodPause takes unit a returns nothing
local timer o=null
set o=LoadTimerHandle(LS(),GetHandleId(a),StringHash("PauseTimed_Timer"))
if o != null and HaveSavedHandle(LS(),GetHandleId(a),StringHash("PauseTimed_Timer")) then
call FlushChildHashtable(LS(),GetHandleId(o))
call DestroyTimer(o)
endif
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////




function SlugglyAssassin takes unit sluggly returns nothing
//Part of the amusing but mostly impossible black hole secret.
local group g
local unit o
local rect r=udg_SectorId[GetUnitSector(sluggly)]
call UnitAddAbility(sluggly,'AInv')
    call UnitAddItemByIdSwapped( 'I00N', sluggly )
    call UnitAddItemByIdSwapped( 'I00R', sluggly )
    call UnitAddAbility(sluggly,'A03U')
        call UnitAddAbilityBJ( 'A02I', sluggly )
    call UnitAddAbilityBJ( 'AIl2', sluggly )
loop
exitwhen IsUnitAliveBJ(sluggly)==false
set g=GetUnitsInRectAll(r)
loop
exitwhen FirstOfGroup(g)==null
set o=FirstOfGroup(g)
call GroupRemoveUnit(g,o)
    if UnitHasItemOfTypeBJ(o,'I01F') then
        if UnitHasItemOfTypeBJ(sluggly,'I00N') then
            call UnitUseItemPoint(sluggly,UnitItemInSlotBJ(sluggly,1),GetUnitX(o),GetUnitY(o))
        else
            if UnitHasItemOfTypeBJ(sluggly,'I00R')then
                if DistanceBetweenUnits(sluggly,o)<=600.0 then
                    call UnitUseItemPoint(sluggly,UnitItemInSlotBJ(sluggly,2),GetUnitX(o),GetUnitY(o))
                else
                    call IssuePointOrder(sluggly,"move",GetUnitX(o),GetUnitY(o))
                endif
            else
                call UnitAddItemByIdSwapped( 'I00N', sluggly )
                call UnitAddItemByIdSwapped( 'I00R', sluggly )
            endif
        endif
    endif
endloop
call DestroyGroup(g)
set g=null
call PolledWait(2.0)
endloop


endfunction

function SlugglyAssassinAIForTempUnit takes nothing returns nothing
call SlugglyAssassin(udg_TempUnit)

endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////
function Masquerade_MutantEnd takes player a returns nothing
//Automatically ends the masquerader's impersonation of the mutant or android after 30 seconds.
call PolledWait(30.0)
    call ForceUICancelBJ( a )
endfunction

function Masquerade_ShipEnd takes player a returns nothing
//Automatically ends the masquerader's impersonation of a ship after 10 seconds.
call PolledWait(10.0)
    call ForceUICancelBJ( a )
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function DamageAreaForPlayer takes player a, real radius, real damage, real x, real y returns nothing
//Damage will be of the standard universal Metastasis damage type.
local location bo=Location(x,y)
local group g=GetUnitsInRangeOfLocAll(radius,bo)
local unit q
loop
exitwhen FirstOfGroup(g)==null
set q=FirstOfGroup(g)
call GroupRemoveUnit(g,q)
if a!=GetOwningPlayer(q) then
call UnitDamageTarget(GetPlayerhero(a),q,damage,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endif
endloop
call DestroyGroup(g)
call RemoveLocation(bo)
endfunction

function DamageAreaForPlayerTK takes player a, real radius, real damage, real x, real y returns nothing
//Damage will be of the standard universal Metastasis damage type. Same as above function but will damage the player it damages for.
local location bo=Location(x,y)
local group g=GetUnitsInRangeOfLocAll(radius,bo)
local unit q
loop
exitwhen FirstOfGroup(g)==null
set q=FirstOfGroup(g)
call GroupRemoveUnit(g,q)
call UnitDamageTarget(GetPlayerhero(a),q,damage,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endloop
call DestroyGroup(g)
call RemoveLocation(bo)
endfunction

////////////////////////////////////////////////////////////////////////////////////////////////////////
function CastAbilityOnGroup takes group r, integer abil, string orderId returns nothing
local unit q
local unit o
loop
exitwhen FirstOfGroup(r)==null
set q=FirstOfGroup(r)
call GroupRemoveUnit(r,q)
if GetOwningPlayer(q) != Player(PLAYER_NEUTRAL_AGGRESSIVE) then
set o=CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'e01Q',GetUnitX(q),GetUnitY(q),0.0)
else
set o=CreateUnit(Player(1),'e01Q',GetUnitX(q),GetUnitY(q),0.0)
endif
call UnitAddAbility(o,abil)
call IssueTargetOrder(o,orderId,q)
endloop
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function CreateScaledEffect takes string effectPath, real scale,real duration, real x, real y returns unit
//That effect is a UNIT!
local unit p=CreateUnit(Player(bj_PLAYER_NEUTRAL_EXTRA),'e01Q',x,y,GetRandomDirectionDeg())
call SetUnitScale(p,scale,scale,scale)
call AddSpecialEffectTarget(effectPath,p,"origin")
call UnitApplyTimedLife(p,'B000',duration)
return p
endfunction
function CreateScaledEffect2 takes string effectPath, real scale,real duration, real x, real y returns unit
//That effect is a UNIT! sans flying
local unit p=CreateUnit(Player(bj_PLAYER_NEUTRAL_EXTRA),'e03A',x,y,GetRandomDirectionDeg())
call SetUnitScale(p,scale,scale,scale)
call AddSpecialEffectTarget(effectPath,p,"origin")
call UnitApplyTimedLife(p,'B000',duration)
return p
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
//The below functions are useful in tracking pings: I.E. you are standing right outside a ship, use a tracking
//device, and see players inside the ship as well.
globals
group local_GetUnitsInRectAndShips_Group
endglobals
function GetUnitsInRectAndShips_Child takes nothing returns nothing
local group g
if udg_SpaceObject_Rect[GetUnitUserData(GetEnumUnit())]!=null then
set g=GetUnitsInRectAll(udg_SpaceObject_Rect[GetUnitUserData(GetEnumUnit())])
call GroupAddGroup(g,local_GetUnitsInRectAndShips_Group)
call DestroyGroup(g)
endif
endfunction

function GetUnitsInRectAndShips takes rect r returns group
local group g=GetUnitsInRectAll(r)
set local_GetUnitsInRectAndShips_Group=g
call ForGroup(g,function GetUnitsInRectAndShips_Child)
return g
endfunction

function GetUnitsInRangeAndShips takes location m, real radius returns group
local group g=GetUnitsInRangeOfLocAll(radius,m)
set local_GetUnitsInRectAndShips_Group=g
call ForGroup(g,function GetUnitsInRectAndShips_Child)
return g
endfunction
globals
boolean SHU_Bool
endglobals
function SHU_Test takes nothing returns nothing
if GetPlayerheroU(GetEnumUnit())==GetEnumUnit() then
set SHU_Bool=true
endif
endfunction
function ShipHasUnits takes unit ship returns boolean
local group r=GetUnitsInRectAll(udg_SpaceObject_Rect[GetUnitUserData(ship)])
set SHU_Bool=false
call ForGroup(r,function SHU_Test)
return SHU_Bool
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
//Actually I think this code I stole from somewhere.
function AddFadingTextTag takes string text, real x, real y, integer red, integer green, integer blue, integer alpha returns nothing
    local texttag t = CreateTextTag()
    call SetTextTagText(t, text, 0.025)
    call SetTextTagPos(t, x, y, 0.00)
    call SetTextTagColor(t, red, green, blue, alpha)
    call SetTextTagVelocity(t, 0, 0.03)
    call SetTextTagVisibility(t, true)
    call SetTextTagFadepoint(t, 2)
    call SetTextTagLifespan(t, 3)
    call SetTextTagPermanent(t, false)
    set t = null
endfunction

function AddFadingTextTagLoc takes string text, location where, integer red, integer green, integer blue, integer alpha returns nothing
    call AddFadingTextTag(text, GetLocationX(where), GetLocationY(where), red, green, blue, alpha)
endfunction


////



////////////////////////////////////////////////////////////////////////////////////////////////////////
function PacificationBotSort takes nothing returns nothing
local unit b=GetEnumUnit()
if gg_unit_h04A_0144 != b and (IsUnitType(b,UNIT_TYPE_MECHANICAL) or IsUnitSuit(b)) and GetConvertedPlayerId(GetOwningPlayer(b))<=12 and GetUnitAbilityLevel(b,'Avul')==0 and IsUnitAliveBJ(b) and GetUnitTypeId(b) != 'n00A' then
set udg_TempUnit=b
endif
endfunction

function PacificationBotDisable takes nothing returns nothing
local timer k=LoadTimerHandle(LS(),GetHandleId(gg_unit_h04A_0144),StringHash("director"))
call PauseTimer(k)
call DestroyTimer(k)
call SetUnitTimeScale(gg_unit_h04A_0144,0)
call PauseUnit(gg_unit_h04A_0144,true)
endfunction


function PacificationBotDirect takes nothing returns nothing
local location b=GetUnitLoc(gg_unit_h04A_0144)
local group g=GetUnitsInRangeOfLocAll(600.0,b)
local integer m m=GetRandomInt(0,10)

if IsUnitDeadBJ(gg_unit_h04A_0144) then
    call PacificationBotDisable()
    return
endif

//If pacification bot is player-controlled, gtfo
if GetOwningPlayer(gg_unit_h04A_0144) != Player(PLAYER_NEUTRAL_PASSIVE) then
    return
endif

set udg_TempUnit=null
call ForGroup(g,function PacificationBotSort)
call DestroyGroup(g)
if udg_TempUnit != null then
if GetRandomInt(0,4)==0 then
call AddFadingTextTag(udg_PacificationBotLines[m],GetUnitX(gg_unit_h04A_0144),GetUnitY(gg_unit_h04A_0144),255,0,0,255)
endif
call IssueTargetOrder(gg_unit_h04A_0144,"attack",udg_TempUnit)
else
if GetUnitCurrentOrder(gg_unit_h04A_0144) != String2OrderIdBJ("move") then
set udg_TempPoint=GetRandomLocInRect(gg_rct_ST4S2)
call IssuePointOrderLoc(gg_unit_h04A_0144,"move",udg_TempPoint)
call RemoveLocation(udg_TempPoint)
endif
endif
endfunction

function PacificationBotEnable takes nothing returns nothing
local timer k=CreateTimer()
if IsUnitAliveBJ(gg_unit_h04A_0144) then
    call SaveTimerHandle(LS(),GetHandleId(gg_unit_h04A_0144),StringHash("director"),k)
    call SetUnitTimeScale(gg_unit_h04A_0144,1.0)
    call PauseUnit(gg_unit_h04A_0144,false)
    call TimerStart(k,2,true,function PacificationBotDirect)
else
    call DestroyTimer(k)
endif
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
//The effect that the Kyo has when it has a charged ATM
function DestroyLightningRing takes timer m returns nothing
call PauseTimer(m)
call RemoveUnit(LoadUnitHandle(LS(),GetHandleId(m),StringHash("ring")))
call FlushChildHashtable(LS(),GetHandleId(m))
call DestroyTimer(m)
endfunction

function LightningRingReverse takes nothing returns nothing
local timer m=GetExpiredTimer()
local unit ring=LoadUnitHandle(LS(),GetHandleId(m),StringHash("ring"))
if GetUnitFlyHeight(ring)>300 then
call SetUnitFlyHeight(ring,0,1400)
else
call SetUnitFlyHeight(ring,700,1400)
endif
call SetUnitFacing(ring,GetUnitFacing(ring)+179.0)
endfunction

function LightningRing takes unit a returns timer
local unit ring=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e01Y',GetUnitX(a),GetUnitY(a),GetRandomDirectionDeg())
local timer m=CreateTimer()
call SaveUnitHandle(LS(),GetHandleId(m),StringHash("ring"),ring)
call SetUnitFlyHeight(ring,700,1400)
call TimerStart(m,0.5,true,function LightningRingReverse)
return m
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
//The zappy ATM effect.
function DestroyLightningPeriod takes nothing returns nothing
local lightning k=bj_lastCreatedLightning
call PolledWait(1.0)
call DestroyLightning(k)
endfunction

function AddLightningStormEx takes string codename, real x1,real y1,real z1,real x2,real y2,real z2,integer number, real variation returns nothing
local integer i=1
loop
exitwhen i > number
set bj_lastCreatedLightning= AddLightningEx(codename,false,x1+GetRandomReal(-variation,variation),y1+GetRandomReal(-variation,variation),z1+GetRandomReal(-variation,variation),x2+GetRandomReal(-variation,variation),y2+GetRandomReal(-variation,variation),z2+GetRandomReal(-variation,variation))
call ExecuteFunc("DestroyLightningPeriod")
set i=i+1
endloop
endfunction

////////////////////////////////////////////////////////////////////////////////////////////////////////
//Checks to see that there are no elevated cliff level sbetween locations a and b, and no SPEHSS
function TerrainLineCheck takes location a, location b, integer resolution returns boolean
local real dist=DistanceBetweenPoints(a,b)
local real angle=AngleBetweenPoints(a,b)
local real interval=dist/I2R(resolution)
local integer i=1
local boolean clear=true
local location c=Location(GetLocationX(a),GetLocationY(a))
local location d
local integer defaultHeight=GetTerrainCliffLevel(GetLocationX(a),GetLocationY(a))
loop
exitwhen (i > resolution) or not(clear)
set d=PolarProjectionBJ(c,interval,angle)
if GetTerrainCliffLevel(GetLocationX(d),GetLocationY(d)) > defaultHeight or GetTerrainType(GetLocationX(d),GetLocationY(d))=='Vcbp' then
set clear=false
endif
call RemoveLocation(c)
set c=d
set i=i+1
endloop
call RemoveLocation(d)
return clear
endfunction
////////////////////////////////////////////////////////////////////////////////////////////////////////
function AsteroidHit takes nothing returns nothing
local unit asteroid=LoadUnitHandle(LS(),GetHandleId(GetTriggeringTrigger()),StringHash("asteroid"))
if IsUnitStation(GetTriggerUnit()) then
call UnitDamageTarget(asteroid,GetTriggerUnit(),GetUnitState(asteroid,UNIT_STATE_LIFE)*4,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call KillUnit(asteroid)
endif
if IsUnitExplorer(GetTriggerUnit()) then
call UnitDamageTarget(asteroid,GetTriggerUnit(),3000,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call Push(GetTriggerUnit(),500.0,150.0,AngleBetweenUnits(asteroid,GetTriggerUnit()))
endif
endfunction
function AsteroidDeath takes nothing returns nothing
local trigger d=GetTriggeringTrigger()
local unit asteroid=LoadUnitHandle(LS(),GetHandleId(d),StringHash("asteroid"))
local trigger t=LoadTriggerHandle(LS(),GetHandleId(d),StringHash("t"))
call FlushChildHashtable(LS(),GetHandleId(t))
call DestroyTrigger(t)
call DestroyTrigger(d)
call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e01E',GetUnitX(asteroid),GetUnitY(asteroid),GetRandomDirectionDeg())
endfunction
function Asteroid_LeaveCheck takes nothing returns nothing
local unit asteroid=LoadUnitHandle(LS(),GetHandleId(GetExpiredTimer()),StringHash("asteroid"))
local real x=GetUnitX(asteroid)
local real y=GetUnitY(asteroid)
if x<6756 or x > 16129 or y > -6749 or y < -16203 then
call SetUnitPosition(asteroid,144,1444)
call KillUnit(asteroid)
endif
if IsUnitDeadBJ(asteroid) then
call PauseTimer(GetExpiredTimer())
call FlushChildHashtable(LS(),GetHandleId(GetExpiredTimer()))
call DestroyTimer(GetExpiredTimer())
endif
endfunction
function GiantAsteroid takes unit asteroid, real target returns nothing
local trigger t=CreateTrigger()
local trigger d=CreateTrigger()
local timer m=CreateTimer()
local real r=target
call Push(asteroid,50.0+GetRandomReal(-30.0,40.0),0,r)
call SaveUnitHandle(LS(),GetHandleId(m),StringHash("asteroid"),asteroid)
call TriggerRegisterUnitInRangeSimple(t,90.0,asteroid)
call TriggerAddAction(t,function AsteroidHit)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("asteroid"),asteroid)
call TriggerRegisterUnitEvent(d,asteroid,EVENT_UNIT_DEATH)
call TriggerAddAction(d,function AsteroidDeath)
call SaveUnitHandle(LS(),GetHandleId(d),StringHash("asteroid"),asteroid)
call SaveTriggerHandle(LS(),GetHandleId(d),StringHash("t"),t)
call SaveUnitHandle(LS(),GetHandleId(m),StringHash("asteroid"),asteroid)
call TimerStart(m,1,true,function Asteroid_LeaveCheck)
endfunction
//////////////////////////////////////////////////////////////////
function IntelligentRubble takes location a, real max, real angle returns location
local location suppose
local location prev=Location(GetLocationX(a),GetLocationY(a))
local integer ID=GetSector(a)
local real i=0
if max > 40 then
loop
exitwhen i > max
set suppose=PolarProjectionBJ(a,i,angle)
if GetTerrainCliffLevelBJ(suppose)>GetTerrainCliffLevelBJ(a) or not(LocInSector(suppose,ID)) or GetTerrainType(GetLocationX(suppose),GetLocationY(suppose))=='Vcbp' then
call RemoveLocation(suppose)
return prev
endif
call RemoveLocation(prev)
set prev=suppose
set i=i+20
endloop
return suppose
else
return Location(GetLocationX(a),GetLocationY(a))
endif
endfunction
////////////////
//Basically creates a chain of lightnings near a loc! WOOOOO
//Ensures that stuff doesn't stretch.
//Returns a hashtable that contains all of the lightnings, which can be used with 
//the second function to destroy the lightning chain
function LightningizeLocs takes string acode, location a, location b, real refresh, hashtable savehash returns nothing
local real h=DistanceBetweenPoints(a,b)
local real ang=AngleBetweenPoints(a,b)
local integer i=0
local real m=0
local location q=Location(GetLocationX(a),GetLocationY(a))
local location q2
loop
exitwhen m > h
set i=i+1
if h-m < refresh then
set q2=PolarProjectionBJ(q,h-m,ang)
else
set q2=PolarProjectionBJ(q,refresh,ang)
endif
call SaveLightningHandle(savehash,1,i,AddLightningLoc( acode, q, q2))
call RemoveLocation(q)
set q=q2
set m=m+refresh

endloop
call SaveInteger(savehash,2,1,i)
endfunction
function Delightningize takes hashtable h returns nothing
local integer i=LoadInteger(h,2,1)
local integer k=1
loop
exitwhen  k > i
call DestroyLightning(LoadLightningHandle(h,1,k))
set k=k+1
endloop
endfunction
///////////////////////
///////////////////////
////////////////////////
function Trig_CrabTeleport_Conditions takes nothing returns boolean
    if ( not ( OrderId2StringBJ(GetIssuedOrderIdBJ()) == "smart" ) ) then
        return false
    endif
    return true
endfunction

function Trig_CrabTeleport_Func006C takes nothing returns boolean
    if ( not ( DistanceBetweenPoints(udg_TempPoint2, udg_TempPoint3) >= udg_TempReal ) ) then
        return false
    endif
    return true
endfunction

function Trig_CrabTeleport_Func007C takes nothing returns boolean
    if ( not ( DistanceBetweenPoints(udg_TempPoint2, udg_TempPoint3) <= 100.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_CrabTeleport_Actions takes nothing returns nothing
    set udg_TempReal = ( GetUnitStateSwap(UNIT_STATE_MANA, GetOrderedUnit()) * 20.00 )
    set udg_TempPoint2 = GetUnitLoc(GetOrderedUnit())
    set udg_TempPoint3 = GetOrderPointLoc()
    set udg_TempReal2 = AngleBetweenPoints(udg_TempPoint2, udg_TempPoint3)
    if ( Trig_CrabTeleport_Func006C() ) then
        call RemoveLocation( udg_TempPoint3 )
        set udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint2, udg_TempReal, udg_TempReal2)
    else
    endif
    if ( Trig_CrabTeleport_Func007C() ) then
        set udg_TempPoint = udg_TempPoint3
    else
        set udg_TempPoint=IntelligentRubble(udg_TempPoint2,DistanceBetweenPoints(udg_TempPoint2,udg_TempPoint3),AngleBetweenPoints(udg_TempPoint2,udg_TempPoint3))
    endif
    call SetUnitManaBJ( GetOrderedUnit(), ( GetUnitStateSwap(UNIT_STATE_MANA, GetOrderedUnit()) - ( DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2) / 20.00 ) ) )
    call SetUnitPositionLoc( GetOrderedUnit(), udg_TempPoint )
    call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl" )
    call SFXThreadClean()
        call AddSpecialEffectLocBJ( udg_TempPoint2, "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl" )
    call SFXThreadClean()
    call RemoveLocation( udg_TempPoint )
    call RemoveLocation( udg_TempPoint2 )
    call RemoveLocation( udg_TempPoint3 )
endfunction
//===========================================================================

function CrabTeleport takes unit q returns nothing
local trigger a = CreateTrigger(  )
    call TriggerRegisterUnitEvent( a, q, EVENT_UNIT_ISSUED_POINT_ORDER )
    call TriggerAddCondition( a, Condition( function Trig_CrabTeleport_Conditions ) )
    call TriggerAddAction( a, function Trig_CrabTeleport_Actions )
endfunction
///////////////////
//////////////


function SVOP_Callback takes nothing returns nothing
local timer k=GetExpiredTimer()
local sound r=LoadSoundHandle(LS(),GetHandleId(k),StringHash("r"))
local real start=LoadReal(LS(),GetHandleId(k),StringHash("start"))
local real end=LoadReal(LS(),GetHandleId(k),StringHash("end"))
local real lerp=LoadReal(LS(),GetHandleId(k),StringHash("lerp"))
set start=start+lerp
call SetSoundVolume(r,R2I(start))
if start > end then
call PauseTimer(k)
call FlushChildHashtable(LS(),GetHandleId(k))
call DestroyTimer(k)
else
call SaveReal(LS(),GetHandleId(k),StringHash("start"),start)
endif
endfunction

function SoundVolumeOverPeriod takes sound r, real start, real end, real time returns nothing
local timer k=CreateTimer()
call SaveSoundHandle(LS(),GetHandleId(k),StringHash("r"),r)
call SaveReal(LS(),GetHandleId(k),StringHash("start"),start)
call SaveReal(LS(),GetHandleId(k),StringHash("end"),end)
call SaveReal(LS(),GetHandleId(k),StringHash("lerp"),(end-start)/time*0.05)
call TimerStart(k,0.05,true,function SVOP_Callback)
endfunction


function MKU_CallBack takes nothing returns nothing
    local timer t=GetExpiredTimer()
    call KillUnit(LoadUnitHandle(udg_hash, GetHandleId(t), StringHash("r")))
    call FlushChildHashtable(udg_hash, GetHandleId(t))
    call DestroyTimer(t)
endfunction
function MoogleKillUnit takes unit Victim, unit Killer returns nothing
    //Fel should definitely make his own function
    local timer t=CreateTimer()
    call UnitRemoveBuffs(Victim, true, true)
    call ShowUnit(Victim, true)
    call SetUnitInvulnerable(Victim, false)
    call SetUnitState(Victim, UNIT_STATE_LIFE, 1)
    call UnitDamageTarget(Killer, Victim, 421337, true, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    call SaveUnitHandle(udg_hash, GetHandleId(t), StringHash("r"),Victim)
    call TimerStart(t,0.01,false,function MKU_CallBack)
endfunction
   
   function DropItem_FollowThrough takes nothing returns nothing
   local trigger t=GetTriggeringTrigger()
   local unit a=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
   local integer itemType=LoadInteger(LS(),GetHandleId(t),StringHash("itemType"))
   call CreateItem(itemType,GetUnitX(a),GetUnitY(a))
   call FlushChildHashtable(LS(),GetHandleId(t))
   call DestroyTrigger(t)
   endfunction
   
function DropItemFromUnitOnDeath takes unit a, integer itemType returns nothing
local trigger t=CreateTrigger()
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),a)
call SaveInteger(LS(),GetHandleId(t),StringHash("itemType"),itemType)
call TriggerAddAction(t,function DropItem_FollowThrough)
call TriggerRegisterUnitEvent(t,a,EVENT_UNIT_DEATH)
endfunction

function VendorDamagedCheck takes nothing returns nothing
local timer t=GetExpiredTimer()
local unit u=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
local effect d=LoadEffectHandle(LS(),GetHandleId(t),StringHash("effect"))
if not(IsUnitPaused(u)) or u==null then
call PauseTimer(t)
call FlushChildHashtable(LS(),GetHandleId(t))
call DestroyTimer(t)
call DestroyEffect(d)
endif
endfunction

function VendorIsDamaged takes unit a returns nothing
local boolean b=not(IsUnitPaused(a))
local unit c=a
local effect d
local timer t
if GetEventDamage()<0.5 then
return
endif
call PauseUnitForPeriod(a,10.0)
if b then
set d=AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl",GetUnitX(c),GetUnitY(c))
set t=CreateTimer()
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),c)
call SaveEffectHandle(LS(),GetHandleId(t),StringHash("effect"),d)
call TimerStart(t,0.2,true,function VendorDamagedCheck)
endif
endfunction

function Vendor_Damaged takes nothing returns nothing
local boolean b=not(IsUnitPaused(GetTriggerUnit()))
local unit c=GetTriggerUnit()
local effect d
call PauseUnitForPeriod(GetTriggerUnit(),10.0)
if b then
set d=AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl",GetUnitX(c),GetUnitY(c))
loop
exitwhen not(IsUnitPaused(c)) or c==null
call PolledWait(0.2)
endloop
call DestroyEffect(d)
endif
endfunction

function RegisterVendor takes unit vendor returns nothing
//Sets up the "vendor disabled for X seconds on damage"
local trigger t=udg_VendorTrigger
call TriggerRegisterUnitEvent(t,vendor,EVENT_UNIT_DAMAGED)
endfunction

function dinit takes nothing returns nothing
if GetUnitAbilityLevel(GetEnumUnit(),'A07Q')>0 then
call RegisterVendor(GetEnumUnit())
endif
endfunction

function vendorDamage_init takes nothing returns nothing
local group g=GetUnitsInRectAll(GetPlayableMapRect())
set udg_VendorTrigger=CreateTrigger()
call TriggerAddAction(udg_VendorTrigger,function Vendor_Damaged)
call ForGroup(g,function dinit)
endfunction




























function BasicAI_FindEvasionLoc takes location a, real max, real angle, location danger returns location
    local location suppose=a
    local location prev=Location(GetLocationX(a),GetLocationY(a))
    local integer ID=GetSector(a)
    local real i=0
    if max > 40 then
        loop
        exitwhen DistanceBetweenPoints(suppose,danger)>max
            set suppose=PolarProjectionBJ(a,i,angle)
            if GetTerrainCliffLevelBJ(suppose)>GetTerrainCliffLevelBJ(a) or not(LocInSector(suppose,ID)) or GetTerrainType(GetLocationX(suppose),GetLocationY(suppose))=='Vcbp' then
                call RemoveLocation(suppose)
                return prev
            endif
            call RemoveLocation(prev)
            set prev=suppose
            set i=i+40
            endloop
        return suppose
    else
        return Location(GetLocationX(a),GetLocationY(a))
    endif
endfunction

function BasicAI_EvadeDanger takes unit q, location danger, real clearradius, real passtime returns nothing
    local location a=GetUnitLoc(q)
    local real r=clearradius-DistanceBetweenPoints(a,danger)
    local real score=-9999
    local real tscore=0
    local location test
    local location winner=null
    local integer i=0
    local boolean b=LoadStr(LS(),GetHandleId(q),StringHash("AI_ORDER"))=="ATTACK"
    local unit targ
    local location targloc
    local real range=LoadReal(LS(),GetHandleId(q),StringHash("AI_ATTACKRANGE"))
    if b then
        set targ=LoadUnitHandle(LS(),GetHandleId(q),StringHash("AI_TARGET"))
        set targloc=GetUnitLoc(targ)
    endif
    if r > 0 then
        call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"EVADE")
        call SaveReal(LS(),GetHandleId(q),StringHash("AI_EVADE_PASSTIME"),TimerGetElapsed(udg_GameTimer)+passtime)
        loop
        exitwhen i > 40
            set test=BasicAI_FindEvasionLoc(a,clearradius*GetRandomReal(1,2),GetRandomDirectionDeg(),danger)
            set tscore=0
            if DistanceBetweenPoints(danger,test)>clearradius then
                set tscore=tscore+clearradius
            endif
            if b and DistanceBetweenPoints(targloc,test)<=range then
                set tscore=tscore+5
            endif
            if tscore > score then
                call RemoveLocation(winner)
                set winner=test
                set score=tscore
            else   
                call RemoveLocation(test)
            endif
            set i=i+1
        endloop
        call IssuePointOrderLoc(q,"move",winner)
        call RemoveLocation(winner)
        call RemoveLocation(a)
    endif
    if b then
        call RemoveLocation(targloc)
    endif
endfunction

function BasicAI_IssueDangerArea_Z takes nothing returns nothing
    local timer k=GetExpiredTimer()
    local location danger=LoadLocationHandle(LS(),GetHandleId(k),StringHash("danger"))
    local real clearradius=LoadReal(LS(),GetHandleId(k),StringHash("clearradius"))
    local real passtime=LoadReal(LS(),GetHandleId(k),StringHash("passtime"))
    local group g=GetUnitsInRangeOfLocAll(clearradius,danger)
    local unit test
    call FlushChildHashtable(LS(),GetHandleId(k))
    call DestroyTimer(k)
    loop
    exitwhen FirstOfGroup(g)==null
        set test=FirstOfGroup(g)
        if HaveSavedString(LS(),GetHandleId(test),StringHash("AI_TEAM")) then
            call BasicAI_EvadeDanger(test,danger,clearradius, passtime)
        endif
        call GroupRemoveUnit(g,test)
    endloop
    call DestroyGroup(g)
endfunction

function BasicAI_IssueDangerArea takes location danger, real clearradius, real passtime returns nothing
    local timer k=CreateTimer()
    call SaveLocationHandle(LS(),GetHandleId(k),StringHash("danger"),danger)
    call SaveReal(LS(),GetHandleId(k),StringHash("clearradius"),clearradius)
    call SaveReal(LS(),GetHandleId(k),StringHash("passtime"),passtime)
    call TimerStart(k,0.0,false,function BasicAI_IssueDangerArea_Z)
endfunction

function BasicAI_FindFleePlace takes unit q returns location
    local rect sector=udg_SectorId[GetUnitSector(q)]
    local integer consider=0
    local real score = 0
    local location a=GetUnitLoc(q)
    local location b
    local location c=a
    loop
    exitwhen consider > 100
        set b=GetRandomLocInRect(sector)
        if GetTerrainTypeBJ(b)=='Vcbp' then
            call RemoveLocation(b)
        else
            if DistanceBetweenPoints(a,b)>score then
                call RemoveLocation(c)
                set c=b
                set score=DistanceBetweenPoints(a,b)
            else
                call RemoveLocation(b)
            endif
        endif
        set consider=consider+1
    endloop
    return c
endfunction

function B2I takes boolean a returns integer
    if a then
        return 1
    else
        return 0
    endif
endfunction

function BasicAI_ScoreUnit takes unit q, unit consider returns real
    local real retz=0.0
    set retz = retz - DistanceBetweenUnits(consider,q)/600.0
    set retz = retz - 4*GetUnitLifePercent(consider)/100
    set retz = retz - 5*B2I(GetOwningPlayer(consider)==Player(PLAYER_NEUTRAL_PASSIVE))
    set retz = retz - 5*B2I(IsUnitType(consider,UNIT_TYPE_STRUCTURE))
    if UnitHasItemOfTypeBJ(consider,'I029') then
    set retz = retz - 100
    endif
    return retz
endfunction

function BasicAI_ConsiderTargets takes unit q, real acquirerange returns unit
//Considers all groups within a range of acquirerange and returns the best target, will return null if none
    local group g
    local group m
    local unit target=null
    local unit consider
    local real score
    local location a
    local string team =LoadStr(LS(),GetHandleId(q),StringHash("AI_TEAM"))
    set a=GetUnitLoc(q)
    set g=GetUnitsInRangeOfLocAll(acquirerange,a)
    call RemoveLocation(a)
    set m=CreateGroup()
    loop
    exitwhen FirstOfGroup(g)==null
        set consider=FirstOfGroup(g)
        if GetUnitAbilityLevel(consider,'Avul')==0 and IsUnitAliveBJ(consider) and (not(HaveSavedString(LS(),GetHandleId(consider),StringHash("AI_TEAM"))) or LoadStr(LS(),GetHandleId(consider),StringHash("AI_TEAM")) != team) and GetUnitTypeId(consider) != 'n00A' then
            call GroupAddUnit(m,consider)
        endif
        call GroupRemoveUnit(g,consider)
    endloop
    call DestroyGroup(g)
    if CountUnitsInGroup(m)>0 then
        if CountUnitsInGroup(m)>1 then
            set score=-999
            loop
            exitwhen FirstOfGroup(m)==null
                set consider=FirstOfGroup(m)
                if score <= BasicAI_ScoreUnit(q,consider) then
                    set target=consider
                    set score=BasicAI_ScoreUnit(q,consider)
                endif
                call GroupRemoveUnit(m,consider)
            endloop
        else
            set target=FirstOfGroup(m)
        endif
    endif
    call DestroyGroup(m)
    return target
endfunction

function BasicAI_Update takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local unit q=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
    local string order =LoadStr(LS(),GetHandleId(q),StringHash("AI_ORDER"))
    local string team =LoadStr(LS(),GetHandleId(q),StringHash("AI_TEAM"))
    local location a
    local location b
    local unit target=LoadUnitHandle(LS(),GetHandleId(q),StringHash("AI_TARGET"))
    local unit consider
    local real passtime
    local real attackrange=LoadReal(LS(),GetHandleId(q),StringHash("AI_ATTACKRANGE"))
    local real acquirerange=LoadReal(LS(),GetHandleId(q),StringHash("AI_ACQUIRERANGE"))
    if IsUnitHidden(q) then
        return
    endif
    if IsUnitDeadBJ(q) then
        call FlushChildHashtable(LS(),GetHandleId(t))
        call DestroyTimer(t)
        return
    endif
    if order == "ROAM" then
        set target=BasicAI_ConsiderTargets(q,acquirerange)
        if target != null then
            call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"ATTACK")
            call SaveUnitHandle(LS(),GetHandleId(q),StringHash("AI_TARGET"),target)
            set order="ATTACK"
        else
            set a=GetUnitLoc(q)
            if GetRandomInt(0,3)==0 then
                set b=PolarProjectionBJ(a,GetRandomReal(0,600.0),GetRandomDirectionDeg())
                call IssuePointOrderLoc(q,"move",b)
            endif
            call RemoveLocation(b)
            call RemoveLocation(a)
        endif
    endif
    if order == "ATTACK" then
        set consider = BasicAI_ConsiderTargets(q,acquirerange)
        if consider != target then
            if consider == null then
                call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"ROAM")
            else
                call SaveUnitHandle(LS(),GetHandleId(q),StringHash("AI_TARGET"),consider)
                call IssueTargetOrder(q,"attack",consider)
            endif
        else
            if not(OrderId2String(GetUnitCurrentOrder(q))=="attack") then
                call IssueTargetOrder(q,"attack",target)
            endif
        endif
    endif

    if order == "FLEE" then
        if GetUnitLifePercent(q)>50.0 then
            call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"ROAM")
            call SetUnitMoveSpeed(q,GetUnitMoveSpeed(q)-50.0)
        else
            set consider = BasicAI_ConsiderTargets(q,acquirerange)
            if consider != null and GetUnitCurrentOrder(q) != String2OrderIdBJ("move") then
                set a= BasicAI_FindFleePlace(q)
                call IssuePointOrderLoc(q,"move",a)
                call RemoveLocation(a)
            endif
        endif
    endif
    if order == "EVADE" then
        set passtime=LoadReal(LS(),GetHandleId(q),StringHash("AI_EVADE_PASSTIME"))
        if TimerGetElapsed(udg_GameTimer)>passtime then
            call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"ROAM")
        else
            if GetUnitCurrentOrder(q)!=String2OrderIdBJ("move") then
                set consider=BasicAI_ConsiderTargets(q,attackrange)
                if consider != null then
                    call IssueTargetOrder(q,"attack",consider)
                endif
            endif
        endif
    else
        if GetUnitLifePercent(q)<34.0 then
            call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"FLEE")
            call SetUnitMoveSpeed(q,GetUnitMoveSpeed(q)+50.0)
        endif
    endif
//
endfunction

function BasicAI takes unit q, real range, real acquirerange returns nothing
    local timer refresh=CreateTimer()  
    call SaveUnitHandle(LS(),GetHandleId(refresh),StringHash("unit"),q)
    call TimerStart(refresh,0.5,true,function BasicAI_Update)
    call SaveUnitHandle(LS(),GetHandleId(q),StringHash("AI_"+"TARGET"),null)
    call SaveStr(LS(),GetHandleId(q),StringHash("AI_TEAM"),"AI")
    call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"ROAM")
    call SaveReal(LS(),GetHandleId(q),StringHash("AI_ATTACKRANGE"),range)
    call SaveReal(LS(),GetHandleId(q),StringHash("AI_ACQUIRERANGE"),acquirerange)
endfunction
///



//
function BasicAI_Update_Murmusk takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local unit q=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
    local string order =LoadStr(LS(),GetHandleId(q),StringHash("AI_ORDER"))
    local string team =LoadStr(LS(),GetHandleId(q),StringHash("AI_TEAM"))
    local location a
    local location b
    local unit target=LoadUnitHandle(LS(),GetHandleId(q),StringHash("AI_TARGET"))
    local unit consider
    local real passtime
    local real attackrange=LoadReal(LS(),GetHandleId(q),StringHash("AI_ATTACKRANGE"))
    local real acquirerange=LoadReal(LS(),GetHandleId(q),StringHash("AI_ACQUIRERANGE"))
//
    if IsUnitHidden(q) then
        return
    endif
    if IsUnitDeadBJ(q) then
        call FlushChildHashtable(LS(),GetHandleId(t))
        call DestroyTimer(t)
        return
    endif
    if order == "ROAM" then
        set target=BasicAI_ConsiderTargets(q,acquirerange)
        if target != null then
            call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"ATTACK")
            call SaveUnitHandle(LS(),GetHandleId(q),StringHash("AI_TARGET"),target)
            set order="ATTACK"
        else
            set a=GetUnitLoc(q)
            if GetRandomInt(0,3)==0 then
                set b=PolarProjectionBJ(a,GetRandomReal(0,600.0),GetRandomDirectionDeg())
                call IssuePointOrderLoc(q,"move",b)
            endif
            call RemoveLocation(b)
            call RemoveLocation(a)
        endif
    endif
    if order == "ATTACK" then
        set consider = BasicAI_ConsiderTargets(q,acquirerange)
        if consider != target then
            if consider == null then
                call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"ROAM")
            else
                call SaveUnitHandle(LS(),GetHandleId(q),StringHash("AI_TARGET"),consider)
                call IssueTargetOrder(q,"attack",consider)
            endif
        else
            if not(OrderId2String(GetUnitCurrentOrder(q))=="attack") then
                call IssueTargetOrder(q,"attack",target)
            endif
        endif
    endif


    if order == "EVADE" then
        set passtime=LoadReal(LS(),GetHandleId(q),StringHash("AI_EVADE_PASSTIME"))
        if TimerGetElapsed(udg_GameTimer)>passtime then
            call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"ROAM")
        else
            if GetUnitCurrentOrder(q)!=String2OrderIdBJ("move") then
                set consider=BasicAI_ConsiderTargets(q,attackrange)
                if consider != null then
                    call IssueTargetOrder(q,"attack",consider)
                endif
            endif
        endif
    endif
//
endfunction
//
function BasicAI_Murmusk takes unit q, real range, real acquirerange returns nothing
    local timer refresh=CreateTimer()
    call SaveUnitHandle(LS(),GetHandleId(refresh),StringHash("unit"),q)
    call TimerStart(refresh,0.5,true,function BasicAI_Update_Murmusk)
    call SaveUnitHandle(LS(),GetHandleId(q),StringHash("AI_"+"TARGET"),null)
    call SaveStr(LS(),GetHandleId(q),StringHash("AI_TEAM"),"MURMUSK")
    call SaveStr(LS(),GetHandleId(q),StringHash("AI_ORDER"),"ROAM")
    call SaveReal(LS(),GetHandleId(q),StringHash("AI_ATTACKRANGE"),range)
    call SaveReal(LS(),GetHandleId(q),StringHash("AI_ACQUIRERANGE"),acquirerange)
endfunction

//////
/////
// function FloatingTextVisibilityCheck takes nothing returns nothing
// if IsLocationVisibleToPlayer(udg_TempPoint, GetEnumPlayer()) then
// if GetLocalPlayer() == GetEnumPlayer() then
// call SetTextTagVisibility(udg_TempTexttag, true)
// endif
// else
// if GetLocalPlayer() == GetEnumPlayer() then
// call SetTextTagVisibility(udg_TempTexttag, false)
// endif
// endif
// endfunction

// function FloatingTextVisibilityUpdate takes nothing returns nothing
// local timer t=GetExpiredTimer()
// local texttag a=LoadTextTagHandle(LS(),GetHandleId(t),StringHash("tt"))
// local location b=LoadLocationHandle(LS(),GetHandleId(t),StringHash("loc"))
// if a == null then
// call FlushChildHashtable(LS(),GetHandleId(t))
// call PauseTimer(t)
// call DestroyTimer(t)
// endif
// set udg_TempPoint=b
// set udg_TempTexttag=a
// call ForForce(GetPlayersAll(),function FloatingTextVisibilityCheck)
// endfunction

// function MakeFloatingTextVisibilityDependent takes texttag a, location b returns nothing
// local timer t=CreateTimer()
// call SaveLocationHandle(LS(),GetHandleId(t),StringHash("loc"),Location(GetLocationX(b),GetLocationY(b)))
// call SaveTextTagHandle(LS(),GetHandleId(t),StringHash("tt"),a)
// call TimerStart(t,0.25,true,function FloatingTextVisibilityUpdate)
// endfunction

////////////////////////////////////////////////////////////////////////////////////////////////////////
function SuitRoleAbilityReAdd_Child takes nothing returns nothing
    local timer k=GetExpiredTimer()
    local real q=LoadReal(LS(),GetHandleId(k),StringHash("q"))
    local unit a=LoadUnitHandle(LS(),GetHandleId(k),StringHash("a"))
    
    call FlushChildHashtable(LS(),GetHandleId(k))
    call DestroyTimer(k)
    call SetUnitLifePercentBJ(a,q)
    
    //If the role ability of the player is that of a doctor, then add the proper PhD ability.
    if udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(GetOwningPlayer(a))]] != 'A00X' then
        //Role abilities. Works in any suit form!
        call UnitAddAbilityBJ( udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(GetOwningPlayer(a))]], a )
    else
        //Dr. microRole abilities!
        call UnitAddAbilityBJ( udg_Dr_RoleAbility[udg_Researcher_PhD[GetConvertedPlayerId(GetOwningPlayer(a))]], a )
    endif
    
    
    //Do not mix up Human Form and Human Form (Spawn), or Alien Form and Alien Form (Spawn)
    if ( GetOwningPlayer(a) == udg_Parasite ) then
        //If peasant -> alien form ability
        if GetUnitTypeId(a) == 'h00H' then
            call UnitAddAbilityBJ( 'A02O', a )
            
        //Else if manipulation tree -> alien form ability anyway
        elseif udg_ParasiteUpgradingTo == 'h02V' or udg_ParasiteUpgradingTo == 'h033' then
            call UnitAddAbilityBJ( 'A02O', a )
            
        endif
            
    endif
    
    //Alien spawn form.
    if udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(a))] and udg_HiddenAndroid!=GetOwningPlayer(a) then
        if GetUnitTypeId(a) == 'h00H' then
            call UnitAddAbilityBJ( 'A02W', a )
        elseif udg_ParasiteUpgradingTo == 'h02V' or udg_ParasiteUpgradingTo == 'h033' then
            call UnitAddAbilityBJ( 'A02W', a )
        endif
            
    endif
    
    //Devour, for mutants in unsuited form.
    if ( GetOwningPlayer(a) == udg_Mutant ) and GetUnitTypeId(a) == 'h00H' then
        call UnitAddAbilityBJ( 'A05M', a )
    endif

    if udg_HiddenAndroid==GetOwningPlayer(a) then
        //Android tooltip. Unsuited form not necessary here.
        call UnitAddAbilityBJ( 'A05Z', a )
    endif
endfunction

function SuitRoleAbilityReAdd takes nothing returns nothing
//This JASS function is called at the end of the trigger to put on a suit. What it does basically is adds all the abilities and such
//that go with an unsuited unit back to the unit taking off their suit. It does so with a timer and a period of about 0.1, which seems
//near the minimum amount of time that the Chaos ability needs to be able to have abilities added to the transformed unit.
//Actual unit transformation is done with the chaos ability by the way.
local unit a=udg_TempUnit
local real q=udg_TempReal
local timer k=CreateTimer()
call PauseUnitForPeriod(a,0.1)
call UnitAddAbilityForPeriod(a,'Avul',0.1)
//Readds 'role abilities' after a suit is dropped or put on.
//Also re-adds transformation ability for aliens.
call SaveReal(LS(),GetHandleId(k),StringHash("q"),q)
call SaveUnitHandle(LS(),GetHandleId(k),StringHash("a"),a)
call TimerStart(k,0.2,false,function SuitRoleAbilityReAdd_Child)
endfunction


function PlaySound3D takes string soundName,real x,real y returns nothing
    local sound soundHandle = CreateSound(soundName, false, true, true, 12700, 12700, "")
    call SetSoundPosition(soundHandle,x,y,0)
    call StartSound(soundHandle)
    call KillSoundWhenDone(soundHandle)
endfunction


function SmashCancelSmash takes nothing returns nothing
local trigger t=GetTriggeringTrigger()
local unit a=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
local unit d=LoadUnitHandle(LS(),GetHandleId(t),StringHash("tsfx"))
call RemoveUnit(d)
call SetUnitState(a,UNIT_STATE_MANA,GetUnitState(a,UNIT_STATE_MANA)+35.0)
call SaveBoolean(LS(),GetHandleId(a),StringHash("Smash_Casting"),false)
call FlushChildHashtable(LS(),GetHandleId(t))
call DestroyTrigger(t)
endfunction


function SmashCheckEnsure takes unit a returns boolean
local location c=GetUnitLoc(a)
local boolean b=DistanceBetweenPoints(c,LoadLocationHandle(LS(),GetHandleId(a),StringHash("Smash_Location")))<125.0 and LoadBoolean(LS(),GetHandleId(a),StringHash("Smash_Casting"))
call RemoveLocation(c)
return b
endfunction

function SmashCheckCleanup takes unit a returns nothing
local trigger t=LoadTriggerHandle(LS(),GetHandleId(a),StringHash("Smash_Trigger"))
local unit d=LoadUnitHandle(LS(),GetHandleId(t),StringHash("tsfx"))
call RemoveUnit(d)
call FlushChildHashtable(LS(),GetHandleId(t))
call DestroyTrigger(t)
call RemoveLocation(LoadLocationHandle(LS(),GetHandleId(a),StringHash("Smash_Location")))
endfunction

function SmashEnsureNoOrders takes unit a returns nothing
local trigger t=CreateTrigger()
local location b=GetUnitLoc(a)
local location c=GetSpellTargetLoc()
local unit d=CreateScaledEffect2("Abilities\\Spells\\NightElf\\TrueshotAura\\TrueshotAura.mdl",1.6,4.0,GetLocationX(c),GetLocationY(c))
call RemoveLocation(c)
call SaveLocationHandle(LS(),GetHandleId(a),StringHash("Smash_Location"),b)
call SaveBoolean(LS(),GetHandleId(a),StringHash("Smash_Casting"),true)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),a)
call SaveTriggerHandle(LS(),GetHandleId(a),StringHash("Smash_Trigger"),t)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("tsfx"),d)
    call TriggerRegisterUnitEvent( t, a, EVENT_UNIT_ISSUED_TARGET_ORDER )
    call TriggerRegisterUnitEvent( t, a, EVENT_UNIT_ISSUED_POINT_ORDER )
    call TriggerRegisterUnitEvent( t, a, EVENT_UNIT_ISSUED_ORDER )
    call TriggerRegisterUnitEvent( t, a, EVENT_UNIT_USE_ITEM )
    call TriggerAddAction(t,function SmashCancelSmash)
endfunction


function CheckMaintainConsoleControl_Child takes nothing returns nothing
    if GetOwningPlayer(GetEnumUnit())==GetOwningPlayer(udg_TempUnit) and SubStringBJ(I2S(GetUnitPointValue(GetEnumUnit())), 1, 1) == "2" and IsUnitIllusion(GetEnumUnit()) == false then
        set udg_TempBool=true
    endif
endfunction

function CheckMaintainConsoleControl takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local unit p1=LoadUnitHandle(LS(),GetHandleId(t),StringHash("p1"))
    local unit p2=LoadUnitHandle(LS(),GetHandleId(t),StringHash("p2"))
    local rect r=LoadRectHandle(LS(),GetHandleId(t),StringHash("rect"))
    local group g=GetUnitsInRectAll(r)
    set udg_TempBool=false
    set udg_TempUnit=p1
    call ForGroup(g,function CheckMaintainConsoleControl_Child)
    call DestroyGroup(g)
    
    if udg_TempBool==false then
        call FlushChildHashtable(LS(),GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
        call SetUnitOwner( p1, Player(PLAYER_NEUTRAL_PASSIVE), false )
        call SetUnitOwner( p2, Player(PLAYER_NEUTRAL_PASSIVE), false )
    endif
endfunction

function CheckConsoleControl takes unit p1, unit p2, rect r returns nothing
    local timer t=CreateTimer()
    call SaveUnitHandle(LS(),GetHandleId(t),StringHash("p1"),p1)
    call SaveUnitHandle(LS(),GetHandleId(t),StringHash("p2"),p2)
    call SaveRectHandle(LS(),GetHandleId(t),StringHash("rect"),r)
    call TimerStart(t,1.0,true,function CheckMaintainConsoleControl)
endfunction

function BloodTestingWipe takes nothing returns nothing
//Searches to every inventory and deletes blood tests(and for shops) + GIT resolver.
//Gets triggered at GITResolve trigger, when an resolver is used near GIT.(after it passes the range check)
    local integer i
    local integer itemslot
    set i=1
    
            //call DisplayTextToForce( GetPlayersAll(), "Wiping bloodtests on every unit!")// Debug msg
    
    //Playerhero loop
    loop
    set itemslot=0
        loop // Inventory loop
            //If GIT Resolver or Genetic Testing Device
            if ( ( GetItemTypeId(UnitItemInSlot(udg_Playerhero[i], itemslot)) == 'I019' ) or ( GetItemTypeId(UnitItemInSlot(udg_Playerhero[i], itemslot)) == 'I00M' ) ) then
                call RemoveItem(UnitItemInSlot(udg_Playerhero[i], itemslot))
            endif
            set itemslot=itemslot + 1
            exitwhen itemslot == 7
        endloop
        set i = i + 1
            //call DisplayTextToForce( GetPlayersAll(), "i is:" + I2S(i))// Debug msg
        exitwhen i == 13
    endloop
    
            //call DisplayTextToForce( GetPlayersAll(), "Got out!")// Debug msg
    
    //Vendor/Shops removal
    call RemoveItemFromAllStock('I00M')
endfunction

function GetMasqueradeShopCount takes nothing returns integer

    local integer i
    set i = 0

    loop
        if (udg_MasqueradedShop[i] != null) then
            set i = i + 1
        endif
        
        exitwhen i == 5//[4] is max
    endloop
    
    return i

endfunction

function SetMasqueradeShop takes unit shop returns nothing

    local integer i
    set i = 0

    loop
        if (udg_MasqueradedShop[i] == null) then
            set udg_MasqueradedShop[i] = shop
            return
        endif
        
        set i = i + 1
        exitwhen i == 5//[4] is max
    endloop

endfunction

//Normally, should compare by unit-type, but whatever.
function ReturnMasqueradeShop takes nothing returns unit

    local integer i
    local unit returnedShop
    set i = 0

    loop
        if (udg_MasqueradedShop[i] != null) then
            set returnedShop = udg_MasqueradedShop[i]
            set udg_MasqueradedShop[i] = null
            return returnedShop
        endif
        
        set i = i + 1
        exitwhen i == 5//[4] is max
    endloop
    
    //Should never reach here, since it gets in here only when a structure is masqueraded.
    return null

endfunction

//Credits to Tal0n for RunCinematicUnstuck functions
function RunCinematicUnstuck takes player p, boolean enable returns nothing
  if ( GetLocalPlayer() == p ) then // the player who typed -unstuck
   call ClearTextMessages() // this can probably be disabled but it clears messages sent from triggers usually
   call ShowInterface(enable, 1.5) // disables/enables player interface
   call EnableUserControl(enable) // disables/enables player cursor and control
   call EnableOcclusion(enable)
   call EnableWorldFogBoundary(enable) // likely fixes filter bugs
  endif
endfunction
 
function CinematicUnstuckConditionsKappa takes nothing returns boolean
    local player p=GetTriggerPlayer()
    call RunCinematicUnstuck(p, false) // calls for a set of interface toggles offward
    call RunCinematicUnstuck(p, true) // calls for a set of interface toggles onward
    
    return true
endfunction

function CinematicUnstuckInit takes nothing returns nothing
    local trigger t=CreateTrigger()
    local integer i=0
    
    loop
        exitwhen i == 13 // this stops at brown ( player 12 )
            call TriggerRegisterPlayerChatEvent(t, Player(i), "-unstuck", true) // add the command for each player
            call TriggerAddCondition(t, Condition(function CinematicUnstuckConditionsKappa)) // the code for the command to work
        set i=i + 1 // go from red/player to next player
    endloop
endfunction

//Can't believe this didn't exist already.
function IsUnitPlayerHero takes unit chosenUnit returns boolean
    local integer i = 0
    
    loop
        exitwhen i == 12
            if chosenUnit == udg_Playerhero[i] then
                return true
            endif
    endloop
    
    return false
endfunction

//Utility function for not looping manually each time through the inventory
function RemoveItemTypeFromUnit takes unit inventoryUnit, integer itemId returns boolean
    local integer i = 0
    
    loop
        exitwhen i > 5
        
            //If item slot has the item, remove it
            if (GetItemTypeId(UnitItemInSlot(inventoryUnit, i)) == itemId ) then
                //call DisplayTextToForce(GetPlayersAll(), "i is: " + I2S(i))
                call UnitRemoveItemFromSlot(inventoryUnit, i)
                return true
            endif
        
        set i = i + 1
    endloop
    return false

endfunction

//Utility function for removing an item from a unit, without even checking if it has it (since it does it inside the function)
function DetermineRemoveItemTypeFromUnit takes unit inventoryUnit, integer itemId returns boolean

    if UnitHasItemOfTypeBJ(inventoryUnit, itemId) then
        call RemoveItemTypeFromUnit(inventoryUnit, itemId)
        return true
    endif
    
    return false

endfunction