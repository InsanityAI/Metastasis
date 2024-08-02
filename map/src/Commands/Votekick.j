library VotekickCommand initializer init requires Commands, CSAPI, Anonymity, StringUtil, Timeout
    globals
        private integer voteCount = 0 
    endglobals

    private function CountVotes takes nothing returns nothing
        local player thisPlayer = GetEnumPlayer()
        if IsPlayerInForce(thisPlayer, udg_DeadGroup) == false and GetPlayerSlotState(thisPlayer) == PLAYER_SLOT_STATE_PLAYING  then 
            set voteCount = voteCount + 1 
        endif 
    endfunction

    //Votekick dead players
    struct VotekickCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("votekick", 2)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            local player targettedPlayer = Anonymity_GetPlayerFromStringIndex(StringUtil_argv[1])
            local integer pId = GetConvertedPlayerId(targettedPlayer)

            if targettedPlayer == null then
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Invalid player!")
                return
            endif

            if not IsPlayerInForce(targettedPlayer, udg_DeadGroup) then
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Cannot votekick a player that isn't dead!")
                return
            endif

            if IsPlayerInForce(initiator, udg_DeadGroup) then
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Cannot votekick as a dead player!")
                return
            endif

            if IsPlayerInForce(initiator, udg_Player_VotedKickGroup[pId]) then
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You have already voted to votekick this player!")
                return
            endif

            set udg_Player_DeadKickVotes[pId] = udg_Player_DeadKickVotes[pId] + 1
            set voteCount = 0 
            call ForceAddPlayer(udg_Player_VotedKickGroup[pId], initiator)
            call ForForce(GetPlayersAll(), function CountVotes)
            if udg_Player_DeadKickVotes[pId] >= (voteCount / 2) then 
                if targettedPlayer == udg_HiddenAndroid then 
                    call DisplayTextToForce(GetPlayersAll(), ("Dialoguing offensive android..." + (" " + (udg_Player_OriginalName[pId] + "!")))) 
                else 
                    call DisplayTextToForce(GetPlayersAll(), ("Dialoguing offensive player..." + (" " + (udg_Player_OriginalName[pId] + "!")))) 
                endif 
                if GetLocalPlayer() == targettedPlayer then
                    call ShowInterface(false, 2.00)
                    call Timeout.start(2.01, false, function ChatUI_refreshChat)
                endif
            else 
                call DisplayTextToForce(GetPlayersAll(), (I2S(((voteCount / 2) -udg_Player_DeadKickVotes[pId])) + (" votes left to kick " + (udg_Player_OriginalName[pId] + "!")))) 
            endif 
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call VotekickCommand.create()
    endfunction
endlibrary
