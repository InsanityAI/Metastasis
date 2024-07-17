if Debug then Debug.beginFile "Game/PlayerRolePicking/Captain" end
OnInit.trig("Captain", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_Captain_Func001Func001Func001C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Captain_Func001Func001C()
        if (not (udg_TempPlayer == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Captain_Func001C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    function Trig_Captain_Actions()
        local name ---@type string
        if (Trig_Captain_Func001C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 10, "TRIGSTR_5349")
        else
            if (Trig_Captain_Func001Func001C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5348")
            else
                if (Trig_Captain_Func001Func001Func001C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5346")
                else
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5347")
                end
            end
        end
        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
        UnitAddItemByIdSwapped(FourCC('I00I'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Captain "
        udg_InitialSpawnPoint[GetConvertedPlayerId(udg_TempPlayer)] = Location(-14714.00, -13302.00)
        name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] .. GetPlayerName(udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, name)
        StateTable.UpdatePlayerName(udg_TempPlayer)
    end

    --===========================================================================
    gg_trg_Captain = CreateTrigger()
    TriggerAddAction(gg_trg_Captain, Trig_Captain_Actions)
end)
if Debug then Debug.endFile() end
