if Debug then Debug.beginFile "Game/PlayerRolePicking/Janitor" end
OnInit.map("Janitor", function(require)
    ---@return boolean
    function Trig_Janitor_Func001Func002Func002C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Janitor_Func001Func002C()
        if (not (udg_TempPlayer == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Janitor_Func001C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    function Trig_Janitor_Actions()
        local name ---@type string
        if (Trig_Janitor_Func001C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5350")
        else
            if (Trig_Janitor_Func001Func002C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5352")
            else
                if (Trig_Janitor_Func001Func002Func002C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5327")
                else
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5351")
                end
            end
        end
        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
        UnitAddItemByIdSwapped(FourCC('I00J'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Janitor "
        name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, name)
        StateGrid_SetPlayerName(udg_TempPlayer, name)
    end

    --===========================================================================
    gg_trg_Janitor = CreateTrigger()
    TriggerAddAction(gg_trg_Janitor, Trig_Janitor_Actions)
end)
if Debug then Debug.endFile() end
