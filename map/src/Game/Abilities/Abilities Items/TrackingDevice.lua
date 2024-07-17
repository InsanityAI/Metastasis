if Debug then Debug.beginFile "Game/Abilities/Items/TrackingDevice" end
OnInit.trig("TrackingDevice", function(require)
    ---@return boolean
    function Trig_TrackingDevice_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A01G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func002Func002Func001Func001001001()
        return (udg_Parasite == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func002Func002Func001Func002001001()
        return (GetOwningPlayer(GetSpellAbilityUnit()) == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func002Func002Func001C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func002Func002C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func002C()
        if (not (GetEnumUnit() ~= GetManipulatingUnit())) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) then
            return false
        end
        if (not (udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func003Func002Func001Func001001001()
        return (udg_Parasite == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func003Func002Func001Func002001001()
        return (GetOwningPlayer(GetSpellAbilityUnit()) == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func003Func002Func001C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func003Func002C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TrackingDevice_Func006Func003C()
        if not (IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then
            return false
        end
        return true
    end

    function Trig_TrackingDevice_Func006A()
        udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
        if (Trig_TrackingDevice_Func006Func002C()) then
            udg_TempBool = UnitInSectorLax(GetEnumUnit(), udg_TempInt)
            if (Trig_TrackingDevice_Func006Func002Func002C()) then
                if (Trig_TrackingDevice_Func006Func002Func002Func001C()) then
                    PingMinimapLocForForceEx(
                        GetPlayersMatching(Condition(Trig_TrackingDevice_Func006Func002Func002Func001Func002001001)),
                        udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 50.00, 100, 50.00)
                else
                    PingMinimapLocForForceEx(
                        GetPlayersMatching(Condition(Trig_TrackingDevice_Func006Func002Func002Func001Func001001001)),
                        udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 50.00, 100, 50.00)
                end
            else
            end
        else
        end
        if (Trig_TrackingDevice_Func006Func003C()) then
            udg_TempBool = UnitInSector(GetEnumUnit(), udg_TempInt)
            if (Trig_TrackingDevice_Func006Func003Func002C()) then
                if (Trig_TrackingDevice_Func006Func003Func002Func001C()) then
                    PingMinimapLocForForceEx(
                        GetPlayersMatching(Condition(Trig_TrackingDevice_Func006Func003Func002Func001Func002001001)),
                        udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
                else
                    PingMinimapLocForForceEx(
                        GetPlayersMatching(Condition(Trig_TrackingDevice_Func006Func003Func002Func001Func001001001)),
                        udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
                end
            else
            end
        else
        end
        RemoveLocation(udg_TempPoint2)
    end

    ---@return boolean
    function Trig_TrackingDevice_Func009Func001C()
        if (not (GetOwningPlayer(GetEnumUnit()) ~= GetOwningPlayer(GetSpellAbilityUnit()))) then
            return false
        end
        return true
    end

    function Trig_TrackingDevice_Func009A()
        if (Trig_TrackingDevice_Func009Func001C()) then
            UnitRemoveAbilityBJ(FourCC('A08D'), GetEnumUnit())
        else
        end
    end

    function Trig_TrackingDevice_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempUnitGroup = GetUnitsInRangeAndShips(udg_TempPoint, 8000.0)
        udg_TempInt = GetSector(udg_TempPoint)
        ForGroupBJ(udg_TempUnitGroup, Trig_TrackingDevice_Func006A)
        DestroyGroup(udg_TempUnitGroup)
        udg_TempUnitGroup = GetUnitsInRangeAndShips(udg_TempPoint, 900.0)
        ForGroupBJ(udg_TempUnitGroup, Trig_TrackingDevice_Func009A)
        DestroyGroup(udg_TempUnitGroup)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_TrackingDevice = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_TrackingDevice, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_TrackingDevice, Condition(Trig_TrackingDevice_Conditions))
    TriggerAddAction(gg_trg_TrackingDevice, Trig_TrackingDevice_Actions)
end)
if Debug then Debug.endFile() end
