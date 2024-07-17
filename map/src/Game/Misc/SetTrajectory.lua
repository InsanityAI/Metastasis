if Debug then Debug.beginFile "Game/Misc/SetTrajectory" end
OnInit.trig("SetTrajectory", function(require)
    ---@return boolean
    function Trig_SetTrajectory_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A004'))) then
            return false
        end
        return true
    end

    --IsUnitAliveBJ(GetSpellTargetUnit()) == true

    ---@return boolean
    function Trig_SetTrajectory_Func001C()
        if (not (RectContainsUnit(gg_rct_Space, GetSpellTargetUnit()) == true)) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) ~= FourCC('h02P'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) ~= FourCC('h02H'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) ~= FourCC('h02L'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) ~= FourCC('h002'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) ~= FourCC('h02B'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) ~= FourCC('h029'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) ~= FourCC('h005'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) ~= FourCC('h02Q'))) then
            return false
        end
        if (not (IsUnitStation(GetSpellTargetUnit()) or IsUnitExplorer(GetSpellTargetUnit()))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) ~= FourCC('h03J'))) then
            return false
        end

        return true
    end

    function Trig_SetTrajectory_Actions()
        local a     = GetSpellAbilityUnit() ---@type unit
        local b     = GetSpellTargetUnit() ---@type unit
        local p     = GetOwningPlayer(a) ---@type player
        local boolz = false ---@type boolean
        local k ---@type location
        local i ---@type location
        local q ---@type real
        local r ---@type player

        if (Trig_SetTrajectory_Func001C()) then
            q = udg_SpaceObject_CollideRadius[GetUnitAN(GetSpellTargetUnit())] * 1.2
            if q == 0 then
                q = 250.0
            end

            udg_TempPoint = GetUnitLoc(a)
            udg_TempPoint2 = GetUnitLoc(b)
            SetUnitOwner(a, Player(PLAYER_NEUTRAL_PASSIVE), true)
            IssuePointOrderLocBJ(a, "move", udg_TempPoint2)
            SetUnitMoveSpeed(a, 180.00)
            while boolz ~= true do
                k = GetUnitLoc(a)
                i = GetUnitLoc(b)
                if DistanceBetweenPoints(k, i) <= q or GetUnitLifePercent(a) == 0.0 or GetUnitLifePercent(b) == 0.0 then
                    boolz = true
                else
                    IssuePointOrderLocBJ(a, "move", i)
                end
                RemoveLocation(k)
                k = nil
                RemoveLocation(i)
                i = nil
                PolledWait(0.2)
            end

            if IsUnitAliveBJ(b) == true and IsUnitAliveBJ(a) == true then
                r = udg_EscapePod_Owner[GetUnitAN(a)]
                RemoveUnit(a)
                udg_TempUnit = b
                if (udg_TempUnit == gg_unit_h009_0029) then
                    udg_TempRect = gg_rct_ST4EscapePod
                else
                    if (udg_TempUnit == gg_unit_h003_0018) then
                        udg_TempRect = gg_rct_ST1EscapePod
                    else
                        if (udg_TempUnit == gg_unit_h007_0027) then
                            udg_TempRect = gg_rct_ST3EscapePod
                        else
                            if (udg_TempUnit == gg_unit_h008_0196) then
                                udg_TempRect = gg_rct_PlanetEscapePod
                            else
                                if (udg_TempUnit == gg_unit_h00X_0049) then
                                    udg_TempRect = gg_rct_ST5EscapePod
                                else
                                    if udg_TempUnit == gg_unit_h03T_0209 then
                                        udg_TempRect = gg_rct_MoonEscapePod
                                    end
                                    if udg_TempUnit == gg_unit_h04E_0259 then
                                        udg_TempRect = gg_rct_ST8EscapePod
                                    end
                                    if udg_TempUnit == gg_unit_h04T_0265 then
                                        udg_TempRect = gg_rct_ST9EscapePod
                                    end
                                    if udg_TempUnit == gg_unit_h04V_0253 then
                                        udg_TempRect = gg_rct_ST10EscapePod
                                    end
                                    if GetUnitTypeId(udg_TempUnit) == FourCC('h04G') then
                                        udg_TempRect = gg_rct_OverlordPod
                                    end
                                end
                            end
                        end
                    end
                end
                udg_TempPoint = GetRectCenter(udg_TempRect)
                CreateNUnitsAtLoc(1, FourCC('e006'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
                SetUnitPositionLoc(udg_Playerhero[GetConvertedPlayerId(r)], udg_TempPoint)
                ShowUnitShow(udg_Playerhero[GetConvertedPlayerId(r)])
                PauseUnitBJ(false, udg_Playerhero[GetConvertedPlayerId(r)])
                UnitRemoveAbility(udg_Playerhero[GetConvertedPlayerId(r)], FourCC('A04V'))
                SetUnitLifePercentBJ(udg_Playerhero[GetConvertedPlayerId(r)], udg_EscapePod_LifeReset[GetUnitAN(a)])
                if r == Player(14) then
                    PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0)
                    SelectUnitForPlayerSingle(udg_Playerhero[GetConvertedPlayerId(r)], udg_Parasite)
                else
                    PanCameraToTimedLocForPlayer(r, udg_TempPoint, 0)
                    SelectUnitForPlayerSingle(udg_Playerhero[GetConvertedPlayerId(r)], r)
                end
                RemoveLocation(udg_TempPoint)
                if udg_Mutant == r then
                    EnableTrigger(gg_trg_MutantUpgrade)
                end
                a = udg_Playerhero[GetConvertedPlayerId(r)]
                if udg_Parasite == r or Player(bj_PLAYER_NEUTRAL_EXTRA) == r then
                    EnableTrigger(gg_trg_ParasiteUpgrade)
                end
                UnitAddAbilityForPeriod(a, FourCC('Avul'), 4.0)
            else
                SetUnitMoveSpeed(a, 1)
                SetUnitOwner(a, p, true)
                SelectUnitForPlayerSingle(a, p)
                PanCameraToForPlayer(p, GetUnitX(a), GetUnitY(a))
            end
        else
            DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "|cffFF0000INVALID TARGET|r")
        end
    end

    --===========================================================================
    gg_trg_SetTrajectory = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SetTrajectory, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SetTrajectory, Condition(Trig_SetTrajectory_Conditions))
    TriggerAddAction(gg_trg_SetTrajectory, Trig_SetTrajectory_Actions)
end)
if Debug then Debug.endFile() end
