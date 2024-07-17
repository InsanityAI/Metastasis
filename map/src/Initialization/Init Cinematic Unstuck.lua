if Debug then Debug.beginFile "Initialization/InitCinematicUnstuck" end
OnInit.map("InitCinematicUnstuck", function(require)
    function Trig_Init_Cinematic_Unstuck_Actions()
        CinematicUnstuckInit()
    end

    --===========================================================================
    gg_trg_Init_Cinematic_Unstuck = CreateTrigger()
    TriggerAddAction(gg_trg_Init_Cinematic_Unstuck, Trig_Init_Cinematic_Unstuck_Actions)
end)
if Debug then Debug.endFile() end
