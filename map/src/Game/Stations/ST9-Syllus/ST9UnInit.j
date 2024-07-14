function Trig_ST9UnInit_Func001A takes nothing returns nothing
    call RemoveUnit( GetEnumUnit() )
endfunction

function Trig_ST9UnInit_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_ST9), function Trig_ST9UnInit_Func001A )
    call RemoveUnit( gg_unit_h04T_0265 )
    call DestroyTrigger(gg_trg_ST9UnInit)
    call DestroyTrigger(gg_trg_ST9Cell2AnomalyFix)
    call DestroyTrigger(gg_trg_ST9AttackEnd)
    call DestroyTrigger(gg_trg_ST9Attack)
    call DestroyTrigger(gg_trg_GravitationalPull)
    call DestroyTrigger(gg_trg_GravitationalPush)
    call DestroyTrigger(gg_trg_SyllusCageCell)
    call DestroyTrigger(gg_trg_SyllusCageCreate)
    call DestroyTrigger(gg_trg_SyllusCageDeath)
    call DestroyTrigger(gg_trg_SyllusCageOpen)
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_ST9UnInit takes nothing returns nothing
    set gg_trg_ST9UnInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_ST9UnInit, function Trig_ST9UnInit_Actions )
endfunction

