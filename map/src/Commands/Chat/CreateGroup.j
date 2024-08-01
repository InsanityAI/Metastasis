library CreateGroupCommand initializer init requires Commands, ChatSystem, ChatGroups, ChatProfiles, StringUtil, CSAPI
    struct CreateGroupCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("creategroup", 2)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            local ChatGroup chatGroup
            local ChatProfile initiatorProfile = ChatProfiles_getReal(initiator)
            local string tempString

            if IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) then
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You cannot create chat groups when dead!")
                return
            endif

            set tempString = SubString(StringUtil_argv[1],0,1)
            if tempString == "0" or S2I(tempString) != 0 then
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Group name cannot start with a number!")
                return
            endif

            if ChatGroups_exists(StringUtil_argv[1]) then
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Chat group already exists!")
                return
            endif

            set chatGroup = ChatGroups_get(StringUtil_argv[1])
            if chatGroup.owner != 0 then
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cffffcc00This group has already been taken.|r")
                return
            endif

            set chatGroup.owner = initiatorProfile
            call chatGroup.add(initiatorProfile)
            call CSAPI_sendSystemMessageToPlayer(initiator, "|cff008000Chat group successfully created!|r")
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call CreateGroupCommand.create()
    endfunction
endlibrary