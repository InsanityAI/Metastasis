//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions11 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS11) )
endfunction

//===========================================================================
function InitTrig_Obda11 takes nothing returns nothing
    set gg_trg_Obda11 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Obda11, gg_rct_SS11RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Obda11, gg_rct_SS11LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Obda11, gg_rct_SS11TopDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Obda11, gg_rct_SS11BottomDebug )
    call TriggerAddAction( gg_trg_Obda11, function Actions11 )
endfunction

