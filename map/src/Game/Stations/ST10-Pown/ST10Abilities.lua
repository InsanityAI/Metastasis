if Debug then Debug.beginFile "Game/Stations/ST10/ST10Abilities" end
OnInit.trig("ST10Abilities", function(require)
    require "IsTerrainWalkable"
    ---@return boolean
    function Trig_ST10Abilities_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('h04U'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST10Abilities_Func001Func001Func004C()
        if (not (GetSector(udg_TempPoint4) ~= 0)) then
            return false
        end
        if (not (IsUnitAliveBJ(udg_Sector_Space[GetSector(udg_TempPoint4)]))) then
            return false
        end
        if (not (GetTerrainType(GetLocationX(udg_TempPoint4), GetLocationY(udg_TempPoint4)) ~= FourCC('Vcbp'))) then
            return false
        end
        if (not (GetTerrainCliffLevelBJ(udg_TempPoint4) <= GetTerrainCliffLevelBJ(udg_TempPoint3))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST10Abilities_Func001Func001Func029Func003C()
        if (not (GetEnumUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])) then
            return false
        end
        return true
    end

    function Trig_ST10Abilities_Func001Func001Func029A()
        SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint4)
        UnitAddAbilityForPeriod(GetEnumUnit(), FourCC('Avul'), 1.7)
        if (Trig_ST10Abilities_Func001Func001Func029Func003C()) then
            PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()), udg_TempPoint4, 0)
        else
        end
    end

    ---@return boolean
    function Trig_ST10Abilities_Func001Func001C()
        if (not (GetSpellAbilityId() == FourCC('A081'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST10Abilities_Func001Func004C()
        local o = GetSector(udg_TempPoint4) ---@type integer
        local s = udg_Sector_Space[o] ---@type unit
        if (not (o ~= 0)) then
            return false
        end
        if not (IsUnitAliveBJ(s)) then
            return false
        end
        if IsUnitExplorer(s) then
            if not (RectContainsUnit(gg_rct_Space, s)) and GetUnitSector(udg_SS_Landed[GetUnitAN(s)]) <= 0 then
                return false
            end
        else
            if IsUnitHidden(s) or not (RectContainsUnit(gg_rct_Space, s)) then
                return false
            end
        end

        if (not (GetTerrainType(GetLocationX(udg_TempPoint4), GetLocationY(udg_TempPoint4)) ~= FourCC('Vcbp'))) then
            return false
        end
        if (not (GetTerrainCliffLevelBJ(udg_TempPoint4) <= GetTerrainCliffLevelBJ(udg_TempPoint3))) then
            return false
        end
        if (not (IsTerrainWalkable(GetLocationX(udg_TempPoint4), GetLocationY(udg_TempPoint4), CHECKER_UNIT_PEASANT))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST10Abilities_Func001C()
        if (not (GetSpellAbilityId() == FourCC('A082'))) then
            return false
        end
        return true
    end

    function Trig_ST10Abilities_Actions()
        local a4 ---@type location
        local a3 ---@type location
        local s = GetSpellAbilityUnit() ---@type unit
        local r ---@type sound
        local q ---@type sound
        local o = GetOwningPlayer(s) ---@type player
        if o == Player(14) then
            o = udg_Parasite
        end
        if (Trig_ST10Abilities_Func001C()) then
            a4 = GetSpellTargetLoc()
            a3 = GetRectCenter(gg_rct_TransportationPlatform)
            udg_TempPoint4 = a4
            udg_TempPoint3 = a3
            if (Trig_ST10Abilities_Func001Func004C()) then
                SaveLocationHandle(LS(), GetHandleId(s), StringHash("PortPlace"), a4)
                DisplayTimedTextToPlayer(o, 0, 0, 15.00, ("|cff00FFFF" .. "Teleportation location set."))
            else
                RemoveLocation(a3)
                DisplayTimedTextToPlayer(o, 0, 0, 15.00, "TRIGSTR_3872" .. " Or the target location may not be pathable.")
            end
            RemoveLocation(a3)
        else
            if (Trig_ST10Abilities_Func001Func001C()) then
                IssueImmediateOrderBJ(s, "stop")
                a4 = LoadLocationHandle(LS(), GetHandleId(s), StringHash("PortPlace"))
                a3 = GetRectCenter(gg_rct_TransportationPlatform)
                udg_TempPoint4 = a4
                udg_TempPoint3 = a3

                if (Trig_ST10Abilities_Func001Func001Func004C()) then
                else
                    RemoveLocation(udg_TempPoint3)
                    DisplayTimedTextToPlayer(o, 0, 0, 15.00, "TRIGSTR_3875")
                    return
                end
                r = CreateSound("Sound\\Ambient\\DoodadEffects\\StoneBridgeRise.wav", true, true, true, 126, 126, "")
                SetSoundPitch(r, 1.3)
                SetSoundPosition(r, GetLocationX(a4), GetLocationY(a4), 0.0)
                SoundVolumeOverPeriod(r, 40, 127, 19.0)
                PlaySoundBJ(r)
                q = CreateSound("Sound\\Ambient\\DoodadEffects\\StoneBridgeRise.wav", true, true, true, 126, 126, "")
                SetSoundPitch(q, 1.3)
                SetSoundPosition(q, GetLocationX(a3), GetLocationY(a3), 0.0)
                SoundVolumeOverPeriod(q, 40, 127, 19.0)
                PlaySoundBJ(q)
                CreateNUnitsAtLoc(1, FourCC('e01K'), Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING)
                SetUnitScalePercent(GetLastCreatedUnit(), 60.00, 60.00, 60.00)
                CreateNUnitsAtLoc(1, FourCC('e02Z'), Player(PLAYER_NEUTRAL_PASSIVE), a4, bj_UNIT_FACING)
                SizeUnitOverTime(GetLastCreatedUnit(), 20.1, 0.1, 8, true)
                CreateNUnitsAtLoc(1, FourCC('e02Z'), Player(PLAYER_NEUTRAL_PASSIVE), a4, bj_UNIT_FACING)
                SizeUnitOverTime(GetLastCreatedUnit(), 20.1, 0.1, 8, true)
                CreateNUnitsAtLoc(1, FourCC('e02Z'), Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING)
                SizeUnitOverTime(GetLastCreatedUnit(), 20.1, 0.1, 8, true)
                CreateNUnitsAtLoc(1, FourCC('e02Z'), Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING)
                SizeUnitOverTime(GetLastCreatedUnit(), 20.1, 0.1, 8, true)
                CreateNUnitsAtLoc(1, FourCC('e02Z'), Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING)
                SizeUnitOverTime(GetLastCreatedUnit(), 20.1, 0.1, 8, true)
                CreateNUnitsAtLoc(1, FourCC('e02Z'), Player(PLAYER_NEUTRAL_PASSIVE), a3, bj_UNIT_FACING)
                SizeUnitOverTime(GetLastCreatedUnit(), 20.1, 0.1, 8, true)
                udg_TempUnit = GetLastCreatedUnit()
                udg_CountUpBarColor = "|cffFF0080"
                PauseUnitBJ(true, s)
                CountUpBar(udg_TempUnit, 20, 0.975, "DoNothing")
                StopSound(r, true, true)
                StopSound(q, true, true)
                r = CreateSound("Sound\\Buildings\\Death\\NightElfBuildingDeathSmall1.wav", false, true, true, 126, 126,
                    "")
                SetSoundPosition(r, GetLocationX(a3), GetLocationY(a3), 0.0)
                PlaySoundBJ(r)
                r = CreateSound("Sound\\Buildings\\Death\\NightElfBuildingDeathSmall1.wav", false, true, true, 126, 126,
                    "")
                SetSoundPosition(r, GetLocationX(a4), GetLocationY(a4), 0.0)
                PlaySoundBJ(r)
                udg_TempPoint4 = a4
                ForGroupBJ(GetUnitsInRectAll(gg_rct_TransportationPlatform), Trig_ST10Abilities_Func001Func001Func029A)
                PauseUnitBJ(false, s)
                CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), a3, GetRandomDirectionDeg())
                CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), a3, GetRandomDirectionDeg())
                CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), a3, GetRandomDirectionDeg())
                CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), a4, GetRandomDirectionDeg())
                CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), a4, GetRandomDirectionDeg())
                CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), a4, GetRandomDirectionDeg())

                RemoveLocation(a3)
                --call RemoveLocation( a4 )
            else
            end
        end
    end

    --===========================================================================
    gg_trg_ST10Abilities = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ST10Abilities, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ST10Abilities, Condition(Trig_ST10Abilities_Conditions))
    TriggerAddAction(gg_trg_ST10Abilities, Trig_ST10Abilities_Actions)
end)
if Debug then Debug.endFile() end
