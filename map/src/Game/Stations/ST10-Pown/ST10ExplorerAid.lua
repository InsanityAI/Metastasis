if Debug then Debug.beginFile "Game/Stations/ST10/ST10ExplorerAid" end
OnInit.trig("ST10ExplorerAid", function(require)
    ---@return boolean
    function Trig_ST10ExplorerAid_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A083'))) then
            return false
        end
        return true
    end

    function Trig_ST10ExplorerAid_Actions()
        udg_TempPoint = GetRectCenter(udg_SpaceObject_Rect[GetUnitUserData(GetSpellTargetUnit())])
        PanCameraToTimedLocForPlayer(GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0.25)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_ST10ExplorerAid = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ST10ExplorerAid, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ST10ExplorerAid, Condition(Trig_ST10ExplorerAid_Conditions))
    TriggerAddAction(gg_trg_ST10ExplorerAid, Trig_ST10ExplorerAid_Actions)
end)
if Debug then Debug.endFile() end
