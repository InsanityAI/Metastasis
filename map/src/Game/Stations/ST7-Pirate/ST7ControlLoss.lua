if Debug then Debug.beginFile "Game/Stations/ST7/ST7ControlLoss" end
OnInit.trig("ST7ControlLoss", function(require)
    ---@return boolean
    function Trig_ST7ControlLoss_Conditions()
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

    function Trig_ST7ControlLoss_Actions()
        SetUnitOwner(gg_unit_h02B_0116, Player(PLAYER_NEUTRAL_AGGRESSIVE), false)
    end

    --===========================================================================
    gg_trg_ST7ControlLoss = CreateTrigger()
    TriggerRegisterLeaveRectSimple(gg_trg_ST7ControlLoss, gg_rct_PirateShipControl)
    TriggerAddCondition(gg_trg_ST7ControlLoss, Condition(Trig_ST7ControlLoss_Conditions))
    TriggerAddAction(gg_trg_ST7ControlLoss, Trig_ST7ControlLoss_Actions)
end)
if Debug then Debug.endFile() end
