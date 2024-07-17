if Debug then Debug.beginFile "Game/Abilities/Mutant/TaintedVendorBuy" end
OnInit.map("TaintedVendorBuy", function(require)
    ---@return boolean
    function Trig_TaintedVendorBuy_Conditions()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A01U'), GetTriggerUnit()) ~= 0)) then
            return false
        end
        if (not (udg_Mutant ~= GetOwningPlayer(GetBuyingUnit()))) then
            return false
        end
        if (not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetBuyingUnit()))] == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TaintedVendorBuy_Func005C()
        if (not (GetItemTypeId(GetSoldItem()) == FourCC('I004'))) then
            return false
        end
        return true
    end

    function Trig_TaintedVendorBuy_Actions()
        if (Trig_TaintedVendorBuy_Func005C()) then
            RemoveItem(GetSoldItem())
        else
        end
        udg_TempPoint = GetUnitLoc(GetBuyingUnit())
        CreateNUnitsAtLoc(1, FourCC('e000'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
        RemoveLocation(udg_TempPoint)
        IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", GetBuyingUnit())
    end

    --===========================================================================
    gg_trg_TaintedVendorBuy = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_TaintedVendorBuy, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddCondition(gg_trg_TaintedVendorBuy, Condition(Trig_TaintedVendorBuy_Conditions))
    TriggerAddAction(gg_trg_TaintedVendorBuy, Trig_TaintedVendorBuy_Actions)
end)
if Debug then Debug.endFile() end
