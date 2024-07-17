if Debug then Debug.beginFile "Game/Stations/ST5/Autopilot" end
OnInit.map("Autopilot", function(require)
    ---@return boolean
    function Trig_Autopilot_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02P'))) then
            return false
        end
        return true
    end

    function Trig_Autopilot_Actions()
        DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 30, "|cff00FF00Autopilot engaged.|r")
        udg_TempPoint = GetRectCenter(gg_rct_ST5Control)
        PanCameraToTimedLocForPlayer(GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0)
        RemoveLocation(udg_TempPoint)
        SetUnitOwner(gg_unit_h00Y_0050, Player(PLAYER_NEUTRAL_PASSIVE), true)
        SetUnitOwner(gg_unit_h00X_0049, Player(PLAYER_NEUTRAL_PASSIVE), true)
        udg_TempPoint2 = GetUnitLoc(gg_unit_h00X_0049)
        udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 5000.00, GetUnitFacing(gg_unit_h00X_0049))
        IssuePointOrderLocBJ(gg_unit_h00X_0049, "move", udg_TempPoint)
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_Autopilot = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_Autopilot, gg_unit_h00X_0049, EVENT_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Autopilot, Condition(Trig_Autopilot_Conditions))
    TriggerAddAction(gg_trg_Autopilot, Trig_Autopilot_Actions)
end)
if Debug then Debug.endFile() end
