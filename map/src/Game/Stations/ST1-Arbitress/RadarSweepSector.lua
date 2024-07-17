if Debug then Debug.beginFile "Game/Stations/ST1/RadarSweepSector" end
OnInit.map("RadarSweepSector", function(require)
    ---@return boolean
    function Trig_RadarSweepSector_Conditions()
        if (not (GetItemTypeId(GetSoldItem()) == FourCC('I00T'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RadarSweepSector_Func005Func001Func002Func001001001()
        return (GetFilterPlayer() == udg_Parasite)
    end

    ---@return boolean
    function Trig_RadarSweepSector_Func005Func001Func002Func002001001()
        return (GetFilterPlayer() == GetOwningPlayer(GetBuyingUnit()))
    end

    ---@return boolean
    function Trig_RadarSweepSector_Func005Func001Func002C()
        if (not (GetOwningPlayer(GetBuyingUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RadarSweepSector_Func005Func001C()
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) then
            return false
        end
        if (not (RectContainsUnit(gg_rct_Space, GetEnumUnit()) == false)) then
            return false
        end
        if (not (udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RadarSweepSector_Func005Func002Func002Func001001001()
        return (udg_Parasite == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_RadarSweepSector_Func005Func002Func002Func002001001()
        return (GetOwningPlayer(GetBuyingUnit()) == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_RadarSweepSector_Func005Func002Func002C()
        if (not (GetOwningPlayer(GetBuyingUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RadarSweepSector_Func005Func002C()
        if not (IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then
            return false
        end
        if (not (RectContainsUnit(gg_rct_Timeout, GetEnumUnit()) == false)) then
            return false
        end
        return true
    end

    function Trig_RadarSweepSector_Func005A()
        if (Trig_RadarSweepSector_Func005Func001C()) then
            udg_TempPoint = GetUnitLoc(GetEnumUnit())
            if (Trig_RadarSweepSector_Func005Func001Func002C()) then
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_RadarSweepSector_Func005Func001Func002Func002001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            else
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_RadarSweepSector_Func005Func001Func002Func001001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            end
            RemoveLocation(udg_TempPoint)
        else
        end
        if (Trig_RadarSweepSector_Func005Func002C()) then
            udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
            if (Trig_RadarSweepSector_Func005Func002Func002C()) then
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_RadarSweepSector_Func005Func002Func002Func002001001)),
                    udg_TempPoint2,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
            else
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_RadarSweepSector_Func005Func002Func002Func001001001)),
                    udg_TempPoint2,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
            end
            RemoveLocation(udg_TempPoint2)
        else
        end
    end

    function Trig_RadarSweepSector_Actions()
        RemoveItem(GetSoldItem())
        DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_5331")
        ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_RadarSweepSector_Func005A)
    end

    --===========================================================================
    gg_trg_RadarSweepSector = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_RadarSweepSector, gg_unit_h019_0155, EVENT_UNIT_SELL_ITEM)
    TriggerAddCondition(gg_trg_RadarSweepSector, Condition(Trig_RadarSweepSector_Conditions))
    TriggerAddAction(gg_trg_RadarSweepSector, Trig_RadarSweepSector_Actions)
end)
if Debug then Debug.endFile() end
