function Trig_MoonDeath_Func017A takes nothing returns nothing
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

function Trig_MoonDeath_Func019A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_MoonRect )
endfunction

function Trig_MoonDeath_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call DestroyTrigger(gg_trg_MoonMovement)
    call DestroyTrigger(gg_trg_GravitationalControl)
    call DestroyTrigger(gg_trg_GravitationalControlAngle)
    call DestroyTrigger(gg_trg_GravitationalControlTarget)
    call DestroyTrigger(gg_trg_MoonAttack)
    call DestroyTrigger(gg_trg_MoonAttackEnd)
    call DestroyTrigger(gg_trg_MoonDamage)
    call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00, 0, 0, 0 )
    call PlaySoundBJ( gg_snd_NecropolisUpgrade1 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2739" )
    set udg_TempPoint = GetUnitLoc(GetDyingUnit())
    call CreateNUnitsAtLoc( 1, 'e00E', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING )
    call RemoveLocation(udg_TempPoint)
    call SetUnitVertexColorBJ( gg_unit_h03T_0209, 100, 100, 100, 100.00 )
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_MoonRect), function Trig_MoonDeath_Func017A )
    call PolledWait( 5.00 )
    call ForForce( GetPlayersAll(), function Trig_MoonDeath_Func019A )
    call RectOfDoom(gg_rct_MoonRect)
endfunction

//===========================================================================
function InitTrig_MoonDeath takes nothing returns nothing
    set gg_trg_MoonDeath = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_MoonDeath, gg_unit_h03T_0209, EVENT_UNIT_DEATH )
    call TriggerAddAction( gg_trg_MoonDeath, function Trig_MoonDeath_Actions )
endfunction

