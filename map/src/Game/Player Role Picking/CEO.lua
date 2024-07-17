if Debug then Debug.beginFile "Game/PlayerRolePicking/CEO" end
OnInit.map("CEO", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_CEO_Func001Func002Func001C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_CEO_Func001Func002C()
        if (not (udg_TempPlayer == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_CEO_Func001C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    function Trig_CEO_Actions()
        local name ---@type string
        if (Trig_CEO_Func001C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5339")
        else
            if (Trig_CEO_Func001Func002C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5342")
            else
                if (Trig_CEO_Func001Func002Func001C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5340")
                else
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5341")
                end
            end
        end
        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
        udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "CEO "
        name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, name)
        StateTable.UpdatePlayerName(udg_TempPlayer)
        CreateNUnitsAtLoc(1, FourCC('H046'), udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING)
        udg_TempUnit = GetLastCreatedUnit()
        udg_TempUnit2 = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]
        ExecuteFunc("RoboButler")
    end

    --===========================================================================
    gg_trg_CEO = CreateTrigger()
    TriggerAddAction(gg_trg_CEO, Trig_CEO_Actions)
end)
if Debug then Debug.endFile() end
