//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions8 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS8) )
endfunction

//===========================================================================
function InitTrig_Raptor8 takes nothing returns nothing
    set gg_trg_Raptor8 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor8, gg_rct_SS8RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor8, gg_rct_SS8LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor8, gg_rct_SS8BottomDebug )
    call TriggerAddAction( gg_trg_Raptor8, function Actions8 )
endfunction

