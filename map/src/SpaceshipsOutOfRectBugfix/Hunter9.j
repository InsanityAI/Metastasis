//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions9 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS9) )
endfunction

//===========================================================================
function InitTrig_Hunter9 takes nothing returns nothing
    set gg_trg_Hunter9 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Hunter9, gg_rct_SS9RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Hunter9, gg_rct_SS9LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Hunter9, gg_rct_SS9TopDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Hunter9, gg_rct_SS9BottomDebug )
    call TriggerAddAction( gg_trg_Hunter9, function Actions9 )
endfunction

