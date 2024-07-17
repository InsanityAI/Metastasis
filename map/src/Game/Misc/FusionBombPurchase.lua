if Debug then Debug.beginFile "Game/Misc/FusionBombPurchase" end
OnInit.map("FusionBombPurchase", function(require)
    ---@return boolean
    function Trig_FusionBombPurchase_Conditions()
        if (not (GetItemTypeId(GetSoldItem()) == FourCC('I00N'))) then
            return false
        end
        return true
    end

    function Trig_FusionBombPurchase_Actions()
        local a = GetSellingUnit() ---@type unit
        SetUnitAnimation(a, "stand work")
        PolledWait(58.00)
        if IsUnitAliveBJ(a) then
            SetUnitAnimation(a, "stand")
        end
    end

    --===========================================================================
    gg_trg_FusionBombPurchase = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_FusionBombPurchase, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddCondition(gg_trg_FusionBombPurchase, Condition(Trig_FusionBombPurchase_Conditions))
    TriggerAddAction(gg_trg_FusionBombPurchase, Trig_FusionBombPurchase_Actions)
end)
if Debug then Debug.endFile() end
