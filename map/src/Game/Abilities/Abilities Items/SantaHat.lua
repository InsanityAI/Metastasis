if Debug then Debug.beginFile "Game/Abilities/Items/SantaHat" end
OnInit.trigg("SantaHat", function(require)
    ---@return boolean
    function Trig_SantaHat_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I01J'))) then
            return false
        end
        return true
    end

    function Trig_SantaHat_Actions()
        SetPlayerTechResearchedSwap(FourCC('R00B'), 1, GetOwningPlayer(GetManipulatingUnit()))
        SetItemDroppableBJ(GetManipulatedItem(), false)
    end

    --===========================================================================
    gg_trg_SantaHat = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SantaHat, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_SantaHat, Condition(Trig_SantaHat_Conditions))
    TriggerAddAction(gg_trg_SantaHat, Trig_SantaHat_Actions)
end)
if Debug then Debug.endFile() end
