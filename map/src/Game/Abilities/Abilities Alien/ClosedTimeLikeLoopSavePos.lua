if Debug then Debug.beginFile "Game/Abilities/Alien/ClosedTimeLikeLoopSavePos" end
OnInit.map("ClosedTimeLikeLoopSavePos", function(require)
    ---@return boolean
    function Trig_ClosedTimeLikeLoopSavePos_Func002C()
        if (not (udg_CTL_On >= 40)) then
            return false
        end
        return true
    end

    function Trig_ClosedTimeLikeLoopSavePos_Actions()
        if (Trig_ClosedTimeLikeLoopSavePos_Func002C()) then
            udg_CTL_On = 0
        else
        end
        udg_CTL_On = (udg_CTL_On + 1)
        udg_TempUnit = udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]
        udg_CTL_PosXArray[udg_CTL_On] = GetUnitX(udg_TempUnit)
        udg_CTL_PosYArray[udg_CTL_On] = GetUnitY(udg_TempUnit)
        udg_CTL_UnitType[udg_CTL_On] = GetUnitTypeId(udg_TempUnit)
        udg_CTL_InventorySlot1[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 1))
        udg_CTL_InventorySlot2[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 2))
        udg_CTL_InventorySlot3[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 3))
        udg_CTL_InventorySlot4[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 4))
        udg_CTL_InventorySlot5[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 5))
        udg_CTL_InventorySlot6[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 6))
        udg_CTL_UnitHealth[udg_CTL_On] = GetUnitStateSwap(UNIT_STATE_LIFE, udg_TempUnit)
        udg_CTL_UnitMana[udg_CTL_On] = GetUnitStateSwap(UNIT_STATE_MANA, udg_TempUnit)
        udg_CTL_Facing[udg_CTL_On] = GetUnitFacing(udg_TempUnit)
    end

    --===========================================================================
    gg_trg_ClosedTimeLikeLoopSavePos = CreateTrigger()
    DisableTrigger(gg_trg_ClosedTimeLikeLoopSavePos)
    TriggerRegisterTimerEventPeriodic(gg_trg_ClosedTimeLikeLoopSavePos, 0.25)
    TriggerAddAction(gg_trg_ClosedTimeLikeLoopSavePos, Trig_ClosedTimeLikeLoopSavePos_Actions)
end)
if Debug then Debug.endFile() end
