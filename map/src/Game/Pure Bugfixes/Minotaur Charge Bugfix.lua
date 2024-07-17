if Debug then Debug.beginFile "Game/PureBugfixes/MinotaurChargeBugfix" end
OnInit.map("MinotaurChargeBugfix", function(require)
    function Trig_Minotaur_Charge_Bugfix_Actions()
        SetUnitPositionLoc(GetTriggerUnit(), OffsetLocation(GetUnitLoc(GetTriggerUnit()), 400.00, 0))
    end

    --===========================================================================
    gg_trg_Minotaur_Charge_Bugfix = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Minotaur_Charge_Bugfix, gg_rct_MinotaurChargeDebug)
    TriggerAddAction(gg_trg_Minotaur_Charge_Bugfix, Trig_Minotaur_Charge_Bugfix_Actions)
end)
if Debug then Debug.endFile() end
