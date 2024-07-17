if Debug then Debug.beginFile "Game/Misc/FusionBombInit" end
OnInit.map("FusionBombInit", function(require)
    function Trig_FusionBombsInit_Func003A()
        SetUnitAnimation(GetEnumUnit(), "stand work")
    end

    function Trig_FusionBombsInit_Func007A()
        ResetUnitAnimation(GetEnumUnit())
    end

    function Trig_FusionBombsInit_Actions()
        udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('h014'))
        ForGroupBJ(udg_TempUnitGroup, Trig_FusionBombsInit_Func003A)
        DestroyGroup(udg_TempUnitGroup)
        PolledWait(58.00)
        udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('h014'))
        ForGroupBJ(udg_TempUnitGroup, Trig_FusionBombsInit_Func007A)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_FusionBombsInit = CreateTrigger()
    TriggerAddAction(gg_trg_FusionBombsInit, Trig_FusionBombsInit_Actions)
end)
if Debug then Debug.endFile() end
