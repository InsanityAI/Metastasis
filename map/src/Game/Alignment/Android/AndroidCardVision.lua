if Debug then Debug.beginFile "Game/Allignment/Android/AndroidCardVision" end
OnInit.map("AndroidCardVision", function(require)
    ---@return boolean
    function Trig_AndroidCardVision_Func003Func002Func003Func001C()
        if (not (UnitHasItem(GetEnumUnit(), udg_Android_MemoryCard) == true)) then
            return false
        end
        return true
    end

    function Trig_AndroidCardVision_Func003Func002Func003A()
        if (Trig_AndroidCardVision_Func003Func002Func003Func001C()) then
            udg_Android_MemoryCardOwner = GetEnumUnit()
        else
        end
    end

    ---@return boolean
    function Trig_AndroidCardVision_Func003Func002C()
        if (not (UnitHasItem(udg_Android_MemoryCardOwner, udg_Android_MemoryCard) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidCardVision_Func003C()
        if (not (CheckItemStatus(udg_Android_MemoryCard, bj_ITEM_STATUS_OWNED) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidCardVision_Func005C()
        if (not (IsUnitDeadBJ(udg_TempUnit) == true)) then
            return false
        end
        return true
    end

    function Trig_AndroidCardVision_Actions()
        DestroyFogModifier(udg_AndroidCardVisibility)
        if (Trig_AndroidCardVision_Func003C()) then
            if (Trig_AndroidCardVision_Func003Func002C()) then
                udg_TempPoint = GetUnitLoc(udg_Android_MemoryCardOwner)
            else
                udg_TempUnitGroup = GetUnitsInRectAll(GetPlayableMapRect())
                ForGroupBJ(udg_TempUnitGroup, Trig_AndroidCardVision_Func003Func002Func003A)
                udg_TempPoint = GetUnitLoc(udg_Android_MemoryCardOwner)
                DestroyGroup(udg_TempUnitGroup)
            end
        else
            udg_TempPoint = GetItemLoc(udg_Android_MemoryCard)
        end
        udg_TempUnit = udg_Sector_Space[GetSector(udg_TempPoint)]
        if (Trig_AndroidCardVision_Func005C()) then
            DestroyTrigger(GetTriggeringTrigger())
            return
        else
        end
        CreateFogModifierRadiusLocBJ(true, udg_HiddenAndroid, FOG_OF_WAR_VISIBLE, udg_TempPoint, 650.00)
        udg_AndroidCardVisibility = GetLastCreatedFogModifier()
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_AndroidCardVision = CreateTrigger()
    DisableTrigger(gg_trg_AndroidCardVision)
    TriggerRegisterTimerEventPeriodic(gg_trg_AndroidCardVision, 1.00)
    TriggerAddAction(gg_trg_AndroidCardVision, Trig_AndroidCardVision_Actions)
end)
if Debug then Debug.endFile() end
