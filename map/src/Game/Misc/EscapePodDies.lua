if Debug then Debug.beginFile "Game/Misc/EscapePodDies" end
OnInit.map("EscapePodDies", function(require)
    ---@return boolean
    function Trig_EscapePodDies_Conditions()
        if (not (GetUnitTypeId(GetDyingUnit()) == FourCC('h02P'))) then
            return false
        end
        return true
    end

    function Trig_EscapePodDies_Actions()
        udg_TempPlayer = udg_EscapePod_Owner[GetUnitUserData(GetDyingUnit())]
        udg_TempUnit = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]
        udg_TempPoint = GetUnitLoc(udg_TempUnit)
        SetUnitPositionLoc(udg_TempUnit, udg_TempPoint)
        UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, udg_TempUnit)
        UnitAddAbilityBJ(FourCC('A02T'), udg_TempUnit)
        UnitRemoveAbilityBJ(FourCC('A04T'), udg_TempUnit)
        UnitRemoveAbilityBJ(FourCC('A04U'), udg_TempUnit)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            RemoveItem(UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA()))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        MoogleKillUnit(udg_TempUnit, GetKillingUnit())
    end

    --===========================================================================
    gg_trg_EscapePodDies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_EscapePodDies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_EscapePodDies, Condition(Trig_EscapePodDies_Conditions))
    TriggerAddAction(gg_trg_EscapePodDies, Trig_EscapePodDies_Actions)
end)
if Debug then Debug.endFile() end
