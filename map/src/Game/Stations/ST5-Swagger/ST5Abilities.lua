if Debug then Debug.beginFile "Game/Stations/ST5/ST5Abilities" end
OnInit.map("ST5Abilities", function(require)
    ---@return boolean
    function Trig_ST5Abilities_Func003Func001Func001C()
        if (not (GetSpellAbilityId() == FourCC('A04Q'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST5Abilities_Func003Func001C()
        if (not (GetSpellAbilityId() == FourCC('A04O'))) then
            return false
        end
        if (not (GetSpellTargetUnit() == gg_unit_h008_0196)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST5Abilities_Func003Func005Func001Func002Func001001001()
        return (GetFilterPlayer() == udg_Parasite)
    end

    ---@return boolean
    function Trig_ST5Abilities_Func003Func005Func001Func002Func002001001()
        return (GetFilterPlayer() == GetOwningPlayer(GetTriggerUnit()))
    end

    ---@return boolean
    function Trig_ST5Abilities_Func003Func005Func001Func002C()
        if (not (GetOwningPlayer(GetTriggerUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST5Abilities_Func003Func005Func001C()
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
    function Trig_ST5Abilities_Func003Func005Func002Func002Func001001001()
        return (udg_Parasite == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_ST5Abilities_Func003Func005Func002Func002Func002001001()
        return (GetOwningPlayer(GetSpellAbilityUnit()) == GetFilterPlayer())
    end

    ---@return boolean
    function Trig_ST5Abilities_Func003Func005Func002Func002C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST5Abilities_Func003Func005Func002C()
        if not (IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then
            return false
        end
        return true
    end

    function Trig_ST5Abilities_Func003Func005A()
        if (Trig_ST5Abilities_Func003Func005Func001C()) then
            udg_TempPoint = GetUnitLoc(GetEnumUnit())
            if (Trig_ST5Abilities_Func003Func005Func001Func002C()) then
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_ST5Abilities_Func003Func005Func001Func002Func002001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            else
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_ST5Abilities_Func003Func005Func001Func002Func001001001)),
                    udg_TempPoint,
                    7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100)
            end
            RemoveLocation(udg_TempPoint)
        else
        end
        if (Trig_ST5Abilities_Func003Func005Func002C()) then
            udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
            if (Trig_ST5Abilities_Func003Func005Func002Func002C()) then
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_ST5Abilities_Func003Func005Func002Func002Func002001001)),
                    udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
            else
                PingMinimapLocForForceEx(
                    GetPlayersMatching(Condition(Trig_ST5Abilities_Func003Func005Func002Func002Func001001001)),
                    udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00)
            end
            RemoveLocation(udg_TempPoint2)
        else
        end
    end

    ---@return boolean
    function Trig_ST5Abilities_Func003C()
        if (not (GetSpellAbilityId() == FourCC('A000'))) then
            return false
        end
        return true
    end

    function Trig_ST5Abilities_Actions()
        if (Trig_ST5Abilities_Func003C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_727")
            udg_TempRect = gg_rct_ST5
            udg_TempUnitGroup = GetUnitsInRectAll(udg_TempRect)
            ForGroupBJ(udg_TempUnitGroup, Trig_ST5Abilities_Func003Func005A)
            DestroyGroup(udg_TempUnitGroup)
        else
            if (Trig_ST5Abilities_Func003Func001C()) then
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2475")
                ShowUnitHide(gg_unit_h00X_0049)
                PauseUnitBJ(true, gg_unit_h00X_0049)
                SetUnitVertexColorBJ(gg_unit_h03O_0208, 0.00, 0.00, 0.00, 25.00)
                SetUnitVertexColorBJ(gg_unit_e012_0074, 100.00, 100.00, 100.00, 0.00)
                SetUnitVertexColorBJ(gg_unit_e012_0092, 100.00, 100.00, 100.00, 0.00)
                UnitAddAbilityBJ(FourCC('A04Q'), gg_unit_h00Y_0050)
                udg_Swagger_Grounded = true
                EnableTrigger(gg_trg_SwaggerTeleportToPlanet)
                EnableTrigger(gg_trg_SwaggerTeleportToSwagger)
            else
                if (Trig_ST5Abilities_Func003Func001Func001C()) then
                    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2491")
                    UnitRemoveAbilityBJ(FourCC('A04Q'), GetSpellAbilityUnit())
                    StartTimerBJ(udg_SwaggerLaunchTimer, false, 45.00)
                    CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_2492")
                    udg_SwaggerLaunchTimerWindow = GetLastCreatedTimerDialogBJ()
                    PolledWait(45.00)
                    udg_Swagger_Grounded = false
                    DestroyTimerDialogBJ(udg_SwaggerLaunchTimerWindow)
                    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2494")
                    ShowUnitShow(gg_unit_h00X_0049)
                    PauseUnitBJ(false, gg_unit_h00X_0049)
                    udg_TempPoint = GetUnitLoc(gg_unit_h008_0196)
                    SetUnitPositionLoc(gg_unit_h00X_0049, udg_TempPoint)
                    RemoveLocation(udg_TempPoint)
                    SetUnitVertexColorBJ(gg_unit_h03O_0208, 100.00, 100.00, 100.00, 100.00)
                    SetUnitVertexColorBJ(gg_unit_e012_0074, 100.00, 100.00, 100.00, 100.00)
                    SetUnitVertexColorBJ(gg_unit_e012_0092, 100.00, 100.00, 100.00, 100.00)
                    DisableTrigger(gg_trg_SwaggerTeleportToPlanet)
                    DisableTrigger(gg_trg_SwaggerTeleportToSwagger)
                else
                end
            end
        end
    end

    --===========================================================================
    gg_trg_ST5Abilities = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST5Abilities, gg_unit_h00Y_0050, EVENT_UNIT_SPELL_EFFECT)
    TriggerRegisterUnitEvent(gg_trg_ST5Abilities, gg_unit_h00X_0049, EVENT_UNIT_SPELL_EFFECT)
    TriggerAddAction(gg_trg_ST5Abilities, Trig_ST5Abilities_Actions)
end)
if Debug then Debug.endFile() end
