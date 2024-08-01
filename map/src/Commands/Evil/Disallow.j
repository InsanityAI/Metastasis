library DisallowCommand initializer init requires Commands, ChatSystem, CSAPI
    struct DisallowCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("disallow", 1)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            if initiator == udg_Mutant then
                set udg_AllowMutantTK = false 
                call EnableTrigger(gg_trg_NoMutantTK) 
            elseif initiator == udg_Parasite then
                set udg_AllowAlienTK = false 
                call EnableTrigger(gg_trg_NoAlienTK) 
            else
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Unknown command!")
                return
            endif
            call CSAPI_sendSystemMessageToPlayer(initiator, "Your spawns may no longer attack you.")
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call DisallowCommand.create()
    endfunction
endlibrary
