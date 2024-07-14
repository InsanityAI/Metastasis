function Trig_MoonShieldFailure_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call PlaySoundBJ( gg_snd_Warning01 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_2741" )
    call AddWeatherEffectSaveLast( gg_rct_MoonRect, 'WOcw' )
    call EnableWeatherEffect( GetLastCreatedWeatherEffect(), true )
    call SetStackedSoundBJ( true, gg_snd_War3XMainGlueScreen, gg_rct_MoonRect )
    call StartTimerBJ( udg_MoonDamageTimer, true, 0.50 )
endfunction

//===========================================================================
function InitTrig_MoonShieldFailure takes nothing returns nothing
    set gg_trg_MoonShieldFailure = CreateTrigger(  )
    call TriggerRegisterUnitManaEvent( gg_trg_MoonShieldFailure, gg_unit_h03T_0209, LESS_THAN_OR_EQUAL, 0.00 )
    call TriggerAddAction( gg_trg_MoonShieldFailure, function Trig_MoonShieldFailure_Actions )
endfunction

