if Debug then Debug.beginFile "Game/Abilities/Items/GITResults" end
OnInit.trig("GITResults", function(require)
    ---@return boolean
    function Trig_GITResults_Conditions()
        if (not (GetItemTypeId(GetSoldItem()) == FourCC('I01A'))) then --I01A is the "Test Results" (sold) item
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_GITResults_Copy_Func015Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) == FourCC('h038'))) then --h038 is the GIT resolver unit
            return false
        end
        if (not (GetEnumUnit() ~= GetTriggerUnit())) then
            return false
        end
        return true
    end

    function Trig_GITResults_Copy_Func015A()
        if (Trig_GITResults_Copy_Func015Func001C()) then
            KillUnit(GetEnumUnit())
        end
    end

    function RemovePickedBloodtestItem()
        --call DisplayTextToForce( GetPlayersAll(), ".")// Debug msg
        if (GetItemTypeId(GetEnumItem()) == FourCC('I019') or GetItemTypeId(GetEnumItem()) == FourCC('I00M')) then
            RemoveItem(GetEnumItem())
            --call DisplayTextToForce( GetPlayersAll(), "Removed an bloodtest")// Debug msg
        end
    end

    function Trig_GITResults_Actions()
        --If Central GIT is dead, dont even bother.
        if (IsUnitDeadBJ(gg_unit_h011_0100) == true) then
            DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_3964")
            return
        end

        udg_TempItem = GetSoldItem()
        udg_TempString = "|cffffcc00This sample contains the DNA of:|r"
        DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, udg_TempString)
        DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0,
            udg_GIT_TesterString[GetUnitUserData(GetSellingUnit())])
        if (udg_GIT_TesterStatus[GetUnitUserData(GetSellingUnit())] == 1) then
            DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_2390")
        else
            if (udg_GIT_TesterStatus[GetUnitUserData(GetSellingUnit())] == 2) then
                DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_3125")
            else
                DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_3124")
            end
        end
        RemoveItem(udg_TempItem)

        -- =============================
        -- =======Blood Testing Wipe Below! =======
        -- =============================
        BloodTestingWipe()

        -- Below is to destroy any other GIT resolver that may happen within that time. It could be in above function, but lazy2stronk
        udg_TempLoc3 = GetUnitLoc(GetTriggerUnit())
        udg_TempUnitGroup = GetUnitsInRangeOfLocAll(3000.00, udg_TempLoc3)
        ForGroupBJ(udg_TempUnitGroup, Trig_GITResults_Copy_Func015A)

        --memory leak fixes
        DestroyGroup(udg_TempUnitGroup)
        RemoveLocation(udg_TempLoc3)

        -- Below is to delete any blood-testing item on the ground...
        EnumItemsInRectBJ(GetPlayableMapRect(), RemovePickedBloodtestItem)
    end

    --===========================================================================
    gg_trg_GITResults = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GITResults, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddCondition(gg_trg_GITResults, Condition(Trig_GITResults_Conditions))
    TriggerAddAction(gg_trg_GITResults, Trig_GITResults_Actions)
end)
if Debug then Debug.endFile() end
