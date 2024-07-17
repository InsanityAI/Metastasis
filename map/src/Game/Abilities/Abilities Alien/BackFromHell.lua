if Debug then Debug.beginFile "Game/Abilities/Alien/BackFromHell" end
OnInit.map("BackFromHell", function(require)
    ---@return boolean
    function Trig_BackFromHell_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A032'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_BackFromHell_Func007C()
        if (not (udg_EldritchBeastExists == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_BackFromHell_Func009Func001C()
        if (not (IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == true)) then
            return false
        end
        if (not (udg_Mutant ~= GetEnumPlayer())) then
            return false
        end
        if (not (udg_HiddenAndroid ~= GetEnumPlayer())) then
            return false
        end
        if (not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetEnumPlayer())] == false)) then
            return false
        end
        return true
    end

    function Trig_BackFromHell_Func009A()
        if (Trig_BackFromHell_Func009Func001C()) then
            udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetEnumPlayer())] = false
            DialogAddButtonBJ(udg_BackFromHellDialog, udg_Player_NameBeforeDead[GetConvertedPlayerId(GetEnumPlayer())])
            udg_BackFromHellDialogButtons[udg_TempInt] = GetLastCreatedButtonBJ()
            udg_BackFromHellDialog_Player[udg_TempInt] = GetEnumPlayer()
            udg_TempInt = (udg_TempInt + 1)
        else
        end
    end

    ---@return boolean
    function Trig_BackFromHell_Func010C()
        if (not (udg_TempInt == 1)) then
            return false
        end
        return true
    end

    function Trig_BackFromHell_Actions()
        DialogClearBJ(udg_BackFromHellDialog)
        DialogAddButtonBJ(udg_BackFromHellDialog, "TRIGSTR_1827")
        udg_BackFromHellDialogButtons[0] = GetLastCreatedButtonBJ()
        -- Start - If Eldritch Beast already exists -> Dont spawn the button
        if (Trig_BackFromHell_Func007C()) then
            -- Eldritch Beast Exists
            udg_TempInt = 1
        else
            -- Eldritch Beast Does NOT Exist
            udg_TempInt = 2
            DialogAddButtonBJ(udg_BackFromHellDialog, "TRIGSTR_1828")
            udg_BackFromHellDialogButtons[1] = GetLastCreatedButtonBJ()
        end
        -- End - If Eldritch Beast already exists -> Dont spawn the button
        ForForce(udg_DeadGroup, Trig_BackFromHell_Func009A)
        if (Trig_BackFromHell_Func010C()) then
            -- Cannot spawn eldritch or a player!
            IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
            SetUnitManaBJ(GetTriggerUnit(), 100.00)
        else
            DialogDisplayBJ(true, udg_BackFromHellDialog, udg_Parasite)
            udg_TempUnitType = FourCC('e00J')
            udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
            udg_TempReal = 120.00
            ExecuteFunc("AlienRequirementRemove")
            ExecuteFunc("AlienRequirementRestore")
        end
    end

    --===========================================================================
    gg_trg_BackFromHell = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_BackFromHell, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_BackFromHell, Condition(Trig_BackFromHell_Conditions))
    TriggerAddAction(gg_trg_BackFromHell, Trig_BackFromHell_Actions)
end)
if Debug then Debug.endFile() end
