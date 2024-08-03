//TESH.scrollpos=24
//TESH.alwaysfold=0
function Trig_ST10Abilities_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h04U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST10Abilities_Func001Func001Func004C takes nothing returns boolean
    if ( not  ( GetSector(udg_TempPoint4)!=0 ) ) then
        return false
    endif
    if ( not  ( IsUnitAliveBJ(udg_Sector_Space[GetSector(udg_TempPoint4)]) ) ) then
        return false
    endif
    if ( not  ( GetTerrainType(GetLocationX(udg_TempPoint4),GetLocationY(udg_TempPoint4))!='Vcbp' ) ) then
        return false
    endif
    if ( not  ( GetTerrainCliffLevelBJ(udg_TempPoint4)<=GetTerrainCliffLevelBJ(udg_TempPoint3) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST10Abilities_Func001Func001Func029Func003C takes nothing returns boolean
    local player thisPlayer = GetOwningPlayer(GetEnumUnit())
    return GetEnumUnit() == udg_Playerhero[GetConvertedPlayerId(thisPlayer)] or (udg_Parasite == thisPlayer and udg_AlienForm_Alien == GetEnumUnit()) 
endfunction

function Trig_ST10Abilities_Func001Func001Func029A takes nothing returns nothing
    call SetUnitPositionLoc( GetEnumUnit(), udg_TempPoint4 )
    call UnitAddAbilityForPeriod(GetEnumUnit(),'Avul',1.7)
    if ( Trig_ST10Abilities_Func001Func001Func029Func003C() ) then
        if GetEnumUnit() == udg_AlienForm_Alien then
            call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint4, 0 )
        else
            call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetEnumUnit()), udg_TempPoint4, 0 )
        endif
    endif
endfunction

function Trig_ST10Abilities_Func001Func001C takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A081' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST10Abilities_Func001Func004C takes nothing returns boolean
local integer o=GetSector(udg_TempPoint4)
local unit s = udg_Sector_Space[o]
    if ( not  ( o!=0 ) ) then
        return false
    endif
    if not(IsUnitAliveBJ(s)) then
    return false
    endif
    if IsUnitExplorer(s) then
        if not(RectContainsUnit(gg_rct_Space,s)) and GetUnitSector(udg_SS_Landed[GetUnitAN(s)])<=0 then
            return false
        endif
    else
        if  IsUnitHidden(s) or not(RectContainsUnit(gg_rct_Space,s)) then
            return false
        endif
    endif
    
    if ( not  ( GetTerrainType(GetLocationX(udg_TempPoint4),GetLocationY(udg_TempPoint4))!='Vcbp' ) ) then
        return false
    endif
    if ( not  ( GetTerrainCliffLevelBJ(udg_TempPoint4)<=GetTerrainCliffLevelBJ(udg_TempPoint3) ) ) then
        return false
    endif
    if ( not ( IsPointPathable(GetLocationX(udg_TempPoint4),GetLocationY(udg_TempPoint4),true) ) )then
        return false
    endif
    return true
endfunction

function Trig_ST10Abilities_Func001C takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A082' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST10Abilities_Actions takes nothing returns nothing
local location a4
local location a3
local unit s=GetSpellAbilityUnit()
local sound r
local sound q
local player o=GetOwningPlayer(s)
if o==Player(bj_PLAYER_NEUTRAL_EXTRA) then
set o=udg_Parasite
endif
    if ( Trig_ST10Abilities_Func001C() ) then
        set a4 = GetSpellTargetLoc()
        set a3 = GetRectCenter(gg_rct_TransportationPlatform)
        set udg_TempPoint4=a4
        set udg_TempPoint3=a3
        if ( Trig_ST10Abilities_Func001Func004C() ) then
            call SaveLocationHandle(LS(),GetHandleId(s),StringHash("PortPlace"),a4)
            call DisplayTimedTextToPlayer( o, 0, 0, 15.00, ( "|cff00FFFF" + "Teleportation location set." ) )
        else
            call RemoveLocation( a3 )
            call DisplayTimedTextToPlayer( o, 0, 0, 15.00, "TRIGSTR_3872" + " Or the target location may not be pathable." )
        endif
        call RemoveLocation( a3 )
    else
        if ( Trig_ST10Abilities_Func001Func001C() ) then

            call IssueImmediateOrderBJ( s, "stop" )
            set a4=LoadLocationHandle(LS(),GetHandleId(s),StringHash("PortPlace"))
            set a3 = GetRectCenter(gg_rct_TransportationPlatform)
            set udg_TempPoint4=a4
            set udg_TempPoint3=a3
            
            if ( Trig_ST10Abilities_Func001Func001Func004C() ) then
            else
                call RemoveLocation( udg_TempPoint3 )
                call DisplayTimedTextToPlayer(o, 0, 0, 15.00, "TRIGSTR_3875" )
                return
            endif
set r=CreateSound("Sound\\Ambient\\DoodadEffects\\StoneBridgeRise.wav",true,true,true,126,126,"")
call SetSoundPitch(r,1.3)
call SetSoundPosition(r,GetLocationX(a4),GetLocationY(a4),0.0)
call SoundVolumeOverPeriod(r,40,127,19.0)
call PlaySoundBJ(r)
set q=CreateSound("Sound\\Ambient\\DoodadEffects\\StoneBridgeRise.wav",true,true,true,126,126,"")
call SetSoundPitch(q,1.3)
call SetSoundPosition(q,GetLocationX(a3),GetLocationY(a3),0.0)
call SoundVolumeOverPeriod(q,40,127,19.0)
call PlaySoundBJ(q)
            call CreateNUnitsAtLoc( 1, 'e01K', Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING )
            call SetUnitScalePercent( GetLastCreatedUnit(), 60.00, 60.00, 60.00 )
            call CreateNUnitsAtLoc( 1, 'e02Z', Player(PLAYER_NEUTRAL_PASSIVE), a4, bj_UNIT_FACING )
            call SizeUnitOverTime(GetLastCreatedUnit(),20.1,0.1,8,true)
            call CreateNUnitsAtLoc( 1, 'e02Z', Player(PLAYER_NEUTRAL_PASSIVE), a4, bj_UNIT_FACING )
            call SizeUnitOverTime(GetLastCreatedUnit(),20.1,0.1,8,true)
            call CreateNUnitsAtLoc( 1, 'e02Z', Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING )
            call SizeUnitOverTime(GetLastCreatedUnit(),20.1,0.1,8,true)
            call CreateNUnitsAtLoc( 1, 'e02Z', Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING )
            call SizeUnitOverTime(GetLastCreatedUnit(),20.1,0.1,8,true)
            call CreateNUnitsAtLoc( 1, 'e02Z', Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING )
            call SizeUnitOverTime(GetLastCreatedUnit(),20.1,0.1,8,true)
            call CreateNUnitsAtLoc( 1, 'e02Z', Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING )
            call SizeUnitOverTime(GetLastCreatedUnit(),20.1,0.1,8,true)
            set udg_TempUnit = GetLastCreatedUnit()
            set udg_CountUpBarColor = "|cffFF0080"
            call PauseUnitBJ( true, s )
            call CountUpBar(udg_TempUnit, 20,0.975, "DoNothing")
            call StopSound(r,true,true)
            call StopSound(q,true,true)
            set r=CreateSound("Sound\\Buildings\\Death\\NightElfBuildingDeathSmall1.wav",false,true,true,126,126,"")
call SetSoundPosition(r,GetLocationX(a3),GetLocationY(a3),0.0)
call PlaySoundBJ(r)
            set r=CreateSound("Sound\\Buildings\\Death\\NightElfBuildingDeathSmall1.wav",false,true,true,126,126,"")
call SetSoundPosition(r,GetLocationX(a4),GetLocationY(a4),0.0)
call PlaySoundBJ(r)
                       set udg_TempPoint4=a4
            call ForGroupBJ( GetUnitsInRectAll(gg_rct_TransportationPlatform), function Trig_ST10Abilities_Func001Func001Func029A )
            call PauseUnitBJ( false, s )
             call CreateNUnitsAtLoc( 1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), a3, GetRandomDirectionDeg() )
            call CreateNUnitsAtLoc( 1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), a3, GetRandomDirectionDeg() )
            call CreateNUnitsAtLoc( 1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), a3, GetRandomDirectionDeg() )
            call CreateNUnitsAtLoc( 1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), a4, GetRandomDirectionDeg() )
            call CreateNUnitsAtLoc( 1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), a4, GetRandomDirectionDeg() )
            call CreateNUnitsAtLoc( 1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), a4, GetRandomDirectionDeg() )

            call RemoveLocation( a3 )
            //call RemoveLocation( a4 )
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_ST10Abilities takes nothing returns nothing
    set gg_trg_ST10Abilities = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ST10Abilities, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ST10Abilities, Condition( function Trig_ST10Abilities_Conditions ) )
    call TriggerAddAction( gg_trg_ST10Abilities, function Trig_ST10Abilities_Actions )
endfunction

