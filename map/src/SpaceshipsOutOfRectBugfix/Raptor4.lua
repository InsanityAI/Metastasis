//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions4 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS4) )
endfunction

//===========================================================================
function InitTrig_Raptor4 takes nothing returns nothing
    set gg_trg_Raptor4 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor4, gg_rct_SS4RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor4, gg_rct_SS4LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor4, gg_rct_SS4BottomDebug )
    call TriggerAddAction( gg_trg_Raptor4, function Actions4 )
endfunction

