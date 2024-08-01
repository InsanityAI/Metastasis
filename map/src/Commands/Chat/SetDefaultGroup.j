library SetDefaultGroupCommand initializer init requires Commands, ChatSystem, ChatGroups, ChatProfiles, StringUtil, PlayerSelectedChat, Anonymity, CSAPI
    struct SetDefaultGroupCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("default", 2)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            local ChatProfile initiatorProfile = ChatProfiles_getReal(initiator)
            local ChatGroup chatGroup
            local ChatProfile chatProfile
            local player targettedPlayer

            if IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) then
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You cannot change default chat group when dead!")
                return
            endif

            if ChatGroups_exists(StringUtil_argv[1]) then
                set chatGroup = ChatGroups_get(StringUtil_argv[1])
                if chatGroup.owner != initiatorProfile and not chatGroup.contains(initiatorProfile) then
                    call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You do not belong in this chat group!")
                    return
                endif

                call PlayerSelectedChat_SetPlayerChatGroup(initiator, chatGroup)
                call CSAPI_sendSystemMessageToPlayer(initiator, "Default chat is now directed at " + chatGroup.name)
            else
                set targettedPlayer = Anonymity_GetPlayerFromStringIndex(StringUtil_argv[1])
                if targettedPlayer == null then
                    call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Chat group or player not found!")
                    return
                endif
                set chatProfile = ChatProfiles_getReal(targettedPlayer)
                call PlayerSelectedChat_SetPlayerRecepient(initiator, chatProfile)
                call CSAPI_sendSystemMessageToPlayer(initiator, "Default chat is now directed at " + chatProfile.name)
            endif
            
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call SetDefaultGroupCommand.create()
    endfunction
endlibrary
