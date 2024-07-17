if Debug then Debug.beginFile "Game/Allignment/Alien/AlienFormTransfer" end
OnInit.map("AlienFormTransfer", function(require)
    ---@return boolean
    function Trig_AlienFormTransfer_Conditions()
        if (not (udg_Alien_ShopWorkaround == GetBuyingUnit())) then
            return false
        end
        return true
    end

    function Trig_AlienFormTransfer_Actions()
        UnitAddItemByIdSwapped(GetItemTypeId(GetSoldItem()), udg_AlienForm_Alien)
        RemoveItem(GetSoldItem())
    end

    --===========================================================================
    gg_trg_AlienFormTransfer = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AlienFormTransfer, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddCondition(gg_trg_AlienFormTransfer, Condition(Trig_AlienFormTransfer_Conditions))
    TriggerAddAction(gg_trg_AlienFormTransfer, Trig_AlienFormTransfer_Actions)
end)
if Debug then Debug.endFile() end
