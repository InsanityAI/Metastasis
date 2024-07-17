if Debug then Debug.beginFile "Game/Abilities/Items/InventoryScanner" end
OnInit.map("InventoryScanner", function(require)
    ---@return boolean
    function Trig_InventoryScanner_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A08Y'))) then
            return false
        end
        return true
    end

    function Trig_InventoryScanner_Actions()
        DisplayTextToPlayer(GetOwningPlayer(GetSpellTargetUnit()), 0, 0, "|cFFFF0000Your inventory has been scanned.|r")
        DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "|cFFFF0000The target's inventory contains:|r")
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0,
                GetItemName(UnitItemInSlotBJ(GetSpellTargetUnit(), GetForLoopIndexA())))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    --===========================================================================
    gg_trg_InventoryScanner = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_InventoryScanner, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_InventoryScanner, Condition(Trig_InventoryScanner_Conditions))
    TriggerAddAction(gg_trg_InventoryScanner, Trig_InventoryScanner_Actions)
end)
if Debug then Debug.endFile() end
