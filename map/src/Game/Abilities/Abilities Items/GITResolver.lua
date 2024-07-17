if Debug then Debug.beginFile "Game/Abilities/Items/GITResolver" end
OnInit.trigg("GITResolver", function(require)
    ---@return boolean
    function Trig_GITResolver_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I019'))) then
            return false
        end
        return true
    end

    function Trig_GITResolver_Actions()
        local a = gg_unit_h011_0100 ---@type unit --GIT

        --If not within 500 range from GIT
        if (IsUnitInRange(GetManipulatingUnit(), a, 500) == false) then                           -- Temporary workaround, but saves time so 2.0.-1 will come out in time :)
            DisplayTextToPlayer(GetOwningPlayer(GetManipulatingUnit()), 0, 0,
                "|cffffcc00This process can only be done in the Genetic Integrity Tester(GIT)|r") -- Debugging message
            SetItemCharges(GetManipulatedItem(), 1)
            IssueImmediateOrder(GetManipulatingUnit(), "stop")
            return
        end

        udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
        CreateNUnitsAtLoc(1, FourCC('h038'), GetOwningPlayer(GetManipulatingUnit()), udg_TempPoint, bj_UNIT_FACING)
        a = GetLastCreatedUnit()
        NewUnitRegister(GetLastCreatedUnit())
        udg_GIT_TesterGroup[GetUnitUserData(GetLastCreatedUnit())] = udg_GIT_TesterGroup
            [GetItemUserData(GetManipulatedItem())]
        udg_GIT_TesterStatus[GetUnitUserData(GetLastCreatedUnit())] = udg_GIT_TesterStatus
            [GetItemUserData(GetManipulatedItem())]
        udg_GIT_TesterString[GetUnitUserData(GetLastCreatedUnit())] = udg_GIT_TesterString
            [GetItemUserData(GetManipulatedItem())]
        RemoveItem(GetManipulatedItem())
        RemoveLocation(udg_TempPoint)
        PauseUnitBJ(true, GetLastCreatedUnit())
        udg_TempUnit = GetLastCreatedUnit()
        udg_CountUpBarColor = "|cff8080FF"
        CountUpBar(udg_TempUnit, 60, 1 / 6.0, "DoNothing")
        PauseUnitBJ(false, a)
    end

    --===========================================================================
    gg_trg_GITResolver = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GITResolver, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_GITResolver, Condition(Trig_GITResolver_Conditions))
    TriggerAddAction(gg_trg_GITResolver, Trig_GITResolver_Actions)
end)
if Debug then Debug.endFile() end
