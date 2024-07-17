if Debug then Debug.beginFile "Game/Stations/ST7/PirateCaptainDeath" end
OnInit.trig("PirateCaptainDeath", function(require)
    function Trig_PirateCaptainDeath_Actions()
        udg_SpaceAI_PirateCaptainAlive = false
        -- With this boolean, the AI won't touch the pirate ship
    end

    --===========================================================================
    gg_trg_PirateCaptainDeath = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_PirateCaptainDeath, gg_unit_h02C_0124, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_PirateCaptainDeath, Trig_PirateCaptainDeath_Actions)
end)
if Debug then Debug.endFile() end
