if Debug then Debug.beginFile "Game/Stations/ST4/RepositioningDrive" end
OnInit.map("RepositioningDrive", function(require)
    ---@return boolean
    function Trig_RepositioningDrive_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A074'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RepositioningDrive_Func004C()
        if (not (RectContainsLoc(gg_rct_Space, udg_TempPoint) == false)) then
            return false
        end
        return true
    end

    function Trig_RepositioningDrive_Actions()
        udg_TempPoint = GetSpellTargetLoc()
        if (Trig_RepositioningDrive_Func004C()) then
            IssueImmediateOrderBJ(gg_unit_h009_0029, "stop")
        else
        end
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_RepositioningDrive = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_RepositioningDrive, gg_unit_h009_0029, EVENT_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_RepositioningDrive, Condition(Trig_RepositioningDrive_Conditions))
    TriggerAddAction(gg_trg_RepositioningDrive, Trig_RepositioningDrive_Actions)
end)
if Debug then Debug.endFile() end
