//TESH.scrollpos=0
//TESH.alwaysfold=0
function Actions5 takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_SS5) )
endfunction

//===========================================================================
function InitTrig_Raptor5 takes nothing returns nothing
    set gg_trg_Raptor5 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor5, gg_rct_SS5RightDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor5, gg_rct_SS5LeftDebug )
    call TriggerRegisterEnterRectSimple( gg_trg_Raptor5, gg_rct_SS5TopDebug )
    call TriggerAddAction( gg_trg_Raptor5, function Actions5 )
endfunction

