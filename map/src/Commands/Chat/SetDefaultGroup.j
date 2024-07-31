library SetDefaultGroupCommand initializer init requires Commands, ChatSystem, ChatGroups, ChatProfiles, StringUtil, PlayerSelectedChat, Anonymity
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
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You cannot change default chat group when dead!")
                return
            endif

            if ChatGroups_exists(StringUtil_argv[1]) then
                set chatGroup = ChatGroups_get(StringUtil_argv[1])
                if chatGroup.owner != initiatorProfile and not chatGroup.contains(initiatorProfile) then
                    call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You do not belong in this chat group!")
                    return
                endif

                call ChatSystem_SetPlayerChatGroup(initiator, chatGroup)
                call ChatSystem_sendSystemMessageToPlayer(initiator, "Default chat is now directed at " + chatGroup)
            else
                set targettedPlayer = Anonymity_GetPlayerFromStringIndex(StringUtil.argv[1])
                if targettedPlayer == null then
                    call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Chat group or player not found!")
                    return
                endif
                set chatProfile = ChatProfiles_getReal(targettedPlayer)
                call ChatSystem_SetPlayerRecepient(initiator, chatProfile)
                call ChatSystem_sendSystemMessageToPlayer(initiator, "Default chat is now directed at " + chatProfile.name)
            endif
            
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call SetDefaultGroupCommand.create()
    endfunction
endlibrary
