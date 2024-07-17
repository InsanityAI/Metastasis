if Debug then Debug.beginFile "Game/Abilities/Roles/DoorHack" end
OnInit.trig("DoorHack", function(require)
    ---@return boolean
    function Trig_DoorHack_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A053'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_DoorHack_Func004Func001Func002C()
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B000'))) then
            return true
        end
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B001'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_DoorHack_Func004Func001C()
        if (not Trig_DoorHack_Func004Func001Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_DoorHack_Func004Func005Func001C()
        if (not (udg_TempBool == true)) then
            return false
        end
        if (not (udg_TempBool2 == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_DoorHack_Func004Func005C()
        if (not Trig_DoorHack_Func004Func005Func001C()) then
            return false
        end
        return true
    end

    function Trig_DoorHack_Func004A()
        if (Trig_DoorHack_Func004Func001C()) then
        else
            return
        end
        udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1"))
        udg_TempBool = IsTriggerEnabled(udg_TempTrigger)
        udg_TempBool2 = udg_TempTrigger ~= nil
        if (Trig_DoorHack_Func004Func005C()) then
            DisableTrigger(udg_TempTrigger)
            udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2"))
            udg_TempDoorHack = true
            TriggerExecute(udg_TempTrigger)
            udg_TempDoorHack = false
            DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")),
                999999, true)
            DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 11.00, "|cffffcc00Door locked.|r")
            udg_TempPoint = GetDestructableLoc(GetEnumDestructable())
            CreateNUnitsAtLoc(1, FourCC('e01A'), GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING)
            RemoveLocation(udg_TempPoint)
            udg_TempUnit = GetLastCreatedUnit()
            udg_CountUpBarColor = "|cff000000"
            SaveDestructableHandle(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("kittens"), GetEnumDestructable())
            CountUpBar(udg_TempUnit, 30, 0.50, "DoorResetLock")
        else
            DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 11.00,
                "|cffffcc00Door's not unlocked...|r")
        end
    end

    function Trig_DoorHack_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        EnumDestructablesInCircleBJ(256, udg_TempPoint, Trig_DoorHack_Func004A)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_DoorHack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_DoorHack, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_DoorHack, Condition(Trig_DoorHack_Conditions))
    TriggerAddAction(gg_trg_DoorHack, Trig_DoorHack_Actions)
end)
if Debug then Debug.endFile() end
