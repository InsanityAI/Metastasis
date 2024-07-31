library AddGroupMemberCommand initializer init requires Commands, ChatSystem, ChatGroups, ChatProfiles, StringUtil, Anonymity
    struct AddGroupMemberCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("add", 3)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            local ChatGroup chatGroup
            local ChatProfile initiatorProfile = ChatProfiles_getReal(initiator)
            local player targettedPlayer = Anonymity_GetPlayerFromStringIndex(StringUtil.argv[2])
            local ChatProfile targettedProfile

            if targettedPlayer == null then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Invalid player!")
                return
            endif

            if IsPlayerInForce(initiator, udg_DeadGroup) then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You cannot edit chat groups when dead!")
                return
            endif

            if not ChatGroups_exists(StringUtil_argv[1]) then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Chat group does not exist!")
                return
            endif

            set chatGroup = ChatGroups_get(StringUtil_argv[1])
            if chatGroup.owner != initiatorProfile then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You are not the owner of this chat group!")
                return
            endif

            set targettedProfile = ChatProfiles_getReal(targettedPlayer)
            if chatGroup.contains(targettedProfile) then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Player is already in this group!")
                return
            endif

            call chatGroup.add(targettedProfile)
            call ChatSystem_sendSystemMessageToGroup(chatGroup, "|cFF00FFFFNotice:|r " + targettedProfile.name " + has been added to this group.")
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call AddGroupMemberCommand.create()
    endfunction
endlibrary