if Debug then Debug.beginFile "Game/Abilities/Items/GITAddTestsToMedshops" end
OnInit.map("GITAddTestsToMedshops", function(require)
    function Trig_GITAddTestsToMedshops_Func003A()
        AddItemToStockBJ(FourCC('I00M'), GetEnumUnit(), 0, 1)
    end

    function Trig_GITAddTestsToMedshops_Actions()
        udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('h00G'))
        ForGroupBJ(udg_TempUnitGroup, Trig_GITAddTestsToMedshops_Func003A)
        AddItemToStockBJ(FourCC('I00M'), gg_unit_h011_0100, 0, 99)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_GITAddTestsToMedshops = CreateTrigger()
    TriggerAddAction(gg_trg_GITAddTestsToMedshops, Trig_GITAddTestsToMedshops_Actions)
end)
if Debug then Debug.endFile() end
