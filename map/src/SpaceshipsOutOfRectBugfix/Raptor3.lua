//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions3 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS3) )
endfunction

//===========================================================================
function InitTrig_Raptor3 takes nothing returns nothing
    set gg_trg_Raptor3 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor3, gg_rct_SS3RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor3, gg_rct_SS3LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor3, gg_rct_SS3TopDebug )
    call TriggerAddAction( gg_trg_Raptor3, function Actions3 )
endfunction

