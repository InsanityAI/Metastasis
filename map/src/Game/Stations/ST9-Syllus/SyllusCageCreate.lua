if Debug then Debug.beginFile "Game/Stations/ST9/ST9SyllusCageCreate" end
OnInit.map("ST9SyllusCageCreate", function(require)
    ---@return boolean
    function Trig_SyllusCageCreate_Conditions()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02S'))) then
            return false
        end
        return true
    end

    function Trig_SyllusCageCreate_Func008A()
        udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
        udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 256.00, 270.00)
        AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl")
        SFXThreadClean()
        AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl")
        SFXThreadClean()
        SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint)
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
    end

    function Trig_SyllusCageCreate_Actions()
        PauseUnitBJ(true, gg_unit_h04R_0258)
        udg_TempUnit = gg_unit_h04R_0258
        udg_CountUpBarColor = "|cffFF0080"
        CountUpBar(udg_TempUnit, 30, 0.333, "DoNothing")
        PauseUnitBJ(false, gg_unit_h04R_0258)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Cage_Transport), Trig_SyllusCageCreate_Func008A)
        udg_TempPoint2 = GetRectCenter(gg_rct_Cage_Transport)
        AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl")
        SFXThreadClean()
        CreateNUnitsAtLoc(1, FourCC('h04Q'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, 45.00)
        SaveGroupHandle(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("CageGroup"), CreateGroup())
        SaveInteger(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("Cage_Weight"), 0)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_SyllusCageCreate = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SyllusCageCreate, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_SyllusCageCreate, Condition(Trig_SyllusCageCreate_Conditions))
    TriggerAddAction(gg_trg_SyllusCageCreate, Trig_SyllusCageCreate_Actions)
end)
if Debug then Debug.endFile() end
