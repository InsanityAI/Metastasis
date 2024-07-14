//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions13 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS13) )
endfunction

//===========================================================================
function InitTrig_Raptor13 takes nothing returns nothing
    set gg_trg_Raptor13 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor13, gg_rct_SS13RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor13, gg_rct_SS13LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor13, gg_rct_SS13TopDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor13, gg_rct_SS13BottomDebug )
    call TriggerAddAction( gg_trg_Raptor13, function Actions13 )
endfunction

