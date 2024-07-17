if Debug then Debug.beginFile "Game/PureBugfixes/MutalienBugfixCopy" end
OnInit.map("MutalienBugfixCopy", function(require)
    ---@return boolean
    function Trig_Mutalien_bugfix_Copy_Func002C()
        if ((GetOwningPlayer(GetTriggerUnit()) == udg_Mutant)) then
            return true
        end
        if ((GetOwningPlayer(GetTriggerUnit()) == udg_Parasite)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Mutalien_bugfix_Copy_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('h02P'))) then
            return false
        end
        if (not Trig_Mutalien_bugfix_Copy_Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mutalien_bugfix_Copy_Func004C()
        if (not (GetOwningPlayer(GetTriggerUnit()) == udg_Mutant)) then
            return false
        end
        return true
    end

    function Trig_Mutalien_bugfix_Copy_Actions()
        if (Trig_Mutalien_bugfix_Copy_Func004C()) then
            RemoveUnit(udg_Mutant_EvoSelector)
        else
            RemoveUnit(udg_Parasite_EvoSelector)
        end
    end

    --===========================================================================
    gg_trg_Mutalien_bugfix_Copy = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Mutalien_bugfix_Copy, gg_rct_SpaceSound)
    TriggerAddCondition(gg_trg_Mutalien_bugfix_Copy, Condition(Trig_Mutalien_bugfix_Copy_Conditions))
    TriggerAddAction(gg_trg_Mutalien_bugfix_Copy, Trig_Mutalien_bugfix_Copy_Actions)
end)
if Debug then Debug.endFile() end
