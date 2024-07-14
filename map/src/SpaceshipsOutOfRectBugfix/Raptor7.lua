//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions7 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS7) )
endfunction

//===========================================================================
function InitTrig_Raptor7 takes nothing returns nothing
    set gg_trg_Raptor7 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor7, gg_rct_SS7RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor7, gg_rct_SS7LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor7, gg_rct_SS7TopDebug )
    call TriggerAddAction( gg_trg_Raptor7, function Actions7 )
endfunction

