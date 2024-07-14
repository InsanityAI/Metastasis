//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions2 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS2) )
endfunction

//===========================================================================
function InitTrig_Raptor2 takes nothing returns nothing
    set gg_trg_Raptor2 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor2, gg_rct_SS2RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor2, gg_rct_SS2LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor2, gg_rct_SS2BottomDebug )
    call TriggerAddAction( gg_trg_Raptor2, function Actions2 )
endfunction

