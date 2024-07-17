if Debug then Debug.beginFile "Game/Stations/Moon/MoonShieldFailure" end
OnInit.map("MoonShieldFailure", function(require)
    function Trig_MoonShieldFailure_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        PlaySoundBJ(gg_snd_Warning01)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2741")
        AddWeatherEffectSaveLast(gg_rct_MoonRect, FourCC('WOcw'))
        EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        SetStackedSoundBJ(true, gg_snd_War3XMainGlueScreen, gg_rct_MoonRect)
        StartTimerBJ(udg_MoonDamageTimer, true, 0.50)
    end

    --===========================================================================
    gg_trg_MoonShieldFailure = CreateTrigger()
    TriggerRegisterUnitManaEvent(gg_trg_MoonShieldFailure, gg_unit_h03T_0209, LESS_THAN_OR_EQUAL, 0.00)
    TriggerAddAction(gg_trg_MoonShieldFailure, Trig_MoonShieldFailure_Actions)
end)
if Debug then Debug.endFile() end
