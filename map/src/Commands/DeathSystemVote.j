library DeathSystemVoteCommand initializer init requires Commands, Timeout 
    private function DisplayDialogToPlayers takes nothing returns nothing 
        call DialogDisplay(GetEnumPlayer(), udg_DeathVoteDialog, true) 
    endfunction 

    private function ShowDialogs takes nothing returns nothing 
        call Timeout.complete() 
        set udg_DeathVoteDialog_Buttons[1] = DialogAddButtonBJ(udg_DeathVoteDialog, "TRIGSTR_2353") 
        set udg_DeathVoteDialog_Buttons[2] = DialogAddButtonBJ(udg_DeathVoteDialog, "TRIGSTR_2354") 
        call ForForce(GetPlayersAll(), function DisplayDialogToPlayers) 
    endfunction 

    struct DeathSystemVoteCommand extends Command 
        public static method create takes nothing returns thistype 
            return thistype.allocate("votedeath", 1) 
        endmethod 

        public method execute takes player initiator, integer argc returns nothing 
            call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3434") 
            call PlaySoundBJ(gg_snd_ArrangedTeamInvitation) 
            call Timeout.start(5.00, false, function ShowDialogs) 
            call this.destroy()
        endmethod 
    endstruct 

    public function Disable takes nothing returns nothing
        call DeathSystemVoteCommand.destroy()
    endfunction

    private function init takes nothing returns nothing 
        call DeathSystemVoteCommand.create() 
    endfunction 
endlibrary 
