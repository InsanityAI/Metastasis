function Trig_Minotaur_Charge_Bugfix_Actions takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), OffsetLocation(GetUnitLoc(GetTriggerUnit()), 400.00, 0) )
endfunction

//===========================================================================
function InitTrig_Minotaur_Charge_Bugfix takes nothing returns nothing
    set gg_trg_Minotaur_Charge_Bugfix = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Minotaur_Charge_Bugfix, gg_rct_MinotaurChargeDebug )
    call TriggerAddAction( gg_trg_Minotaur_Charge_Bugfix, function Trig_Minotaur_Charge_Bugfix_Actions )
endfunction

