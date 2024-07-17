if Debug then Debug.beginFile "Game/Stations/Planet/RadarSweepPlanet" end
OnInit.trig("RadarSweepPlanet", function(require)
    ---@return boolean
    function Trig_RadarSweepPlanet_Func004Func001Func002Func001001001()
        return (GetFilterPlayer() == udg_Parasite)
    end

    ---@return boolean
    function Trig_RadarSweepPlanet_Func004Func001Func002Func002001001()
        return (GetFilterPlayer() == GetOwningPlayer(GetBuyingUnit()))
    end

    ---@return boolean
    function Trig_RadarSweepPlanet_Func004Func001Func002C()
        if (not (GetOwningPlayer(GetBuyingUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RadarSweepPlanet_Func004Func001C()
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) then
            return false
        end
        if (not (GetUnitPointValue(GetEnumUnit()) ~= 37)) then
            return false
        end
        if (not (GetUnitAbilityLevelSwapped(FourCC('Aloc'), GetEnumUnit()) == 0)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RadarSweepPlanet_Func004Func002Func002Func001001001()
        return (udg_Parasite == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_RadarSweepPlanet_Func004Func002Func002Func002001001()
        return (GetOwningPlayer(GetBuyingUnit()) == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_RadarSweepPlanet_Func004Func002Func002C()
        if (not (GetOwningPlayer(GetBuyingUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RadarSweepPlanet_Func004Func002C()
        if not (IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then
            return false
        end
        return true
    end

    function Trig_RadarSweepPlanet_Func004A()
        if (Trig_RadarSweepPlanet_Func004Func001C()) then
            udg_TempPoint = GetUnitLoc(GetEnumUnit())
            if (Trig_RadarSweepPlanet_Func004Func001Func002C()) then
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_RadarSweepPlanet_Func004Func001Func002Func002001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            else
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_RadarSweepPlanet_Func004Func001Func002Func001001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            end
            RemoveLocation(udg_TempPoint)
        else
        end
        if (Trig_RadarSweepPlanet_Func004Func002C()) then
            udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
            if (Trig_RadarSweepPlanet_Func004Func002Func002C()) then
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_RadarSweepPlanet_Func004Func002Func002Func002001001)),
                    udg_TempPoint2,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
            else
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_RadarSweepPlanet_Func004Func002Func002Func001001001)),
                    udg_TempPoint2,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
            end
            RemoveLocation(udg_TempPoint2)
        else
        end
    end

    function Trig_RadarSweepPlanet_Actions()
        RemoveItem(GetSoldItem())
        DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "|cffffcc00Planetary sweep complete.|r")
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Planet), Trig_RadarSweepPlanet_Func004A)
    end

    --===========================================================================
    gg_trg_RadarSweepPlanet = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_RadarSweepPlanet, gg_unit_h019_0154, EVENT_UNIT_SELL_ITEM)
    TriggerAddAction(gg_trg_RadarSweepPlanet, Trig_RadarSweepPlanet_Actions)
end)
if Debug then Debug.endFile() end
