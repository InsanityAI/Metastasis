library LiquidateCommand initializer init requires Commands, CSAPI, Anonymity, StringUtil
    struct LiquidateCommand extends Command
        public method execute takes player initiator, integer argc returns nothing
            local player targettedPlayer = Anonymity_GetPlayerFromStringIndex(StringUtil_argv[1])
            if initiator == udg_Mutant then
                if targettedPlayer == null then
                    call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Invalid player!")
                    return
                endif
                if not udg_Player_IsMutantSpawn[GetConvertedPlayerId(targettedPlayer)] then
                    call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Player " + GetPlayerName(targettedPlayer) + " is not your spawn!")
                    return
                endif
                call DialogClearBJ(udg_Liquidate_AreYouSure) 
                call DialogSetMessageBJ(udg_Liquidate_AreYouSure, ("Are you sure you wish to liquidate " + (PlayerColor_GetPlayerTextColor(targettedPlayer) + (GetPlayerName(targettedPlayer) + "|r?")))) 
                call DialogAddButtonBJ(udg_Liquidate_AreYouSure, "No") 
                set udg_Liquidate_AreYouSureButton[1] = GetLastCreatedButtonBJ() 
                call DialogAddButtonBJ(udg_Liquidate_AreYouSure, "Yes") 
                set udg_Liquidate_AreYouSureButton[2] = GetLastCreatedButtonBJ() 
                set udg_Liquidate_ToLiquidate = udg_TempInt 
                call DialogDisplayBJ(true, udg_Liquidate_AreYouSure, udg_Mutant) 
            elseif initiator == udg_Parasite then
                if targettedPlayer == null then
                    call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Invalid player!")
                    return
                endif
                if not udg_Player_IsParasiteSpawn[GetConvertedPlayerId(targettedPlayer)] then
                    call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Player " + GetPlayerName(targettedPlayer) + " is not your spawn!")
                    return
                endif
                call DialogClearBJ(udg_Liquidate_AreYouSure2) 
                call DialogSetMessageBJ(udg_Liquidate_AreYouSure2, ("Are you sure you wish to liquidate " + (PlayerColor_GetPlayerTextColor(targettedPlayer) + (GetPlayerName(targettedPlayer) + "|r?")))) 
                call DialogAddButtonBJ(udg_Liquidate_AreYouSure2, "No") 
                set udg_Liquidate_AreYouSureButton2[1] = GetLastCreatedButtonBJ() 
                call DialogAddButtonBJ(udg_Liquidate_AreYouSure2, "Yes") 
                set udg_Liquidate_AreYouSureButton2[2] = GetLastCreatedButtonBJ() 
                set udg_Liquidate_ToLiquidate2 = udg_TempInt 
                call DialogDisplayBJ(true, udg_Liquidate_AreYouSure2, udg_Parasite) 
            else
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Unknown command!")
                return
            endif
        endmethod

        public static method create takes string commandAlias returns thistype
            return thistype.allocate(commandAlias, 2)
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call LiquidateCommand.create("l")
        call LiquidateCommand.create("liquidate")
    endfunction
endlibrary