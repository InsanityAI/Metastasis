if Debug then Debug.beginFile "Game/PlayerRolePicking/Engineer" end
OnInit.map("Engineer", function(require)
    ---@return boolean
    function Trig_Engineer_Func001Func002Func002C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Engineer_Func001Func002C()
        if (not (udg_TempPlayer == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Engineer_Func001C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Engineer_Func007C()
        if (not (udg_ExtraStation == 1)) then
            return false
        end
        return true
    end

    function Trig_Engineer_Actions()
        local name ---@type string
        if (Trig_Engineer_Func001C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5360")
        else
            if (Trig_Engineer_Func001Func002C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5361")
            else
                if (Trig_Engineer_Func001Func002Func002C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5362")
                else
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5363")
                end
            end
        end
        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
        UnitAddItemByIdSwapped(FourCC('I00B'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        UnitAddItemByIdSwapped(FourCC('I00H'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Engineer "
        name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, name)
        StateGrid_SetPlayerName(udg_TempPlayer, name)
        if (Trig_Engineer_Func007C()) then
            udg_InitialSpawnPoint[GetConvertedPlayerId(udg_TempPlayer)] = Location(-6016.00, 11980.00)
            udg_EngineerUsed = true
        else
        end
    end

    --===========================================================================
    gg_trg_Engineer = CreateTrigger()
    TriggerAddAction(gg_trg_Engineer, Trig_Engineer_Actions)
end)
if Debug then Debug.endFile() end
