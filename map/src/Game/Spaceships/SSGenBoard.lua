if Debug then Debug.beginFile "Game/Spaceships/SSGenBoard" end
OnInit.map("SSGenBoard", function(require)
    ---@return boolean
    function Trig_SSGenBoard_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02J'))) then
            return false
        end
        return true
    end

    function Trig_SSGenBoard_Actions()
        local a = GetSpellAbilityUnit() ---@type unit
        local b = GetSpellTargetUnit() ---@type unit
        local d ---@type lightning

        IssueImmediateOrder(a, "stop")

        if udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(b)])] then
            return
        end

        if IsUnitExplorer(b) then
            PauseUnitBJ(true, a)
            PauseUnitBJ(true, b)

            udg_SS_BoardingTarget[GetUnitUserData(udg_SS_Landed[GetUnitUserData(a)])] = udg_SS_Landed
                [GetUnitUserData(b)]
            udg_SS_BoardingTarget[GetUnitUserData(udg_SS_Landed[GetUnitUserData(b)])] = udg_SS_Landed
                [GetUnitUserData(a)]
            udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(a)])] = true
            udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(b)])] = true
            udg_TempPoint = GetUnitLoc(a)
            udg_TempPoint2 = GetUnitLoc(b)
            d = AddLightningEx("MFPB", true, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint), -156,
                GetLocationX(udg_TempPoint2), GetLocationY(udg_TempPoint2), -156)
            RemoveLocation(udg_TempPoint)
            RemoveLocation(udg_TempPoint2)
            udg_CountUpBarColor = "|cff00FFFF"
            CountUpBar(a, 20, 1.0, "DoNothing") --Includes a polled wait of 20 seconds here
            PauseUnitBJ(false, a)
            PauseUnitBJ(false, b)
            udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(a)])] = false
            udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(b)])] = false
            DestroyLightning(d)
        end
    end

    --===========================================================================
    gg_trg_SSGenBoard = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SSGenBoard, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SSGenBoard, Condition(Trig_SSGenBoard_Conditions))
    TriggerAddAction(gg_trg_SSGenBoard, Trig_SSGenBoard_Actions)
end)
if Debug then Debug.endFile() end
