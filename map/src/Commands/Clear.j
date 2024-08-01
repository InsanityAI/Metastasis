library ClearCommand initializer init requires Commands, CSAPI
    struct ClearCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("clear", 1)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            if initiator == GetLocalPlayer() then 
                call ClearTextMessages() 
            endif 
            call CSAPI_sendSystemMessageToPlayer(initiator, "Game messages cleared!")
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call ClearCommand.create()
    endfunction
endlibrary
