function Trig_ST6Console_Actions takes nothing returns nothing
    call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cffFF8040Activation code |r" + I2S(udg_Secret_ControlCode) + "|cffFF8040. Please proceed with caution.|r")
endfunction

//===========================================================================
function InitTrig_ST6Console takes nothing returns nothing
    set gg_trg_ST6Console = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_ST6Console, gg_rct_ST6Console )
    call TriggerAddAction( gg_trg_ST6Console, function Trig_ST6Console_Actions )
endfunction

