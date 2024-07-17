if Debug then Debug.beginFile "Game/PlayerRolePicking/Commissar" end
OnInit.map("Commissar", function(require)
    ---@return boolean
    function Trig_Commissar_Func001Func002Func002C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Commissar_Func001Func002C()
        if (not (udg_TempPlayer == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Commissar_Func001C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    function Trig_Commissar_Actions()
        local name ---@type string
        if (Trig_Commissar_Func001C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5357")
        else
            if (Trig_Commissar_Func001Func002C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5358")
            else
                if (Trig_Commissar_Func001Func002Func002C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5324")
                else
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5359")
                end
            end
        end
        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
        UnitAddItemByIdSwapped(FourCC('I00G'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Commissar "
        name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, name)
        StateGrid_SetPlayerName(udg_TempPlayer, name)
    end

    --===========================================================================
    gg_trg_Commissar = CreateTrigger()
    TriggerAddAction(gg_trg_Commissar, Trig_Commissar_Actions)
end)
if Debug then Debug.endFile() end
