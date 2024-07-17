if Debug then Debug.beginFile "Game/Allignment/Android/AndroidRemote" end
OnInit.map("AndroidRemote", function(require)
    ---@return boolean
    function Trig_AndroidRemote_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A05W'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidRemote_Func003C()
        if (not (GetItemUserData(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), FourCC('I01I'))) ~= udg_AndroidRemoteID)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func001Func001Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then
            return false
        end
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) ~= udg_Parasite)) then
            return false
        end
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        if (not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] ~= true)) then
            return false
        end
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) ~= udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func001Func001Func002C()
        if ((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] == true)) then
            return true
        end
        if ((udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] == true)) then
            return true
        end
        return false
    end

    function Trig_AndroidRemote_Func005Func001Func001Func007A()
        DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 7.00,
            "|cff800080Android successfully configured for HUMAN classification.|r")
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func001Func001C()
        if (not Trig_AndroidRemote_Func005Func001Func001Func001C()) then
            return false
        end
        if (not Trig_AndroidRemote_Func005Func001Func001Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func001Func007Func001Func002C()
        if ((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetEnumPlayer())] == true)) then
            return true
        end
        if ((GetEnumPlayer() == udg_Parasite)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func001Func007Func001C()
        if (not Trig_AndroidRemote_Func005Func001Func007Func001Func002C()) then
            return false
        end
        return true
    end

    function Trig_AndroidRemote_Func005Func001Func007A()
        if (Trig_AndroidRemote_Func005Func001Func007Func001C()) then
            DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 7.00,
                "|cff800080Android successfully configured for ALIEN classification.|r")
        else
        end
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func001Func008C()
        if ((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == true)) then
            return true
        end
        if ((GetOwningPlayer(GetSpellAbilityUnit()) == udg_Parasite)) then
            return true
        end
        if ((GetOwningPlayer(GetSpellAbilityUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func001C()
        if (not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] == false)) then
            return false
        end
        if (not Trig_AndroidRemote_Func005Func001Func008C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func007Func001Func002C()
        if ((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetEnumPlayer())] == true)) then
            return true
        end
        if ((GetOwningPlayer(GetEnumUnit()) == udg_Mutant)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func007Func001C()
        if (not Trig_AndroidRemote_Func005Func007Func001Func002C()) then
            return false
        end
        return true
    end

    function Trig_AndroidRemote_Func005Func007A()
        if (Trig_AndroidRemote_Func005Func007Func001C()) then
            DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 7.00,
                "|cff800080Android successfully configured for MUTANT classification.|r")
        else
        end
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005Func008C()
        if ((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == true)) then
            return true
        end
        if ((GetOwningPlayer(GetSpellAbilityUnit()) == udg_Mutant)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AndroidRemote_Func005C()
        if (not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] == false)) then
            return false
        end
        if (not Trig_AndroidRemote_Func005Func008C()) then
            return false
        end
        return true
    end

    function Trig_AndroidRemote_Func006Func001Func005A()
        SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true)
    end

    ---@return boolean
    function Trig_AndroidRemote_Func006Func001Func010Func001C()
        if (not (udg_EscapePod_Owner[GetUnitUserData(GetEnumUnit())] == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    function Trig_AndroidRemote_Func006Func001Func010A()
        if (Trig_AndroidRemote_Func006Func001Func010Func001C()) then
            SetUnitOwner(GetEnumUnit(), udg_HiddenAndroid, true)
        else
        end
    end

    ---@return boolean
    function Trig_AndroidRemote_Func006Func001C()
        if (not (udg_Android_Deactivated == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidRemote_Func006C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    function Trig_AndroidRemote_Actions()
        if (Trig_AndroidRemote_Func003C()) then
            DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 7.00,
                "|cff800080ERROR: Unit not responsive. Clearance code out of date; please find the newest remote.|r")
            return
        else
        end
        udg_TempBool = true
        if (Trig_AndroidRemote_Func005C()) then
            DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00, "|cff800080New friendly classification: MUTANT|r")
            udg_TempBool = false
            udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = false
            udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = true
            ForForce(GetPlayersAll(), Trig_AndroidRemote_Func005Func007A)
        else
            if (Trig_AndroidRemote_Func005Func001C()) then
                DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00, "|cff800080New friendly classification: ALIEN|r")
                udg_TempBool = false
                udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = true
                udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = false
                ForForce(GetPlayersAll(), Trig_AndroidRemote_Func005Func001Func007A)
            else
                if (Trig_AndroidRemote_Func005Func001Func001C()) then
                    DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00,
                        "|cff800080New friendly classification: HUMAN|r")
                    udg_TempBool = false
                    udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = false
                    udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_HiddenAndroid)] = false
                    ForForce(GetPlayersAll(), Trig_AndroidRemote_Func005Func001Func001Func007A)
                else
                end
            end
        end
        if (Trig_AndroidRemote_Func006C()) then
            if (Trig_AndroidRemote_Func006Func001C()) then
                udg_Android_Deactivated = false
                PauseUnitBJ(false, udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)])
                DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 7.00,
                    "|cff800080Android reactivated.|r")
                DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00, "|cff800080You have been reactivated.|r")
                ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('h02P')), Trig_AndroidRemote_Func006Func001Func010A)
            else
                udg_Android_Deactivated = true
                DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 7.00,
                    "|cff800080Android deactivated.|r")
                PauseUnitBJ(true, udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)])
                DisplayTimedTextToPlayer(udg_HiddenAndroid, 0, 0, 7.00, "|cff800080You have been deactivated.|r")
                ForGroupBJ(GetUnitsInRectOfPlayer(gg_rct_Space, udg_HiddenAndroid),
                    Trig_AndroidRemote_Func006Func001Func005A)
            end
        else
        end
    end

    --===========================================================================
    gg_trg_AndroidRemote = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AndroidRemote, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_AndroidRemote, Condition(Trig_AndroidRemote_Conditions))
    TriggerAddAction(gg_trg_AndroidRemote, Trig_AndroidRemote_Actions)
end)
if Debug then Debug.endFile() end
