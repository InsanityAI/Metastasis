library UnstuckCommand initializer init requires Commands, ChatSystem
    struct UnstuckCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("unstuck", 1)
        endmethod

        //Credits to Tal0n for this method, formerly known as RunCinematicUnstuck function
        private method cinematicEnable takes player p, boolean enable returns nothing
            if(GetLocalPlayer() == p) then // the player who typed -unstuck 
                call ClearTextMessages() // this can probably be disabled but it clears messages sent from triggers usually 
                call ShowInterface(enable, 1.5) // disables/enables player interface 
                call EnableUserControl(enable) // disables/enables player cursor and control 
                call EnableOcclusion(enable) 
                call EnableWorldFogBoundary(enable) // likely fixes filter bugs 
            endif 
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            call RunCinematicUnstuck(initiator, false) // calls for a set of interface toggles offward 
            call RunCinematicUnstuck(initiator, true) // calls for a set of interface toggles onward 
            call ChatSystem_sendSystemMessageToPlayer(initiator, "Unstucking...")
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call UnstuckCommand.create()
    endfunction
endlibrary