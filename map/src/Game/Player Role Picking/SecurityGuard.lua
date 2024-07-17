if Debug then Debug.beginFile "Game/PlayerRolePicking/SecurityGuard" end
OnInit.trig("SecurityGuard", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_SecurityGuard_Func001Func002Func002C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SecurityGuard_Func001Func002C()
        if (not (udg_TempPlayer == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SecurityGuard_Func001C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SecurityGuard_Func006Func001Func001C()
        if (not (udg_TempInt == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SecurityGuard_Func006Func001C()
        if (not (udg_TempInt == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SecurityGuard_Func006C()
        if (not (udg_TempInt == 1)) then
            return false
        end
        return true
    end

    function Trig_SecurityGuard_Actions()
        local name ---@type string
        if (Trig_SecurityGuard_Func001C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5353")
        else
            if (Trig_SecurityGuard_Func001Func002C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5354")
            else
                if (Trig_SecurityGuard_Func001Func002Func002C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5355")
                else
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5356")
                end
            end
        end
        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
        SetPlayerTechResearchedSwap(FourCC('R000'), 1, udg_TempPlayer)
        udg_TempInt = GetRandomInt(1, 4)
        udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Private "
        if (Trig_SecurityGuard_Func006C()) then
            UnitAddItemByIdSwapped(FourCC('I008'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        else
            if (Trig_SecurityGuard_Func006Func001C()) then
                UnitAddItemByIdSwapped(FourCC('I001'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
            else
                if (Trig_SecurityGuard_Func006Func001Func001C()) then
                    UnitAddItemByIdSwapped(FourCC('I000'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
                else
                    UnitAddItemByIdSwapped(FourCC('I007'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
                end
            end
        end
        name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] .. GetPlayerName(udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, name)
        StateTable.UpdatePlayerName(udg_TempPlayer)
    end

    --===========================================================================
    gg_trg_SecurityGuard = CreateTrigger()
    TriggerAddAction(gg_trg_SecurityGuard, Trig_SecurityGuard_Actions)
end)
if Debug then Debug.endFile() end
