if Debug then Debug.beginFile "Game/Stations/ST10/ST10UnInit" end
OnInit.map("ST10UnInit", function(require)
    function Trig_ST10UnInit_Func001A()
        RemoveUnit(GetEnumUnit())
    end

    function Trig_ST10UnInit_Actions()
        ForGroupBJ(GetUnitsInRectAll(gg_rct_ST10V1), Trig_ST10UnInit_Func001A)
        RemoveUnit(gg_unit_h04V_0253)
        DestroyTrigger(GetTriggeringTrigger())
        DestroyTrigger(gg_trg_ST10Abilities)
        DestroyTrigger(gg_trg_ST10Death)
        DestroyTrigger(gg_trg_ST10Init)
        DestroyTrigger(gg_trg_ST10ViewLast)
        DestroyTrigger(gg_trg_ST10ViewLast)
        DestroyTrigger(gg_trg_ST10Abilities)
        DestroyTrigger(gg_trg_ST10Attack)
        DestroyTrigger(gg_trg_ST10AttackEnd)
    end

    --===========================================================================
    gg_trg_ST10UnInit = CreateTrigger()
    TriggerAddAction(gg_trg_ST10UnInit, Trig_ST10UnInit_Actions)
end)
if Debug then Debug.endFile() end
