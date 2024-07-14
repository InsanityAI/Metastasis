//TESH.scrollpos=64
//TESH.alwaysfold=0
function Trig_SetTrajectory_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A004' ) ) then
        return false
    endif
    return true
endfunction

//IsUnitAliveBJ(GetSpellTargetUnit()) == true

function Trig_SetTrajectory_Func001C takes nothing returns boolean
    if ( not ( RectContainsUnit(gg_rct_Space, GetSpellTargetUnit()) == true ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) != 'h02P' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) != 'h02H' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) != 'h02L' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) != 'h002' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) != 'h02B' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) != 'h029' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) != 'h005' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) != 'h02Q' )) then
        return false
    endif
    if (not ( IsUnitStation(GetSpellTargetUnit()) or IsUnitExplorer(GetSpellTargetUnit()))) then
        return false
    endif
    if ( not( GetUnitTypeId(GetSpellTargetUnit()) != 'h03J' )) then
        return false
    endif
    
    return true
endfunction

function Trig_SetTrajectory_Actions takes nothing returns nothing
local unit a=GetSpellAbilityUnit()
local unit b=GetSpellTargetUnit()
local player p=GetOwningPlayer(a)
local boolean boolz = false
local location k
local location i
local real q
local player r

    if ( Trig_SetTrajectory_Func001C() ) then
        set q=udg_SpaceObject_CollideRadius[GetUnitAN(GetSpellTargetUnit())]*1.2
        if q == 0 then
            set q=250.0
        endif
        
        set udg_TempPoint = GetUnitLoc(a)
        set udg_TempPoint2 = GetUnitLoc(b)
        call SetUnitOwner( a, Player(PLAYER_NEUTRAL_PASSIVE), true )
        call IssuePointOrderLocBJ( a, "move", udg_TempPoint2 )
        call SetUnitMoveSpeed( a, 180.00 )
        loop
            exitwhen boolz==true
                set k=GetUnitLoc(a)
                set i=GetUnitLoc(b)
                if DistanceBetweenPoints(k,i) <= q or GetUnitLifePercent(a)==0.0 or GetUnitLifePercent(b) == 0.0 then
                    set boolz=true
                else
                    call IssuePointOrderLocBJ( a, "move", i )
                endif
                call RemoveLocation(k)
                set k=null
                call RemoveLocation(i)
                set i=null
                call PolledWait(0.2)
        endloop
        
        if IsUnitAliveBJ(b) == true and IsUnitAliveBJ(a) == true then
            set r = udg_EscapePod_Owner[GetUnitAN(a)]
            call RemoveUnit( a)
            set udg_TempUnit=b
            if ( udg_TempUnit == gg_unit_h009_0029 ) then
                set udg_TempRect = gg_rct_ST4EscapePod
            else
                if ( udg_TempUnit == gg_unit_h003_0018 ) then
                    set udg_TempRect = gg_rct_ST1EscapePod
                else
                    if ( udg_TempUnit == gg_unit_h007_0027 ) then
                        set udg_TempRect = gg_rct_ST3EscapePod
                    else
                        if ( udg_TempUnit == gg_unit_h008_0196 ) then
                            set udg_TempRect = gg_rct_PlanetEscapePod
                        else
                            if ( udg_TempUnit == gg_unit_h00X_0049 ) then
                                set udg_TempRect = gg_rct_ST5EscapePod
                            else
                            if udg_TempUnit == gg_unit_h03T_0209 then
                            set udg_TempRect=gg_rct_MoonEscapePod
                            endif
                             if udg_TempUnit == gg_unit_h04E_0259 then
                            set udg_TempRect=gg_rct_ST8EscapePod
                            endif
                            if udg_TempUnit==gg_unit_h04T_0265 then
                            set udg_TempRect=gg_rct_ST9EscapePod
                            endif
                            if udg_TempUnit==gg_unit_h04V_0253 then
                            set udg_TempRect=gg_rct_ST10EscapePod
                            endif
                            if GetUnitTypeId(udg_TempUnit) == 'h04G' then
                                set udg_TempRect = gg_rct_OverlordPod
                            endif
                        endif
                    endif
                endif
            endif
            endif
            set udg_TempPoint = GetRectCenter(udg_TempRect)
            call CreateNUnitsAtLoc( 1, 'e006', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
            call SetUnitPositionLoc( udg_Playerhero[GetConvertedPlayerId(r)], udg_TempPoint )
            call ShowUnitShow( udg_Playerhero[GetConvertedPlayerId(r)] )
            call PauseUnitBJ( false, udg_Playerhero[GetConvertedPlayerId(r)] )
            call UnitRemoveAbility(udg_Playerhero[GetConvertedPlayerId(r)], 'A04V')
            call SetUnitLifePercentBJ(udg_Playerhero[GetConvertedPlayerId(r)], udg_EscapePod_LifeReset[GetUnitAN(a)])
            if r==Player(14) then
              call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint, 0 )
            call SelectUnitForPlayerSingle( udg_Playerhero[GetConvertedPlayerId(r)], udg_Parasite )
            else
            call PanCameraToTimedLocForPlayer( r, udg_TempPoint, 0 )
            call SelectUnitForPlayerSingle( udg_Playerhero[GetConvertedPlayerId(r)], r )
            endif
            call RemoveLocation( udg_TempPoint )
                    if udg_Mutant==r then
            call EnableTrigger( gg_trg_MutantUpgrade )
        endif
            set a=udg_Playerhero[GetConvertedPlayerId(r)]
        if udg_Parasite==r or Player(bj_PLAYER_NEUTRAL_EXTRA) == r then
            call EnableTrigger( gg_trg_ParasiteUpgrade )
        endif
        call UnitAddAbilityForPeriod(a,'Avul',4.0)
        else
            call SetUnitMoveSpeed(a,1)
            call SetUnitOwner(a,p, true)
            call SelectUnitForPlayerSingle(a,p)
            call PanCameraToForPlayer(p,GetUnitX(a),GetUnitY(a))
        endif
    else
        call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0,0, "|cffFF0000INVALID TARGET|r")
    endif
endfunction

//===========================================================================
function InitTrig_SetTrajectory takes nothing returns nothing
    set gg_trg_SetTrajectory = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SetTrajectory, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_SetTrajectory, Condition( function Trig_SetTrajectory_Conditions ) )
    call TriggerAddAction( gg_trg_SetTrajectory, function Trig_SetTrajectory_Actions )
endfunction

