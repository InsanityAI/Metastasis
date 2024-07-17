if Debug then Debug.beginFile "Game/Stations/ST4/GITDeath" end
OnInit.map("GITDeath", function(require)
    function Trig_GITDeath_Actions()
        DestroyTrigger(gg_trg_GITDeath)
        DestroyTrigger(gg_trg_GIT)
        BloodTestingWipe()
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 2.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0, 100.00, 0,
            0)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_797")
    end

    --===========================================================================
    gg_trg_GITDeath = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_GITDeath, gg_unit_h011_0100, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_GITDeath, Trig_GITDeath_Actions)
end)
if Debug then Debug.endFile() end
