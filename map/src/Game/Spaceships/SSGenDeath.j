function Trig_SSGenDeath_Conditions takes nothing returns boolean
    if ( not ( GetDyingUnit() != gg_unit_h04E_0259 ) ) then
        return false
    endif
    if ( not ( GetDyingUnit() != gg_unit_h04V_0253 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SSGenDeath_Func016A takes nothing returns nothing
    call UnitAddAbilityBJ( 'A02T', GetEnumUnit() )
    call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, GetEnumUnit() )
    call UnitRemoveAbilityBJ( 'A04T', GetEnumUnit() )
    call UnitRemoveAbilityBJ( 'A04U', GetEnumUnit() )
    call MoogleKillUnit(GetEnumUnit(), udg_TempUnit2)
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveItem( UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()) )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

function Trig_SSGenDeath_Func018A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_MASKED, udg_Spaceship_Rect[GetUnitUserData(udg_TempUnit)] )
endfunction

function Trig_SSGenDeath_Actions takes nothing returns nothing
    local unit a=GetDyingUnit()
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4368" )
    set udg_TempUnit2 = GetKillingUnitBJ()
    set udg_TempUnit = GetDyingUnit()
    call PlaySoundBJ( gg_snd_CreepAggroWhat1 )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 5
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call CreateNUnitsAtLoc( 1, 'e001', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
        set udg_TempPoint = GetRandomLocInRect(udg_Spaceship_Rect[GetUnitUserData(udg_TempUnit)])
        call SetUnitAnimation( GetLastCreatedUnit(), "death" )
        call CreateNUnitsAtLoc( 1, 'e002', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
        call RemoveLocation(udg_TempPoint)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    set udg_TempUnit=a
        call DestroyTrigger( udg_Spaceship_Death[GetUnitUserData(udg_TempUnit)] )
        call DestroyTrigger( udg_Spaceship_ControlTrig[GetUnitUserData(udg_TempUnit)] )
        call DestroyTrigger( udg_Spaceship_EnterTrig[GetUnitUserData(udg_TempUnit)] )
        call DestroyTrigger( udg_Spaceship_ExitTrig[GetUnitUserData(udg_TempUnit)] )
        call DestroyTrigger( udg_Spaceship_ControlLossTrig[GetUnitUserData(udg_TempUnit)] )
    call SetUnitTimeScalePercent( udg_SS_Landed[GetUnitUserData(udg_TempUnit)], 100 )
    call ForGroupBJ( GetUnitsInRectAll(udg_Spaceship_Rect[GetUnitUserData(udg_TempUnit)]), function Trig_SSGenDeath_Func016A )
    set udg_TempUnit=a
    call ForForce( GetPlayersAll(), function Trig_SSGenDeath_Func018A )
    call RectOfDoom(udg_Spaceship_Rect[GetUnitAN(udg_TempUnit)])
endfunction

//===========================================================================
function InitTrig_SSGenDeath takes nothing returns nothing
    set gg_trg_SSGenDeath = CreateTrigger(  )
    call TriggerAddCondition( gg_trg_SSGenDeath, Condition( function Trig_SSGenDeath_Conditions ) )
    call TriggerAddAction( gg_trg_SSGenDeath, function Trig_SSGenDeath_Actions )
endfunction

