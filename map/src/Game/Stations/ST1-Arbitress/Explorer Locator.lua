if Debug then Debug.beginFile "Game/Stations/ST1/ExplorerLocator" end
OnInit.map("ExplorerLocator", function(require)
    ---@return boolean
    function Trig_Explorer_Locator_Conditions()
        if (not (GetItemTypeId(GetSoldItem()) == FourCC('I02B'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Explorer_Locator_Func004Func001Func002Func001001001()
        return (GetFilterPlayer() == udg_Parasite)
    end

    ---@return boolean
    function Trig_Explorer_Locator_Func004Func001Func002Func002001001()
        return (GetFilterPlayer() == GetOwningPlayer(GetBuyingUnit()))
    end

    ---@return boolean
    function Trig_Explorer_Locator_Func004Func001Func002C()
        if (not (GetOwningPlayer(GetBuyingUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Explorer_Locator_Func004Func001Func005C()
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02Q'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02H'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02L'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h002'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h03J'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02S'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02I'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02K'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h001'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h03K'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Explorer_Locator_Func004Func001C()
        if (not (RectContainsUnit(gg_rct_Timeout, GetEnumUnit()) == false)) then
            return false
        end
        if (not Trig_Explorer_Locator_Func004Func001Func005C()) then
            return false
        end
        return true
    end

    function Trig_Explorer_Locator_Func004A()
        if (Trig_Explorer_Locator_Func004Func001C()) then
            udg_TempPoint = GetUnitLoc(GetEnumUnit())
            if (Trig_Explorer_Locator_Func004Func001Func002C()) then
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_Explorer_Locator_Func004Func001Func002Func002001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 50.00, 50.00, 100)
            else
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_Explorer_Locator_Func004Func001Func002Func001001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 50.00, 50.00, 100)
            end
            RemoveLocation(udg_TempPoint)
        else
        end
    end

    function Trig_Explorer_Locator_Actions()
        RemoveItem(GetSoldItem())
        ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_Explorer_Locator_Func004A)
    end

    --===========================================================================
    gg_trg_Explorer_Locator = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Explorer_Locator, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddCondition(gg_trg_Explorer_Locator, Condition(Trig_Explorer_Locator_Conditions))
    TriggerAddAction(gg_trg_Explorer_Locator, Trig_Explorer_Locator_Actions)
end)
if Debug then Debug.endFile() end
