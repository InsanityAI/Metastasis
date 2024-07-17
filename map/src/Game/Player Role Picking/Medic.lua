if Debug then Debug.beginFile "Game/PlayerRolePicking/Medic" end
OnInit.trig("Medic", function(require)
    ---@return boolean
    function Trig_Medic_Func001Func002Func002C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Medic_Func001Func002C()
        if (not (udg_TempPlayer == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Medic_Func001C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    function Trig_Medic_Actions()
        local name ---@type string
        if (Trig_Medic_Func001C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5368")
        else
            if (Trig_Medic_Func001Func002C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5369")
            else
                if (Trig_Medic_Func001Func002Func002C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5370")
                else
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5371")
                end
            end
        end
        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
        UnitAddItemByIdSwapped(FourCC('I00L'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        UnitAddItemByIdSwapped(FourCC('I002'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        UnitAddItemByIdSwapped(FourCC('I00M'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Medic "
        name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] .. GetPlayerName(udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, name)
        StateTable.UpdatePlayerName(udg_TempPlayer)
    end

    --===========================================================================
    gg_trg_Medic = CreateTrigger()
    TriggerAddAction(gg_trg_Medic, Trig_Medic_Actions)
end)
if Debug then Debug.endFile() end
