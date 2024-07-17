if Debug then Debug.beginFile "Game/Suits/Suits" end
OnInit.trig("Suits", function(require)
    ---@return boolean
    function Trig_Suits_Conditions()
        if (not (udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == GetTriggerUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func004C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I000'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func005C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I001'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func006C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I007'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func007C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I008'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func008C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I009'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func009C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00A'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func010C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00B'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func011C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00C'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func012C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00D'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func013C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00E'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func014C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00X'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func015C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00Y'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func016C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00Z'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func017C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I011'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func018C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I01E'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func019C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I01G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func020C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I020'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func021C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I021'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func022C()
        if (not (SubStringBJ(I2S(GetUnitPointValue(GetTriggerUnit())), 2, 2) ~= "2")) then
            return false
        end
        if (not (udg_TempInt ~= 0)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func023Func001C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A0AF'), GetManipulatingUnit()) >= 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func023Func004C()
        if (not (GetUnitTypeId(GetManipulatingUnit()) == FourCC('h04K'))) then
            return false
        end
        if (not (GetItemTypeId(GetManipulatedItem()) ~= FourCC('I020'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Suits_Func023C()
        if (not (udg_TempInt ~= 0)) then
            return false
        end
        return true
    end

    function Trig_Suits_Actions()
        udg_TempInt = 0
        if (Trig_Suits_Func004C()) then
            udg_TempInt = 2
        else
        end
        if (Trig_Suits_Func005C()) then
            udg_TempInt = 3
        else
        end
        if (Trig_Suits_Func006C()) then
            udg_TempInt = 4
        else
        end
        if (Trig_Suits_Func007C()) then
            udg_TempInt = 5
        else
        end
        if (Trig_Suits_Func008C()) then
            udg_TempInt = 6
        else
        end
        if (Trig_Suits_Func009C()) then
            udg_TempInt = 7
        else
        end
        if (Trig_Suits_Func010C()) then
            udg_TempInt = 8
        else
        end
        if (Trig_Suits_Func011C()) then
            udg_TempInt = 9
        else
        end
        if (Trig_Suits_Func012C()) then
            udg_TempInt = 10
        else
        end
        if (Trig_Suits_Func013C()) then
            udg_TempInt = 11
        else
        end
        if (Trig_Suits_Func014C()) then
            udg_TempInt = 12
        else
        end
        if (Trig_Suits_Func015C()) then
            udg_TempInt = 13
        else
        end
        if (Trig_Suits_Func016C()) then
            udg_TempInt = 14
        else
        end
        if (Trig_Suits_Func017C()) then
            udg_TempInt = 15
        else
        end
        if (Trig_Suits_Func018C()) then
            udg_TempInt = 16
        else
        end
        if (Trig_Suits_Func019C()) then
            udg_TempInt = 17
        else
        end
        if (Trig_Suits_Func020C()) then
            udg_TempInt = 18
        else
        end
        if (Trig_Suits_Func021C()) then
            udg_TempInt = 19
        else
        end
        if (Trig_Suits_Func022C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cffffcc00This unit cannot use suits.|r")
            return
        else
        end
        if (Trig_Suits_Func023C()) then
            if (Trig_Suits_Func023Func001C()) then
                udg_TempItem = udg_Player_Suit[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))]
                SetItemUserData(udg_TempItem, 0)
                SetItemVisibleBJ(true, udg_TempItem)
                udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
                SetItemPositionLoc(udg_TempItem, udg_TempPoint)
                RemoveLocation(udg_TempPoint)
                UnitAddItemSwapped(udg_TempItem, GetManipulatingUnit())
            else
            end
            udg_TempReal = GetUnitLifePercent(GetManipulatingUnit())
            SetItemUserData(GetManipulatedItem(), GetUnitUserData(GetManipulatingUnit()))
            if (Trig_Suits_Func023Func004C()) then
                if HaveSavedHandle(LS(), GetHandleId(GetManipulatingUnit()), StringHash("Suit_SlivGroup")) then
                    DestroyGroup(LoadGroupHandle(LS(), GetHandleId(GetManipulatingUnit()), StringHash("Suit_SlivGroup")))
                end
            else
            end
            UnitAddAbilityBJ(FourCC('S001'), GetManipulatingUnit())
            SetUnitAbilityLevelSwapped(FourCC('S001'), GetManipulatingUnit(), udg_TempInt)
            udg_Player_Suit[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] = GetManipulatedItem()
            UnitRemoveItemSwapped(GetManipulatedItem(), GetManipulatingUnit())
            UnitRemoveItemSwapped(GetManipulatedItem(), GetManipulatingUnit())
            SetItemVisibleBJ(false, GetManipulatedItem())
            SetItemPawnable(GetManipulatedItem(), true)
            udg_TempUnit = GetManipulatingUnit()
            SetUnitLifePercentBJ(GetManipulatingUnit(), udg_TempReal)
            ExecuteFunc("SuitRoleAbilityReAdd")
            SetUnitLifePercentBJ(GetManipulatingUnit(), udg_TempReal)
        else
        end
    end

    --===========================================================================
    gg_trg_Suits = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Suits, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Suits, Condition(Trig_Suits_Conditions))
    TriggerAddAction(gg_trg_Suits, Trig_Suits_Actions)
end)
if Debug then Debug.endFile() end
