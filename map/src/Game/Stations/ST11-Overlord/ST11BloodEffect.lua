if Debug then Debug.beginFile "Game/Stations/ST11/ST11BloodEffect" end
OnInit.map("ST11BloodEffect", function(require)
    function Trig_ST11BloodEffect_Actions()
        udg_TempPoint = GetRandomLocInRect(gg_rct_OverlordRect)
        AddSpecialEffectLocBJ(udg_TempPoint,
            "Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
        RemoveLocation(udg_TempPoint)
        SFXThreadClean()
    end

    --===========================================================================
    gg_trg_ST11BloodEffect = CreateTrigger()
    DisableTrigger(gg_trg_ST11BloodEffect)
    TriggerRegisterTimerEventPeriodic(gg_trg_ST11BloodEffect, 0.20)
    TriggerAddAction(gg_trg_ST11BloodEffect, Trig_ST11BloodEffect_Actions)
end)
if Debug then Debug.endFile() end
