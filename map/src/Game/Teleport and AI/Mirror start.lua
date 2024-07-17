if Debug then Debug.beginFile "Game/TeleportAndAI/MirrorStart" end
OnInit.trig("MirrorStart", function(require)
    ---@return boolean
    function Trig_Mirror_start_Conditions()
        if (not (udg_Mirror_Enabled == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mirror_start_Func006Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) == FourCC('H03I'))) then
            return false
        end
        return true
    end

    function Trig_Mirror_start_Func006A()
        if (Trig_Mirror_start_Func006Func001C()) then
        else
            CreateNUnitsAtLoc(1, GetUnitTypeId(GetEnumUnit()), Player(PLAYER_NEUTRAL_PASSIVE),
                GetRandomLocInRect(gg_rct_Mirror_Arena), bj_UNIT_FACING)
            UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 1)), GetLastCreatedUnit())
            UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 2)), GetLastCreatedUnit())
            UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 3)), GetLastCreatedUnit())
            UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 4)), GetLastCreatedUnit())
            UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 5)), GetLastCreatedUnit())
            UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(), 6)), GetLastCreatedUnit())
            GroupAddUnitSimple(GetLastCreatedUnit(), udg_Mirror_Hostilegroup)
            -- Cache the playerhero units, so as to exit when they are dead
            if IsUnitPlayerhero(GetEnumUnit()) then
                GroupAddUnitSimple(GetLastCreatedUnit(), udg_Mirror_KillExitGroup)
            end
        end
    end

    ---@return boolean
    function Trig_Mirror_start_Func007Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) == FourCC('H03I'))) then
            return false
        end
        return true
    end

    function Trig_Mirror_start_Func007A()
        if (Trig_Mirror_start_Func007Func001C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetEnumUnit()), 0, 0,
                "|CFFE55BB0You have just intervened with yourself from an alternative dimension!\n\nVictory might bring you to U.S.I. Niffy")
        else
        end
    end

    function Trig_Mirror_start_Actions()
        StartTimerBJ(udg_Mirror_Timer, false, 60.00)
        TriggerSleepAction(0.30)
        udg_Mirror_Enabled = true
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Mirror_Arena)
        ForGroupBJ(udg_TempUnitGroup, Trig_Mirror_start_Func006A)
        ForGroupBJ(udg_TempUnitGroup, Trig_Mirror_start_Func007A)
        DestroyGroup(udg_TempUnitGroup)
        EnableTrigger(gg_trg_Mirror_relocation)
        EnableTrigger(gg_trg_Mirror_un_abuse)
        EnableTrigger(gg_trg_Mirror_A_I)
        DisableTrigger(GetTriggeringTrigger())
    end

    --===========================================================================
    gg_trg_Mirror_start = CreateTrigger()
    DisableTrigger(gg_trg_Mirror_start)
    TriggerAddCondition(gg_trg_Mirror_start, Condition(Trig_Mirror_start_Conditions))
    TriggerAddAction(gg_trg_Mirror_start, Trig_Mirror_start_Actions)
end)
if Debug then Debug.endFile() end
