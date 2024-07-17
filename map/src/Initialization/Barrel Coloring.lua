if Debug then Debug.beginFile "Initialization/BarrelColoring" end
OnInit.final("BarrelColoring", function(require)
    udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('n00J'))
    ForGroup(udg_TempUnitGroup, function()
        SetUnitVertexColorBJ(GetEnumUnit(), GetRandomReal(1.00, 255.00), GetRandomReal(1.00, 255.00),
            GetRandomReal(1.00, 255.00), 1.00)
    end)
    DestroyGroup(udg_TempUnitGroup)
end)
if Debug then Debug.endFile() end
