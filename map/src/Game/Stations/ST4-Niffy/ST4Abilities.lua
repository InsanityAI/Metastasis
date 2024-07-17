if Debug then Debug.beginFile "Game/Stations/ST4/ST4Abilities" end
OnInit.map("ST4Abilities", function(require)
    ---@return boolean
    function Trig_ST4Abilities_Func002Func004Func001Func002Func001001001()
        return (GetFilterPlayer() == udg_Parasite)
    end

    ---@return boolean
    function Trig_ST4Abilities_Func002Func004Func001Func002Func002001001()
        return (GetFilterPlayer() == GetOwningPlayer(GetTriggerUnit()))
    end

    ---@return boolean
    function Trig_ST4Abilities_Func002Func004Func001Func002C()
        if (not (GetOwningPlayer(GetTriggerUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST4Abilities_Func002Func004Func001C()
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
    function Trig_ST4Abilities_Func002Func004Func002Func002Func001001001()
        return (udg_Parasite == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_ST4Abilities_Func002Func004Func002Func002Func002001001()
        return (GetOwningPlayer(GetSpellAbilityUnit()) == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_ST4Abilities_Func002Func004Func002Func002C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST4Abilities_Func002Func004Func002C()
        if not (IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then
            return false
        end
        return true
    end

    function Trig_ST4Abilities_Func002Func004A()
        if (Trig_ST4Abilities_Func002Func004Func001C()) then
            udg_TempPoint = GetUnitLoc(GetEnumUnit())
            if (Trig_ST4Abilities_Func002Func004Func001Func002C()) then
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_ST4Abilities_Func002Func004Func001Func002Func002001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            else
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_ST4Abilities_Func002Func004Func001Func002Func001001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            end
            RemoveLocation(udg_TempPoint)
        else
        end
        if (Trig_ST4Abilities_Func002Func004Func002C()) then
            udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
            if (Trig_ST4Abilities_Func002Func004Func002Func002C()) then
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_ST4Abilities_Func002Func004Func002Func002Func002001001)),
                    udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
            else
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_ST4Abilities_Func002Func004Func002Func002Func001001001)),
                    udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
            end
            RemoveLocation(udg_TempPoint2)
        else
        end
    end

    ---@return boolean
    function Trig_ST4Abilities_Func002C()
        if (not (GetSpellAbilityId() == FourCC('A000'))) then
            return false
        end
        return true
    end

    function Trig_ST4Abilities_Actions()
        if (Trig_ST4Abilities_Func002C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_768")
            udg_TempRect = gg_rct_ST4S2
            udg_TempUnitGroup = GetUnitsInRectAll(udg_TempRect)
            ForGroupBJ(udg_TempUnitGroup, Trig_ST4Abilities_Func002Func004A)
            DestroyGroup(udg_TempUnitGroup)
        else
        end
    end

    --===========================================================================
    gg_trg_ST4Abilities = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST4Abilities, gg_unit_h00A_0030, EVENT_UNIT_SPELL_EFFECT)
    TriggerAddAction(gg_trg_ST4Abilities, Trig_ST4Abilities_Actions)
end)
if Debug then Debug.endFile() end
