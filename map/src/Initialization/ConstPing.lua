if Debug then Debug.beginFile "Initialization/ConstPing" end
OnInit.trig("Initialization/ConstPing", function(require)
    function ConstPing_Callback()
        local a = GetPlayerhero(GetEnumPlayer()) ---@type unit
        SetCameraQuickPositionForPlayer(GetEnumPlayer(), GetUnitX(a), GetUnitY(a))
    end

    function Trig_ConstPing_Actions()
        ForForce(GetPlayersAll(), ConstPing_Callback)
    end

    --===========================================================================

    gg_trg_ConstPing = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_ConstPing, 0.10)
    TriggerAddAction(gg_trg_ConstPing, Trig_ConstPing_Actions)
end)
if Debug then Debug.endFile() end
