if Debug then Debug.beginFile "Game/PlayerRolePicking/RepickMutantChoice" end
OnInit.trig("RepickMutantChoice", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_RepickMutantChoice_Conditions()
        if (not (GetClickedButtonBJ() == udg_RepickMutantDialogButton[1])) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RepickMutantChoice_Func008C()
        if (not (GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == FourCC('h00H'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RepickMutantChoice_Func009C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A05M'), udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) == 1)) then
            return false
        end
        return true
    end

    function Trig_RepickMutantChoice_Actions()
        -- Make the new mutant
        -- Pick a player who is human ((does this include android?!))
        StateTable.SetPlayerRole(udg_Mutant, Role.Human)
        udg_TempPlayer = NoninfectedForcePickOne()
        udg_Mutant = udg_TempPlayer
        StateTable.SetPlayerRole(udg_Mutant, Role.Mutant)
        CreateNUnitsAtLoc(1, FourCC('e031'), udg_Mutant, udg_HoldZone, bj_UNIT_FACING)
        if (Trig_RepickMutantChoice_Func008C()) then
            UnitAddAbilityBJ(FourCC('A05M'), udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
        else
        end
        if (Trig_RepickMutantChoice_Func009C()) then
            UnitRemoveAbilityBJ(FourCC('A05M'), udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
        else
        end
        DisplayTextToPlayer(udg_Mutant, 0, 0, "|cffFF0000You are now the Mutant. Seek out all enemies and destroy them.")
        ConditionalTriggerExecute(gg_trg_RepickMutant)
    end

    --===========================================================================
    gg_trg_RepickMutantChoice = CreateTrigger()
    TriggerRegisterDialogEventBJ(gg_trg_RepickMutantChoice, udg_RepickMutantDialog)
    TriggerAddCondition(gg_trg_RepickMutantChoice, Condition(Trig_RepickMutantChoice_Conditions))
    TriggerAddAction(gg_trg_RepickMutantChoice, Trig_RepickMutantChoice_Actions)
end)
if Debug then Debug.endFile() end
