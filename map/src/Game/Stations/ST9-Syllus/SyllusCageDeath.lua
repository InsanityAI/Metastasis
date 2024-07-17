if Debug then Debug.beginFile "Game/Stations/ST9/SyllusCageDeath" end
OnInit.trig("SyllusCageDeath", function(require)
    ---@return boolean
    function Trig_SyllusCageDeath_Conditions()
        if (not (GetUnitTypeId(GetDyingUnit()) == FourCC('h04Q'))) then
            return false
        end
        return true
    end

    function Trig_SyllusCageDeath_Func005A()
        SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint4)
        ShowUnitShow(GetEnumUnit())
        PauseUnitBJ(false, GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('Awan'), GetEnumUnit())
    end

    function Trig_SyllusCageDeath_Actions()
        udg_TempUnitGroup = LoadGroupHandle(LS(), GetHandleId(GetDyingUnit()), StringHash("CageGroup"))
        udg_TempPoint4 = GetUnitLoc(GetDyingUnit())
        ForGroupBJ(udg_TempUnitGroup, Trig_SyllusCageDeath_Func005A)
        RemoveLocation(udg_TempPoint)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_SyllusCageDeath = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SyllusCageDeath, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_SyllusCageDeath, Condition(Trig_SyllusCageDeath_Conditions))
    TriggerAddAction(gg_trg_SyllusCageDeath, Trig_SyllusCageDeath_Actions)
end)
if Debug then Debug.endFile() end
