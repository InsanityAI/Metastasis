if Debug then Debug.beginFile "HoldZone" end
OnInit.trig("HoldZone", function(require)
    function Trig_HoldZoneMask_Func002A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Timeout)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    function Trig_HoldZoneMask_Actions()
        ForForce(GetPlayersAll(), Trig_HoldZoneMask_Func002A)
    end

    --===========================================================================

    gg_trg_HoldZoneMask = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_HoldZoneMask, 5.00)
    TriggerAddAction(gg_trg_HoldZoneMask, Trig_HoldZoneMask_Actions)
end)
if Debug then Debug.endFile() end
