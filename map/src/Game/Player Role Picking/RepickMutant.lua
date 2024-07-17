if Debug then Debug.beginFile "Game/PlayerRolePicking/RepickMutant" end
OnInit.trig("RepickMutant", function(require)
    ---@return boolean
    function Trig_RepickMutant_Conditions()
        if (not (udg_TESTING == false)) then
            return false
        end
        return true
    end

    function Trig_RepickMutant_Actions()
        DialogClearBJ(udg_RepickMutantDialog)
        DialogSetMessageBJ(udg_RepickMutantDialog, "TRIGSTR_5319")
        DialogAddButtonBJ(udg_RepickMutantDialog, "TRIGSTR_5320")
        udg_RepickMutantDialogButton[0] = GetLastCreatedButtonBJ()
        DialogAddButtonBJ(udg_RepickMutantDialog, "TRIGSTR_5321")
        udg_RepickMutantDialogButton[1] = GetLastCreatedButtonBJ()
        DialogDisplayBJ(true, udg_RepickMutantDialog, udg_Mutant)
    end

    --===========================================================================
    gg_trg_RepickMutant = CreateTrigger()
    TriggerAddCondition(gg_trg_RepickMutant, Condition(Trig_RepickMutant_Conditions))
    TriggerAddAction(gg_trg_RepickMutant, Trig_RepickMutant_Actions)
end)
if Debug then Debug.endFile() end
