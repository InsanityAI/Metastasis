function Trig_ParasiteSpawnCreateSpell_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc( 1, 'e00M', udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING )
    call CreateNUnitsAtLoc( 1, 'e00P', udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING )
    call CreateNUnitsAtLoc( 1, 'e015', udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING )
endfunction

//===========================================================================
function InitTrig_ParasiteSpawnCreateSpell takes nothing returns nothing
    set gg_trg_ParasiteSpawnCreateSpell = CreateTrigger(  )
    call TriggerAddAction( gg_trg_ParasiteSpawnCreateSpell, function Trig_ParasiteSpawnCreateSpell_Actions )
endfunction

