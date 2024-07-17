if Debug then Debug.beginFile "Game/Stations/ST1/ScanAcquireASAD" end
OnInit.map("ScanAcquireASAD", function(require)
    ---@return boolean
    function USAD_AbilCode()
        if (not (GetSpellAbilityId() == FourCC('A06S'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ScanAcquireASAD_Func001Func003Func001Func001Func002Func001001001()
        return (GetFilterPlayer() == udg_Parasite)
    end

    ---@return boolean
    function Trig_ScanAcquireASAD_Func001Func003Func001Func001Func002Func002001001()
        return (GetFilterPlayer() == GetOwningPlayer(GetSpellAbilityUnit()))
    end

    ---@return boolean
    function Trig_ScanAcquireASAD_Func001Func003Func001Func001Func002C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ScanAcquireASAD_Func001Func003Func001Func001C()
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
    function Trig_ScanAcquireASAD_Func001Func003Func001Func002Func002Func001001001()
        return (udg_Parasite == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_ScanAcquireASAD_Func001Func003Func001Func002Func002Func002001001()
        return (GetOwningPlayer(GetSpellAbilityUnit()) == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_ScanAcquireASAD_Func001Func003Func001Func002Func002C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ScanAcquireASAD_Func001Func003Func001Func002C()
        if (not (IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit()))) then
            return false
        end
        if (not (RectContainsUnit(gg_rct_Timeout, GetEnumUnit()) == false)) then
            return false
        end
        return true
    end

    function Trig_ScanAcquireASAD_Func001Func003Func001A()
        if (Trig_ScanAcquireASAD_Func001Func003Func001Func001C()) then
            udg_TempPoint = GetUnitLoc(GetEnumUnit())
            if (Trig_ScanAcquireASAD_Func001Func003Func001Func001Func002C()) then
                PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            else
                PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            end
            RemoveLocation(udg_TempPoint)
        else
        end
        if (Trig_ScanAcquireASAD_Func001Func003Func001Func002C()) then
            udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
            if (Trig_ScanAcquireASAD_Func001Func003Func001Func002Func002C()) then
                PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00,
                    50.00)
            else
                PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00,
                    50.00)
            end
            RemoveLocation(udg_TempPoint2)
        else
        end
    end

    function Trig_ScanAcquireASAD_Actions()
        local q ---@type unit
        local g ---@type group
        if GetSpellTargetUnit() == gg_unit_h019_0155 then
            CreateNUnitsAtLoc(1, FourCC('h04C'), Player(PLAYER_NEUTRAL_PASSIVE), Location(-11410.00, 15466.00),
                GetRandomDirectionDeg())
            q = bj_lastCreatedUnit
            RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), FourCC('I01S')))
            while not (IsUnitAliveBJ(q) ~= true) do
                DisplayTextToForce(GetPlayersAll(), "|cff00FFFFU.S.I. Arbitress Scanning...")
                g = GetUnitsInRectAll(GetPlayableMapRect())
                ForGroupBJ(g, Trig_ScanAcquireASAD_Func001Func003Func001A)
                DestroyGroup(g)
                PolledWait(45.00)
            end
        else
            UnitRemoveItemSwapped(GetManipulatedItem(), gg_unit_h019_0155)
        end
    end

    --===========================================================================
    gg_trg_ScanAcquireASAD = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ScanAcquireASAD, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ScanAcquireASAD, Condition(USAD_AbilCode))
    TriggerAddAction(gg_trg_ScanAcquireASAD, Trig_ScanAcquireASAD_Actions)
end)
if Debug then Debug.endFile() end
