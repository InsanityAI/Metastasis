if Debug then Debug.beginFile "Game/Stations/ST7/ST7Control" end
OnInit.map("ST7Control", function(require)
    ---@return boolean
    function Trig_ST7Control_Conditions()
        if (not (GetOwningPlayer(GetTriggerUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) then
            return false
        end
        if (not (GetOwningPlayer(GetTriggerUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (IsUnitIllusionBJ(GetTriggerUnit()) == false)) then
            return false
        end
        if (not (GetItemTypeId(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC('I012'))) == FourCC('I012'))) then
            return false
        end
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        return true
    end

    function Trig_ST7Control_Actions()
        SetUnitOwner(gg_unit_h02B_0116, GetOwningPlayer(GetTriggerUnit()), false)
        SelectUnitForPlayerSingle(gg_unit_h02B_0116, GetOwningPlayer(GetTriggerUnit()))
        udg_TempPoint = GetUnitLoc(gg_unit_h02B_0116)
        PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), udg_TempPoint, 0)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_ST7Control = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_ST7Control, gg_rct_PirateShipControl)
    TriggerAddCondition(gg_trg_ST7Control, Condition(Trig_ST7Control_Conditions))
    TriggerAddAction(gg_trg_ST7Control, Trig_ST7Control_Actions)
end)
if Debug then Debug.endFile() end
