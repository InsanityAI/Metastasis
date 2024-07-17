if Debug then Debug.beginFile "Game/PlayerRolePicking/RepickAlien" end
OnInit.trig("RepickAlien", function(require)
    ---@return boolean
    function Trig_RepickAlien_Conditions()
        if (not (udg_TESTING == false)) then
            return false
        end
        return true
    end

    function Trig_RepickAlien_Actions()
        DialogClearBJ(udg_RepickAlienDialog)
        DialogSetMessageBJ(udg_RepickAlienDialog, "TRIGSTR_5314")
        DialogAddButtonBJ(udg_RepickAlienDialog, "TRIGSTR_5312")
        udg_RepickAlienDialogButton[0] = GetLastCreatedButtonBJ()
        DialogAddButtonBJ(udg_RepickAlienDialog, "TRIGSTR_5315")
        udg_RepickAlienDialogButton[1] = GetLastCreatedButtonBJ()
        DialogDisplayBJ(true, udg_RepickAlienDialog, udg_Parasite)
    end

    --===========================================================================
    gg_trg_RepickAlien = CreateTrigger()
    TriggerAddCondition(gg_trg_RepickAlien, Condition(Trig_RepickAlien_Conditions))
    TriggerAddAction(gg_trg_RepickAlien, Trig_RepickAlien_Actions)
end)
if Debug then Debug.endFile() end
