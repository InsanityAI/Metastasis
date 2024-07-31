library ClearCommand initializer init requires Commands, ChatSystem, Anonymity
    struct ClearCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("clear", 1)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            if initiator == GetLocalPlayer() then 
                call ClearTextMessages() 
            endif 
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call ClearCommand.create()
    endfunction
endlibrary
