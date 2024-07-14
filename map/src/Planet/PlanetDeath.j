function Trig_PlanetDeath_Func015A takes nothing returns nothing
    call UnitAddAbilityBJ( 'A02T', GetEnumUnit() )
    call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, GetEnumUnit() )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveItem( UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()) )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call UnitRemoveAbilityBJ( 'A04T', GetEnumUnit() )
    call UnitRemoveAbilityBJ( 'A04U', GetEnumUnit() )
    call MoogleKillUnit(GetEnumUnit(), GetKillingUnit())
    set udg_TempPoint = GetUnitLoc(GetEnumUnit())
    call CreateNUnitsAtLoc( 1, 'e001', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
    call SetUnitAnimation( GetLastCreatedUnit(), "death" )
    call RemoveLocation(udg_TempPoint)
endfunction

function Trig_PlanetDeath_Func016C takes nothing returns boolean
    if ( not ( udg_Swagger_Grounded == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_PlanetDeath_Func018A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Planet )
endfunction

function Trig_PlanetDeath_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call DestroyTrigger(gg_trg_PlanetDamage)
    call DestroyTrigger(gg_trg_PlanetDamagePerSecond)
    call DestroyTrigger(gg_trg_MoonMovement)
    call DestroyTrigger(gg_trg_Snoeglays)
    call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00, 0, 0, 0 )
    call PlaySoundBJ( gg_snd_NecropolisUpgrade1 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2973" )
    set udg_TempPoint = GetUnitLoc(GetDyingUnit())
    call CreateNUnitsAtLoc( 1, 'e00E', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING )
    call RemoveLocation(udg_TempPoint)
    call SetUnitPositionLoc( gg_unit_h008_0196, udg_HoldZone )
    call SetUnitVertexColorBJ( gg_unit_h008_0196, 100, 100, 100, 100.00 )
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_Planet), function Trig_PlanetDeath_Func015A )
    if ( Trig_PlanetDeath_Func016C() ) then
        call KillUnit( gg_unit_h00X_0049 )
    else
    endif
    call PolledWait( 5.00 )
    call ForForce( GetPlayersAll(), function Trig_PlanetDeath_Func018A )
    call RectOfDoom(gg_rct_Planet)
endfunction

//===========================================================================
function InitTrig_PlanetDeath takes nothing returns nothing
    set gg_trg_PlanetDeath = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_PlanetDeath, gg_unit_h008_0196, EVENT_UNIT_DEATH )
    call TriggerAddAction( gg_trg_PlanetDeath, function Trig_PlanetDeath_Actions )
endfunction

