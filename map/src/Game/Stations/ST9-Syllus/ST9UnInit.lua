if Debug then Debug.beginFile "Game/Stations/ST9/ST9UnInit" end
OnInit.map("ST9UnInit", function(require)
    function Trig_ST9UnInit_Func001A()
        RemoveUnit(GetEnumUnit())
    end

    function Trig_ST9UnInit_Actions()
        ForGroupBJ(GetUnitsInRectAll(gg_rct_ST9), Trig_ST9UnInit_Func001A)
        RemoveUnit(gg_unit_h04T_0265)
        DestroyTrigger(gg_trg_ST9UnInit)
        DestroyTrigger(gg_trg_ST9Cell2AnomalyFix)
        DestroyTrigger(gg_trg_ST9AttackEnd)
        DestroyTrigger(gg_trg_ST9Attack)
        DestroyTrigger(gg_trg_GravitationalPull)
        DestroyTrigger(gg_trg_GravitationalPush)
        DestroyTrigger(gg_trg_SyllusCageCell)
        DestroyTrigger(gg_trg_SyllusCageCreate)
        DestroyTrigger(gg_trg_SyllusCageDeath)
        DestroyTrigger(gg_trg_SyllusCageOpen)
        DestroyTrigger(GetTriggeringTrigger())
    end

    --===========================================================================
    gg_trg_ST9UnInit = CreateTrigger()
    TriggerAddAction(gg_trg_ST9UnInit, Trig_ST9UnInit_Actions)
end)
if Debug then Debug.endFile() end
