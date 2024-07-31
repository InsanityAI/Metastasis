library ListGroupsCommand initializer init requires Commands, ChatSystem, StringUtil
    struct ListGroupsCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("list", 2)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            local ChatGroup chatGroup
            local ChatProfile initiatorProfile = ChatProfiles_getReal(initiator)
            local ChatProfile currentProfile
            local string tempString
            local boolean isInGroup = false
            local Table groupMembers
            local integer i = 0

            if IsPlayerInForce(initiator, udg_DeadGroup) then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You cannot create chat groups when dead!")
                return
            endif

            if not ChatGroups_exists(StringUtil_argv[1]) then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Chat group does not exist!")
                return
            endif
            
            set chatGroup = ChatGroups_get(StringUtil_argv[1])
            if chatGroup.owner != initiatorProfile and not chatGroup.contains(initiatorProfile) then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You do not belong in this chat group!")
                return
            endif

            set groupMembers = chatGroup.members.getKeys()
            set i = groupMembers[0]
            call ChatSystem_sendSystemMessageToPlayer(initiator, "|cff808000Players in group |cff0080C0" + chatGroup.name + "|r:")
            loop
                exitwhen i == 0
                set currentProfile = groupMembers[i]
                call ChatSystem_sendSystemMessageToPlayer(initiator, currentProfile.name)
                set i = i - 1
            endloop
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call ListGroupsCommand.create()
    endfunction
endlibrary