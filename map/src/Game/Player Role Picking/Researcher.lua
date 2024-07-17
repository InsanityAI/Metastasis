if Debug then Debug.beginFile "Game/PlayerRolePicking/Researcher" end
OnInit.map("Researcher", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_Researcher_Func001Func001Func001C()
        if (not (udg_TempPlayer == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Researcher_Func001Func001C()
        if (not (udg_TempPlayer == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Researcher_Func001C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Researcher_Func003C()
        if (not (udg_TempInt == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Researcher_Func004Func001Func001Func001Func006Func002C()
        if ((udg_TempPlayer == udg_Mutant)) then
            return true
        end
        if ((udg_TempPlayer == udg_Parasite)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Researcher_Func004Func001Func001Func001Func006C()
        if (not Trig_Researcher_Func004Func001Func001Func001Func006Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Researcher_Func004Func001Func001Func001C()
        if (not (udg_TempInt == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Researcher_Func004Func001Func001C()
        if (not (udg_TempInt == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Researcher_Func004Func001C()
        if (not (udg_TempInt == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Researcher_Func004Func007Func002C()
        if ((udg_TempPlayer == udg_Mutant)) then
            return true
        end
        if ((udg_TempPlayer == udg_Parasite)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Researcher_Func004Func007C()
        if (not Trig_Researcher_Func004Func007Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Researcher_Func004C()
        if (not (udg_TempInt == 4)) then
            return false
        end
        return true
    end

    function Trig_Researcher_Actions()
        local name ---@type string
        if (Trig_Researcher_Func001C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5338")
        else
            if (Trig_Researcher_Func001Func001C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5337")
            else
                if (Trig_Researcher_Func001Func001Func001C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5336")
                else
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30.00, "TRIGSTR_5329")
                end
            end
        end
        udg_TempInt = GetRandomInt(1, 4)
        if (Trig_Researcher_Func003C()) then
            udg_TempInt = GetRandomInt(1, 2)
        else
        end
        if (Trig_Researcher_Func004C()) then
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff000080You have a PhD in Biology.|r")
            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff008080You have 200% health regeneration!|r")
            udg_Researcher_PhD[GetConvertedPlayerId(udg_TempPlayer)] = 4
            SetPlayerTechResearchedSwap(FourCC('R006'), 1, udg_TempPlayer)
            if (Trig_Researcher_Func004Func007C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cffFF0000This only applies while you are human.|r")
            else
            end
        else
            if (Trig_Researcher_Func004Func001C()) then
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff000080You have a PhD in Electronics.|r")
                DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30,
                    "|cff008080Sentries and force shields built by you gain 50 health!|r")
                udg_Researcher_PhD[GetConvertedPlayerId(udg_TempPlayer)] = 3
            else
                if (Trig_Researcher_Func004Func001Func001C()) then
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30,
                        "|cff000080You have a PhD in Gravitational Effects.|r")
                    DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30,
                        "|cff008080Ships under your control move 10% faster!|r")
                    udg_Researcher_PhD[GetConvertedPlayerId(udg_TempPlayer)] = 2
                    SetPlayerTechResearchedSwap(FourCC('R007'), 1, udg_TempPlayer)
                else
                    if (Trig_Researcher_Func004Func001Func001Func001C()) then
                        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff000080You have a PhD in Optics!|r")
                        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff008080You have extra sight range!|r")
                        udg_Researcher_PhD[GetConvertedPlayerId(udg_TempPlayer)] = 1
                        SetPlayerTechResearchedSwap(FourCC('R008'), 1, udg_TempPlayer)
                        if (Trig_Researcher_Func004Func001Func001Func001Func006C()) then
                            DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30,
                                "|cffFF0000This only applies while you are human.|r")
                        else
                        end
                    else
                    end
                end
            end
        end
        DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r")
        UnitAddItemByIdSwapped(FourCC('I025'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        UnitAddItemByIdSwapped(FourCC('I002'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Dr. "
        name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + GetPlayerName(udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, name)
        StateTable.UpdatePlayerName(udg_TempPlayer)
    end

    --===========================================================================
    gg_trg_Researcher = CreateTrigger()
    TriggerAddAction(gg_trg_Researcher, Trig_Researcher_Actions)
end)
if Debug then Debug.endFile() end
