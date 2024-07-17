if Debug then Debug.beginFile "Initialization/BarrelColoring" end
OnInit.trig("BarrelColoring", function(require)
    function Trig_Barrel_Coloring_Func003A()
        SetUnitVertexColorBJ(GetEnumUnit(), GetRandomReal(1.00, 255.00), GetRandomReal(1.00, 255.00),
            GetRandomReal(1.00, 255.00), 1.00)
    end

    function Trig_Barrel_Coloring_Actions()
        udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('n00J'))
        ForGroupBJ(udg_TempUnitGroup, Trig_Barrel_Coloring_Func003A)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_Barrel_Coloring = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Barrel_Coloring, 0.00)
    TriggerAddAction(gg_trg_Barrel_Coloring, Trig_Barrel_Coloring_Actions)
end)
if Debug then Debug.endFile() end
