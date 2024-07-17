if Debug then Debug.beginFile "Game/Abilities/Suits/MatterDrainingDevice" end
OnInit.trig("MatterDrainingDevice", function(require)
    ---@return boolean
    function Trig_MatterDrainingDevice_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02Q'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MatterDrainingDevice_Func004Func001C()
        if ((GetOwningPlayer(GetSpellTargetUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return true
        end
        if ((GetOwningPlayer(GetSpellTargetUnit()) == Player(PLAYER_NEUTRAL_PASSIVE))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_MatterDrainingDevice_Func004C()
        if (not Trig_MatterDrainingDevice_Func004Func001C()) then
            return false
        end
        return true
    end

    function Trig_MatterDrainingDevice_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        if (Trig_MatterDrainingDevice_Func004C()) then
            CreateNUnitsAtLoc(1, FourCC('e00I'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        else
            CreateNUnitsAtLoc(1, FourCC('e00I'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        end
        IssueTargetOrderBJ(GetLastCreatedUnit(), "drain", GetSpellTargetUnit())
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_MatterDrainingDevice = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MatterDrainingDevice, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_MatterDrainingDevice, Condition(Trig_MatterDrainingDevice_Conditions))
    TriggerAddAction(gg_trg_MatterDrainingDevice, Trig_MatterDrainingDevice_Actions)
end)
if Debug then Debug.endFile() end
