library AllowCommand initializer init requires Commands, ChatSystem, CSAPI
    struct AllowCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("allow", 1)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            if initiator == udg_Mutant then
                set udg_AllowMutantTK = true 
                call DisableTrigger(gg_trg_NoMutantTK) 
            elseif initiator == udg_Parasite then
                set udg_AllowAlienTK = true 
                call DisableTrigger(gg_trg_NoAlienTK) 
            else
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Unknown command!")
                return
            endif
            call CSAPI_sendSystemMessageToPlayer(initiator, "Your spawns may now attack you.")
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call AllowCommand.create()
    endfunction
endlibrary
