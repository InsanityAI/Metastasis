//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions1 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS1) )
endfunction

//===========================================================================
function InitTrig_Raptor1 takes nothing returns nothing
    set gg_trg_Raptor1 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor1, gg_rct_SS1RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor1, gg_rct_SS1LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor1, gg_rct_SS1TopDebug )
    call TriggerAddAction( gg_trg_Raptor1, function Actions1 )
endfunction

