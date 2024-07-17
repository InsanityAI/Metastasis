if Debug then Debug.beginFile "Game/Misc/SpawnVoidCannon" end
OnInit.map("SpawnVoidCannon", function(require)
    ---@return boolean
    function Trig_SpawnVoidCannon_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('n005'))) then --FourCC('n005') is snoeglay warden
            return false
        end
        return true
    end

    function EnumCannonUnits()
        if (GetItemTypeId(GetItemOfTypeFromUnitBJ(GetEnumUnit(), FourCC('I018'))) == FourCC('I018')) then
            AddSpecialEffectLocBJ(udg_TempPoint, "war3mapImported\\AncientExplode.mdx")
            DestroyEffectBJ(GetLastCreatedEffectBJ())
            CreateItemLoc(FourCC('I02C'), udg_TempPoint) --Create void cannon, at death of warden
        end
    end

    function Trig_SpawnVoidCannon_Actions()
        udg_TempPoint = GetUnitLoc(GetTriggerUnit())
        udg_TempUnitGroup = GetUnitsInRangeOfLocAll(1000.00, udg_TempPoint)
        ForGroupBJ(GetUnitsInRangeOfLocAll(1000.00, GetUnitLoc(GetTriggerUnit())), EnumCannonUnits)
        DestroyGroup(udg_TempUnitGroup)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_SpawnVoidCannon = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SpawnVoidCannon, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_SpawnVoidCannon, Condition(Trig_SpawnVoidCannon_Conditions))
    TriggerAddAction(gg_trg_SpawnVoidCannon, Trig_SpawnVoidCannon_Actions)
end)
if Debug then Debug.endFile() end
