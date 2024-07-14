function Trig_SolarIntensity_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_On[10] = true
    call RemoveLocation(udg_TempPoint)
    call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(90.00, 1200.00) )
    call SetTimeOfDay( 12 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2567" )
    set udg_SunDamage = 6.00
endfunction

//===========================================================================
function InitTrig_SolarIntensity takes nothing returns nothing
    set gg_trg_SolarIntensity = CreateTrigger(  )
    call DisableTrigger( gg_trg_SolarIntensity )
    call TriggerAddAction( gg_trg_SolarIntensity, function Trig_SolarIntensity_Actions )
endfunction

