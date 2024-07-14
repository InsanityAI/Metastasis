//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions12 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS12) )
endfunction

//===========================================================================
function InitTrig_Albadar12 takes nothing returns nothing
    set gg_trg_Albadar12 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Albadar12, gg_rct_SS12RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Albadar12, gg_rct_SS12LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Albadar12, gg_rct_SS12TopDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Albadar12, gg_rct_SS12BottomDebug )
    call TriggerAddAction( gg_trg_Albadar12, function Actions12 )
endfunction

