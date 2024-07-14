function Trig_ST8Death_Func010A takes nothing returns nothing
    call UnitAddAbilityBJ( 'A02T', GetEnumUnit() )
    call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, GetEnumUnit() )
    call UnitRemoveAbilityBJ( 'A04T', GetEnumUnit() )
    call UnitRemoveAbilityBJ( 'A04U', GetEnumUnit() )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveItem( UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()) )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call MoogleKillUnit(GetEnumUnit(), GetKillingUnit())
    set udg_TempPoint = GetUnitLoc(GetEnumUnit())
    call CreateNUnitsAtLoc( 1, 'e001', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
    call SetUnitAnimation( GetLastCreatedUnit(), "death" )
    call RemoveLocation(udg_TempPoint)
endfunction

function Trig_ST8Death_Func012A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_ST8 )
endfunction

function Trig_ST8Death_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call DestroyTrigger(gg_trg_CalipoaAttack)
    call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00, 0, 0, 0 )
    call PlaySoundBJ( gg_snd_NecropolisUpgrade1 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_3540" )
    set udg_TempPoint = GetUnitLoc(GetDyingUnit())
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 2
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, GetRandomDirectionDeg(), GetRandomDirectionDeg())
        call CreateNUnitsAtLoc( 1, 'e01E', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, GetRandomDirectionDeg() )
        call SetUnitAnimation( GetLastCreatedUnit(), "death" )
        call RemoveLocation(udg_TempPoint2)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call RemoveLocation(udg_TempPoint)
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_ST8), function Trig_ST8Death_Func010A )
    call PolledWait( 5.00 )
    call ForForce( GetPlayersAll(), function Trig_ST8Death_Func012A )
    call RectOfDoom(gg_rct_ST8)
endfunction

//===========================================================================
function InitTrig_ST8Death takes nothing returns nothing
    set gg_trg_ST8Death = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_ST8Death, gg_unit_h04E_0259, EVENT_UNIT_DEATH )
    call TriggerAddAction( gg_trg_ST8Death, function Trig_ST8Death_Actions )
endfunction

