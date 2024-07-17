if Debug then Debug.beginFile "Game/PlayerRolePicking/RepickAlienChoice" end
OnInit.map("RepickAlienChoice", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_RepickAlienChoice_Conditions()
        if (not (GetClickedButtonBJ() == udg_RepickAlienDialogButton[1])) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RepickAlienChoice_Func008C()
        if (not (GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == FourCC('h00H'))) then
            return false
        end
        return true
    end

    function Trig_RepickAlienChoice_Actions()
        -- Make the new alien
        -- Pick a player who is human ((does this include android?!))
        StateTable.SetPlayerRole(udg_Parasite, Role.Human)
        udg_TempPlayer = NoninfectedForcePickOne()
        udg_Parasite = udg_TempPlayer
        StateTable.SetPlayerRole(udg_Parasite, Role.Alien)
        SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), udg_Parasite, bj_ALLIANCE_ALLIED_ADVUNITS)
        if (Trig_RepickAlienChoice_Func008C()) then
            UnitAddAbilityBJ(FourCC('A02O'), udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        else
        end
        DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffFF0000You are now the alien. Seek out all enemies and destroy them.")
        -- Remove the old alien's abilities etc etc
        SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), GetTriggerPlayer(), bj_ALLIANCE_NEUTRAL)
        UnitRemoveAbilityBJ(FourCC('A02O'), udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
        ConditionalTriggerExecute(gg_trg_RepickAlien)
    end

    --===========================================================================
    gg_trg_RepickAlienChoice = CreateTrigger()
    TriggerRegisterDialogEventBJ(gg_trg_RepickAlienChoice, udg_RepickAlienDialog)
    TriggerAddCondition(gg_trg_RepickAlienChoice, Condition(Trig_RepickAlienChoice_Conditions))
    TriggerAddAction(gg_trg_RepickAlienChoice, Trig_RepickAlienChoice_Actions)
end)
if Debug then Debug.endFile() end
