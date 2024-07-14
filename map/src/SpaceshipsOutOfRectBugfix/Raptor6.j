//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions6 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS6) )
endfunction

//===========================================================================
function InitTrig_Raptor6 takes nothing returns nothing
    set gg_trg_Raptor6 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor6, gg_rct_SS6RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor6, gg_rct_SS6LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor6, gg_rct_SS6BottomDebug )
    call TriggerAddAction( gg_trg_Raptor6, function Actions6 )
endfunction

