//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions10 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS10) )
endfunction

//===========================================================================
function InitTrig_Obda10 takes nothing returns nothing
    set gg_trg_Obda10 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Obda10, gg_rct_SS10RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Obda10, gg_rct_SS10LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Obda10, gg_rct_SS10TopDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Obda10, gg_rct_SS10BottomDebug )
    call TriggerAddAction( gg_trg_Obda10, function Actions10 )
endfunction

