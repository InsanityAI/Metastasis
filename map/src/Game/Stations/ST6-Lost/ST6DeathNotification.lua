if Debug then Debug.beginFile "Game/Stations/ST6/ST6DeathNotification" end
OnInit.map("ST6DeathNotification", function(require)
    function Trig_ST6DeathNotification_Actions()
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00,
            0, 0, 0)
        PlaySoundBJ(gg_snd_NecropolisUpgrade1)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5198")
        TriggerExecute(gg_trg_ST6Death)
    end

    --===========================================================================
    gg_trg_ST6DeathNotification = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST6DeathNotification, gg_unit_h029_0114, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_ST6DeathNotification, Trig_ST6DeathNotification_Actions)
end)
if Debug then Debug.endFile() end
