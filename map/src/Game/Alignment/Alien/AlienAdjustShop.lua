if Debug then Debug.beginFile "Game/Allignment/Alien/AlienAdjustShop" end
OnInit.trig("AlienAdjustShop", function(require)
    ---@return boolean
    function Trig_AlienAdjustShop_Conditions()
        if (not (IsUnitAliveBJ(udg_AlienForm_Alien) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienAdjustShop_Func007Func001C()
        if (not (UnitItemInSlotBJ(udg_AlienForm_Alien, GetForLoopIndexA()) ~= nil)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienAdjustShop_Func008Func002C()
        if (not ((7 - udg_TempInt) == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienAdjustShop_Func008C()
        if (not ((7 - udg_TempInt) ~= GetUnitAbilityLevelSwapped(FourCC('A03E'), udg_Alien_ShopWorkaround))) then
            return false
        end
        return true
    end

    function Trig_AlienAdjustShop_Actions()
        udg_TempPoint = GetUnitLoc(udg_AlienForm_Alien)
        SetUnitPositionLoc(udg_Alien_ShopWorkaround, udg_TempPoint)
        RemoveLocation(udg_TempPoint)
        udg_TempInt = 0
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_AlienAdjustShop_Func007Func001C()) then
                udg_TempInt = (udg_TempInt + 1)
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        if (Trig_AlienAdjustShop_Func008C()) then
            SetUnitAbilityLevelSwapped(FourCC('A03E'), udg_Alien_ShopWorkaround, (7 - udg_TempInt))
            if (Trig_AlienAdjustShop_Func008Func002C()) then
                UnitAddItemByIdSwapped(FourCC('I01B'), udg_Alien_ShopWorkaround)
            else
                RemoveItem(GetItemOfTypeFromUnitBJ(udg_Alien_ShopWorkaround, FourCC('I01B')))
            end
        else
        end
    end

    --===========================================================================
    gg_trg_AlienAdjustShop = CreateTrigger()
    DisableTrigger(gg_trg_AlienAdjustShop)
    TriggerRegisterTimerEventPeriodic(gg_trg_AlienAdjustShop, 0.20)
    TriggerAddCondition(gg_trg_AlienAdjustShop, Condition(Trig_AlienAdjustShop_Conditions))
    TriggerAddAction(gg_trg_AlienAdjustShop, Trig_AlienAdjustShop_Actions)
end)
if Debug then Debug.endFile() end
