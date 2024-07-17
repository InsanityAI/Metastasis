if Debug then Debug.beginFile "Game/PlayerRolePicking/Pilot" end
OnInit.trig("Pilot", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_Pilot_Func001Func002Func001C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Pilot_Func001Func002C()
        if (not (udg_TempPlayer == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Pilot_Func001C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Pilot_Func006Func001Func001C()
        if (not (udg_TempInt == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Pilot_Func006Func001C()
        if (not (udg_TempInt == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Pilot_Func006C()
        if (not (udg_TempInt == 1)) then
            return false
        end
        return true
    end

    function Trig_Pilot_Actions()
        local name ---@type string
        if (Trig_Pilot_Func001C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5343")
        else
            if (Trig_Pilot_Func001Func002C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5345")
            else
                if (Trig_Pilot_Func001Func002Func001C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5325")
                else
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5344")
                end
            end
        end
        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
        udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Ace "
        udg_InitialSpawnPoint[GetConvertedPlayerId(udg_TempPlayer)] = Location(-2252.00, 14431.00)
        name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] .. GetPlayerName(udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, name)
        StateTable.UpdatePlayerName(udg_TempPlayer)
        if (Trig_Pilot_Func006C()) then
            UnitAddItemByIdSwapped(FourCC('I008'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        else
            if (Trig_Pilot_Func006Func001C()) then
                UnitAddItemByIdSwapped(FourCC('I001'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
            else
                if (Trig_Pilot_Func006Func001Func001C()) then
                    UnitAddItemByIdSwapped(FourCC('I000'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
                else
                    UnitAddItemByIdSwapped(FourCC('I007'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
                end
            end
        end
    end

    --===========================================================================
    gg_trg_Pilot = CreateTrigger()
    TriggerAddAction(gg_trg_Pilot, Trig_Pilot_Actions)
end)
if Debug then Debug.endFile() end
