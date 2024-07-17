if Debug then Debug.beginFile "Game/Abilities/Items/CaptainsKeycard" end
OnInit.map("CaptainsKeycard", function(require)
    ---@return boolean
    function Trig_CaptainsKeycard_Conditions()
        if (not (RectContainsUnit(gg_rct_ST5, GetManipulatingUnit()) == true)) then
            return false
        end
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00I'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_CaptainsKeycard_Func005Func001Func002C()
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B000'))) then
            return true
        end
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B001'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_CaptainsKeycard_Func005Func001C()
        if (not Trig_CaptainsKeycard_Func005Func001Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_CaptainsKeycard_Func005Func005Func001C()
        if (not (udg_TempBool == true)) then
            return false
        end
        if (not (udg_TempBool2 == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_CaptainsKeycard_Func005Func005C()
        if (not Trig_CaptainsKeycard_Func005Func005Func001C()) then
            return false
        end
        return true
    end

    function Trig_CaptainsKeycard_Func005A()
        if (Trig_CaptainsKeycard_Func005Func001C()) then
        else
            return
        end
        udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1"))
        udg_TempBool = IsTriggerEnabled(udg_TempTrigger)
        udg_TempBool2 = udg_TempTrigger ~= nil
        if (Trig_CaptainsKeycard_Func005Func005C()) then
            DisableTrigger(udg_TempTrigger)
            udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2"))
            udg_TempDoorHack = true
            TriggerExecute(udg_TempTrigger)
            udg_TempDoorHack = false
            DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")),
                999999, true)
            DisplayTimedTextToPlayer(GetOwningPlayer(GetManipulatingUnit()), 0, 0, 11.00, "|cffffcc00Door locked.|r")
        else
            EnableTrigger(udg_TempTrigger)
            TriggerExecute(udg_TempTrigger)
            KillDestructable(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")))
            DisplayTimedTextToPlayer(GetOwningPlayer(GetManipulatingUnit()), 0, 0, 11.00, "|cffffcc00Door unlocked.|r")
        end
    end

    function Trig_CaptainsKeycard_Actions()
        udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
        EnumDestructablesInCircleBJ(256, udg_TempPoint, Trig_CaptainsKeycard_Func005A)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_CaptainsKeycard = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CaptainsKeycard, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_CaptainsKeycard, Condition(Trig_CaptainsKeycard_Conditions))
    TriggerAddAction(gg_trg_CaptainsKeycard, Trig_CaptainsKeycard_Actions)
end)
if Debug then Debug.endFile() end