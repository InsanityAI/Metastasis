if Debug then Debug.beginFile "Game/Abilities/Alien/ClosedTimeLikeLoop" end
OnInit.trig("ClosedTimeLikeLoop", function(require)
    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A033'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func004C()
        if (not (udg_TempInt > 40)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func005C()
        if (not (udg_CTL_PosXArray[udg_TempInt] == 0.00)) then
            return false
        end
        if (not (udg_CTL_PosYArray[udg_TempInt] == 0.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func012Func001Func004C()
        if (not (GetUnitTypeId(GetLastReplacedUnitBJ()) == FourCC('h00H'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func012Func001C()
        if (not (udg_CTL_UnitType[udg_TempInt] ~= FourCC('h02Y'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func012C()
        if (not (GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) ~= udg_CTL_UnitType[udg_TempInt])) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func016C()
        if (not (RectContainsLoc(gg_rct_Timeout, udg_TempPoint) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func020Func001C()
        if (not (GetItemLevel(UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA())) == 10)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func022C()
        if (not (GetItemLevel(GetLastCreatedItem()) == 8)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func023C()
        if (not (GetItemTypeId(GetLastCreatedItem()) == FourCC('I00L'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func025C()
        if (not (GetItemLevel(GetLastCreatedItem()) == 8)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func026C()
        if (not (GetItemTypeId(GetLastCreatedItem()) == FourCC('I00L'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func027C()
        if (not (GetItemTypeId(GetLastCreatedItem()) == FourCC('I00L'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func029C()
        if (not (GetItemLevel(GetLastCreatedItem()) == 8)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func030C()
        if (not (GetItemTypeId(GetLastCreatedItem()) == FourCC('I00L'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func032C()
        if (not (GetItemLevel(GetLastCreatedItem()) == 8)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func033C()
        if (not (GetItemTypeId(GetLastCreatedItem()) == FourCC('I00L'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func035C()
        if (not (GetItemLevel(GetLastCreatedItem()) == 8)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func037C()
        if (not (GetItemLevel(GetLastCreatedItem()) == 8)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ClosedTimeLikeLoop_Func038C()
        if (not (GetItemTypeId(GetLastCreatedItem()) == FourCC('I00L'))) then
            return false
        end
        return true
    end

    function Trig_ClosedTimeLikeLoop_Actions()
        udg_TempInt = (udg_CTL_On + 1)
        if (Trig_ClosedTimeLikeLoop_Func004C()) then
            udg_TempInt = 1
        else
        end
        if (Trig_ClosedTimeLikeLoop_Func005C()) then
            return
        else
        end
        udg_TempPoint = Location(udg_CTL_PosXArray[udg_TempInt], udg_CTL_PosYArray[udg_TempInt])
        -- Start - Bugfix Block for when you were in pod
        if (RectContainsCoords(gg_rct_Timeout, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint))) then
            return
        end
        -- End - Bugfix Block for when you were in pod
        if (Trig_ClosedTimeLikeLoop_Func012C()) then
            if (Trig_ClosedTimeLikeLoop_Func012Func001C()) then
                ReplaceUnitBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], udg_CTL_UnitType[udg_TempInt],
                    bj_UNIT_STATE_METHOD_RELATIVE)
                SetUnitOwner(GetLastReplacedUnitBJ(), udg_Parasite, true)
                udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastReplacedUnitBJ()
                if (Trig_ClosedTimeLikeLoop_Func012Func001Func004C()) then
                    UnitAddAbilityBJ(FourCC('A02O'), GetLastReplacedUnitBJ())
                else
                end
            else
                ReplaceUnitBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], udg_CTL_UnitType[udg_TempInt],
                    bj_UNIT_STATE_METHOD_RELATIVE)
                udg_AlienForm_Alien = GetLastReplacedUnitBJ()
                udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastReplacedUnitBJ()
                udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastReplacedUnitBJ()
            end
        else
        end
        udg_TempUnit = udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]
        SelectUnitForPlayerSingle(udg_TempUnit, udg_Parasite)
        PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0)
        if (Trig_ClosedTimeLikeLoop_Func016C()) then
            SetUnitPositionLocFacingBJ(udg_TempUnit, udg_TempPoint, udg_CTL_Facing[udg_TempInt])
        else
        end
        SetUnitLifeBJ(udg_TempUnit, udg_CTL_UnitHealth[udg_TempInt])
        SetUnitManaBJ(udg_TempUnit, udg_CTL_UnitMana[udg_TempInt])
        SetUnitManaBJ(udg_TempUnit, (GetUnitStateSwap(UNIT_STATE_MANA, udg_TempUnit) - 25.00))
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_ClosedTimeLikeLoop_Func020Func001C()) then
                UnitRemoveItemSwapped(UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA()), udg_TempUnit)
            else
                RemoveItem(UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA()))
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        UnitAddItemByIdSwapped(udg_CTL_InventorySlot1[udg_TempInt], udg_TempUnit)
        if (Trig_ClosedTimeLikeLoop_Func022C()) then
            RemoveItem(GetLastCreatedItem())
        else
        end
        if (Trig_ClosedTimeLikeLoop_Func023C()) then
            RemoveItem(GetLastCreatedItem())
            UnitAddItemByIdSwapped(FourCC('I01Y'), udg_TempUnit)
        else
        end
        UnitAddItemByIdSwapped(udg_CTL_InventorySlot2[udg_TempInt], udg_TempUnit)
        if (Trig_ClosedTimeLikeLoop_Func025C()) then
            RemoveItem(GetLastCreatedItem())
        else
        end
        if (Trig_ClosedTimeLikeLoop_Func026C()) then
            RemoveItem(GetLastCreatedItem())
            UnitAddItemByIdSwapped(FourCC('I01Y'), udg_TempUnit)
        else
        end
        if (Trig_ClosedTimeLikeLoop_Func027C()) then
            RemoveItem(GetLastCreatedItem())
            UnitAddItemByIdSwapped(FourCC('I01Y'), udg_TempUnit)
        else
        end
        UnitAddItemByIdSwapped(udg_CTL_InventorySlot3[udg_TempInt], udg_TempUnit)
        if (Trig_ClosedTimeLikeLoop_Func029C()) then
            RemoveItem(GetLastCreatedItem())
        else
        end
        if (Trig_ClosedTimeLikeLoop_Func030C()) then
            RemoveItem(GetLastCreatedItem())
            UnitAddItemByIdSwapped(FourCC('I01Y'), udg_TempUnit)
        else
        end
        UnitAddItemByIdSwapped(udg_CTL_InventorySlot4[udg_TempInt], udg_TempUnit)
        if (Trig_ClosedTimeLikeLoop_Func032C()) then
            RemoveItem(GetLastCreatedItem())
        else
        end
        if (Trig_ClosedTimeLikeLoop_Func033C()) then
            RemoveItem(GetLastCreatedItem())
            UnitAddItemByIdSwapped(FourCC('I01Y'), udg_TempUnit)
        else
        end
        UnitAddItemByIdSwapped(udg_CTL_InventorySlot5[udg_TempInt], udg_TempUnit)
        if (Trig_ClosedTimeLikeLoop_Func035C()) then
            RemoveItem(GetLastCreatedItem())
        else
        end
        UnitAddItemByIdSwapped(udg_CTL_InventorySlot6[udg_TempInt], udg_TempUnit)
        if (Trig_ClosedTimeLikeLoop_Func037C()) then
            RemoveItem(GetLastCreatedItem())
        else
        end
        if (Trig_ClosedTimeLikeLoop_Func038C()) then
            RemoveItem(GetLastCreatedItem())
            UnitAddItemByIdSwapped(FourCC('I01Y'), udg_TempUnit)
        else
        end
        RemoveLocation(udg_TempPoint)
        udg_TempUnitType = FourCC('e00K')
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        udg_TempReal = 40.00
        ExecuteFunc("AlienRequirementRemove")
        ExecuteFunc("AlienRequirementRestore")
    end

    --===========================================================================
    gg_trg_ClosedTimeLikeLoop = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ClosedTimeLikeLoop, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ClosedTimeLikeLoop, Condition(Trig_ClosedTimeLikeLoop_Conditions))
    TriggerAddAction(gg_trg_ClosedTimeLikeLoop, Trig_ClosedTimeLikeLoop_Actions)
end)
if Debug then Debug.endFile() end
