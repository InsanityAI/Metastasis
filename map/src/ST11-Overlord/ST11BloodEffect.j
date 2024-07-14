function Trig_ST11BloodEffect_Actions takes nothing returns nothing
    set udg_TempPoint = GetRandomLocInRect(gg_rct_OverlordRect)
    call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl" )
    call RemoveLocation(udg_TempPoint)
    call SFXThreadClean()
endfunction

//===========================================================================
function InitTrig_ST11BloodEffect takes nothing returns nothing
    set gg_trg_ST11BloodEffect = CreateTrigger(  )
    call DisableTrigger( gg_trg_ST11BloodEffect )
    call TriggerRegisterTimerEventPeriodic( gg_trg_ST11BloodEffect, 0.20 )
    call TriggerAddAction( gg_trg_ST11BloodEffect, function Trig_ST11BloodEffect_Actions )
endfunction

