function Trig_RenameEnd_Actions takes nothing returns nothing
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1557" )
    call DestroyTrigger(GetTriggeringTrigger())
    call DestroyTrigger(gg_trg_Rename)
    call DestroyTrigger(gg_trg_DeathSysTwo)
endfunction

//===========================================================================
function InitTrig_RenameEnd takes nothing returns nothing
    set gg_trg_RenameEnd = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_RenameEnd, 180.00 )
    call TriggerAddAction( gg_trg_RenameEnd, function Trig_RenameEnd_Actions )
endfunction

