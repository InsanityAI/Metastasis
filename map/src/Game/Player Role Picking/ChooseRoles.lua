if Debug then Debug.beginFile "Game/PlayerRolePicking/ChooseRoles" end
OnInit.map("ChooseRoles", function(require)
    ---@return boolean
    function Trig_ChooseRoles_Func003Func001C()
        if (not (GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING)) then
            return false
        end
        if (not (udg_Player_Left[GetConvertedPlayerId(GetEnumPlayer())] ~= true)) then
            return false
        end
        return true
    end

    function Trig_ChooseRoles_Func003A()
        if (Trig_ChooseRoles_Func003Func001C()) then
            ForceAddPlayerSimple(GetEnumPlayer(), udg_ChooseGroup)
        else
        end
    end

    function Trig_ChooseRoles_Func005A()
        udg_TempUnit = GroupPickRandomUnit(udg_ChooseRoles_DummyGroup)
        GroupRemoveUnitSimple(udg_TempUnit, udg_ChooseRoles_DummyGroup)
        udg_TempInt = GetUnitUserData(udg_TempUnit)
        udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] = udg_TempInt
    end

    function Trig_ChooseRoles_Func006A()
        udg_TempPlayer = GetEnumPlayer()
        TriggerExecute(udg_PlayerRoleTrigger[udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())]])
    end

    ---@return boolean
    function Trig_ChooseRoles_Func007Func001Func002Func001C()
        if (not (udg_HiddenAndroid == GetEnumPlayer())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ChooseRoles_Func007Func001Func002C()
        if (not (udg_Parasite == GetEnumPlayer())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ChooseRoles_Func007Func001C()
        if (not (udg_Mutant == GetEnumPlayer())) then
            return false
        end
        return true
    end

    function Trig_ChooseRoles_Func007A()
        if (Trig_ChooseRoles_Func007Func001C()) then
            DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30,
                "-Kill everybody, or turn them into mindless drones. Use stealth and sabotage at first, but when you become more powerful confront your enemies directly.")
        else
            if (Trig_ChooseRoles_Func007Func001Func002C()) then
                DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30,
                    "-Kill everybody, or turn them into spawns. Use stealth and infection to confront your enemies at first, and later confront them directly when you evolve.")
            else
                if (Trig_ChooseRoles_Func007Func001Func002Func001C()) then
                    DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30,
                        "-Kill the mutant, the alien, and all of their allies. Please try to protect company property.\n-Protect local personnel. If too many are killed by you, you will be shut down.\n-You may upgrade yourself into a combat form if enough time passes.\n-If you die, you may be revived at the Arbitress. However you will be under the control of the person who revived you.")
                else
                    DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30,
                        "-Kill the mutant, the alien, and all of their allies. Please try to protect company property.")
                end
            end
        end
    end

    ---@return boolean
    function Trig_ChooseRoles_Func008Func001C()
        if ((udg_EngineerUsed == true)) then
            return true
        end
        if ((udg_TESTING == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_ChooseRoles_Func008C()
        if (not Trig_ChooseRoles_Func008Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ChooseRoles_Func010Func002Func001C()
        if ((udg_ExtraStation == 2)) then
            return true
        end
        if ((udg_TESTING == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_ChooseRoles_Func010Func002C()
        if (not Trig_ChooseRoles_Func010Func002Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ChooseRoles_Func010C()
        if (not (CountPlayersInForceBJ(GetPlayersAll()) >= 11)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ChooseRoles_Func011C()
        if (not (CountPlayersInForceBJ(GetPlayersAll()) <= 6)) then
            return false
        end
        if (not (udg_TESTING == false)) then
            return false
        end
        return true
    end

    function Trig_ChooseRoles_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        ForceClear(udg_ChooseGroup)
        ForForce(GetPlayersAll(), Trig_ChooseRoles_Func003A)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = udg_NumberofRoles
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            CreateNUnitsAtLoc(1, FourCC('e000'), Player(PLAYER_NEUTRAL_PASSIVE), udg_HoldZone, bj_UNIT_FACING)
            GroupAddUnitSimple(GetLastCreatedUnit(), udg_ChooseRoles_DummyGroup)
            SetUnitUserData(GetLastCreatedUnit(), GetForLoopIndexA())
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        ForForce(udg_ChooseGroup, Trig_ChooseRoles_Func005A)
        ForForce(udg_ChooseGroup, Trig_ChooseRoles_Func006A)
        ForForce(udg_ChooseGroup, Trig_ChooseRoles_Func007A)
        if (Trig_ChooseRoles_Func008C()) then
            TriggerExecute(gg_trg_ST8mInit)
        else
            RemoveUnit(gg_unit_h04E_0259)
            DestroyTrigger(gg_trg_ST8Death)
            DestroyTrigger(gg_trg_ST8AttackEnd)
            DestroyTrigger(gg_trg_ST8Attack)
        end
        TriggerExecute(gg_trg_ST9Init)
        if (Trig_ChooseRoles_Func010C()) then
            TriggerExecute(gg_trg_ST10Init)
        else
            if (Trig_ChooseRoles_Func010Func002C()) then
                TriggerExecute(gg_trg_ST10Init)
            else
                TriggerExecute(gg_trg_ST10UnInit)
            end
        end
        if (Trig_ChooseRoles_Func011C()) then
            -- No android? No arbi, its bloat (more playspace to drag games)
            RemoveUnit(gg_unit_h003_0018)
            DestroyTrigger(gg_trg_ST1Death)
            DestroyTrigger(gg_trg_ST1AttackEnd)
            DestroyTrigger(gg_trg_ST1Attack)
        else
        end
    end

    --===========================================================================
    gg_trg_ChooseRoles = CreateTrigger()
    TriggerAddAction(gg_trg_ChooseRoles, Trig_ChooseRoles_Actions)
end)
if Debug then Debug.endFile() end
