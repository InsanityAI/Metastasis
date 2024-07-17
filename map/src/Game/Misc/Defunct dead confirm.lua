if Debug then Debug.beginFile "Game/Misc/DefunctDeadConfirmed" end
OnInit.map("DefunctDeadConfirmed", function(require)
    function Trig_Defunct_dead_confirm_Actions()
        udg_Defunct_Dead = true
    end

    --===========================================================================
    gg_trg_Defunct_dead_confirm = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_Defunct_dead_confirm, gg_unit_h005_0024, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_Defunct_dead_confirm, Trig_Defunct_dead_confirm_Actions)
end)
if Debug then Debug.endFile() end
