if Debug then Debug.beginFile "Game/Misc/AllSectorsTargetCheck" end
OnInit.trig("AllSectorsTargetCheck", function(require)
    ---@return boolean
    function Trig_AllSectorsTargetCheck_Conditions()
        if (not (GetSpellAbilityId() ~= FourCC('A03I'))) then
            return false
        end
        if (not (GetSpellAbilityId() ~= FourCC('A082'))) then
            return false
        end
        if (not (GetSpellAbilityId() ~= FourCC('A087'))) then
            return false
        end
        if (not (GetSpellAbilityId() ~= FourCC('A08H'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AllSectorsTargetCheck_Func010C()
        if (not (GetSpellTargetUnit() ~= nil)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AllSectorsTargetCheck_Func011C()
        if (not (GetLocationX(udg_TempPoint) == 0.00)) then
            return false
        end
        if (not (GetLocationY(udg_TempPoint) == 0.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AllSectorsTargetCheck_Func014C()
        if (not (udg_TempBool == false)) then
            return false
        end
        return true
    end

    function Trig_AllSectorsTargetCheck_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempInt = GetSector(udg_TempPoint)
        RemoveLocation(udg_TempPoint)
        udg_TempPoint = GetSpellTargetLoc()
        if (Trig_AllSectorsTargetCheck_Func010C()) then
            RemoveLocation(udg_TempPoint)
            return
        else
        end
        if (Trig_AllSectorsTargetCheck_Func011C()) then
            RemoveLocation(udg_TempPoint)
            return
        else
        end
        udg_TempBool = LocInSector(udg_TempPoint, udg_TempInt)
        RemoveLocation(udg_TempPoint)
        if (Trig_AllSectorsTargetCheck_Func014C()) then
            IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
            PauseUnitForPeriod(GetSpellAbilityUnit(), 0.1)
        else
        end
    end

    --===========================================================================
    gg_trg_AllSectorsTargetCheck = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AllSectorsTargetCheck, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_AllSectorsTargetCheck, Condition(Trig_AllSectorsTargetCheck_Conditions))
    TriggerAddAction(gg_trg_AllSectorsTargetCheck, Trig_AllSectorsTargetCheck_Actions)
end)
if Debug then Debug.endFile() end
