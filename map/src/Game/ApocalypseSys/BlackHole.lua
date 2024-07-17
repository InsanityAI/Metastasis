if Debug then Debug.beginFile "Game/ApocalypseSys/BlackHole" end
OnInit.map("BlackHole", function(require)
    function Trig_BlackHole_Actions()
        PlaySoundBJ(gg_snd_PursuitTheme)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5311")
        DestroyTrigger(gg_trg_MoonMovement)
        DestroyTrigger(gg_trg_PlanetMovement)
        EnableTrigger(gg_trg_DragIntoSun)
        EnableTrigger(gg_trg_Sunpod_apocalypse)
        DisableTrigger(gg_trg_SunUnitInRange)
    end

    --===========================================================================
    gg_trg_BlackHole = CreateTrigger()
    TriggerAddAction(gg_trg_BlackHole, Trig_BlackHole_Actions)
end)
if Debug then Debug.endFile() end
