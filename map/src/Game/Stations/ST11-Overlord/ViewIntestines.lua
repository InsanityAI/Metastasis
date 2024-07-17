if Debug then Debug.beginFile "Game/Stations/ST11/ViewIntestines" end
OnInit.trig("ViewIntestines", function(require)
    ---@return boolean
    function Trig_ViewIntestines_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A08M'))) then
            return false
        end
        return true
    end

    function Trig_ViewIntestines_Actions()
        udg_TempPoint = GetRectCenter(gg_rct_OverlordRect)
        PanCameraToTimedLocForPlayer(GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_ViewIntestines = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ViewIntestines, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_ViewIntestines, Condition(Trig_ViewIntestines_Conditions))
    TriggerAddAction(gg_trg_ViewIntestines, Trig_ViewIntestines_Actions)
end)
if Debug then Debug.endFile() end
