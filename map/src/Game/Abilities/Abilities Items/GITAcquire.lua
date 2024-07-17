if Debug then Debug.beginFile "Game/Abilities/Items/GITAcquire" end
OnInit.map("GITAcquire", function(require)
    ---@return boolean
    function Trig_GITAcquire_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I00M'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_GITAcquire_Func004Func001C()
        if (not (GetItemTypeId(UnitItemInSlotBJ(GetManipulatingUnit(), GetForLoopIndexA())) == FourCC('I00M'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_GITAcquire_Func005C()
        if (not (udg_TempInt > 1)) then
            return false
        end
        return true
    end

    function Trig_GITAcquire_Actions()
        udg_TempInt = 0
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_GITAcquire_Func004Func001C()) then
                udg_TempInt = (udg_TempInt + 1)
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        if (Trig_GITAcquire_Func005C()) then
            DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10.00,
                "|cffffcc00You may only carry one of these devices.|r")
            UnitRemoveItemSwapped(GetManipulatedItem(), GetManipulatingUnit())
        else
        end
    end

    --===========================================================================
    gg_trg_GITAcquire = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GITAcquire, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_GITAcquire, Condition(Trig_GITAcquire_Conditions))
    TriggerAddAction(gg_trg_GITAcquire, Trig_GITAcquire_Actions)
end)
if Debug then Debug.endFile() end
