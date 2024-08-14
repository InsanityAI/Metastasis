library VotingDialog requires Table, MultiOptionDialog
    //     VotingDialog v1.0 by Insanity_AI  
    //     ------------------------------------------------------------------------------  
    //     MultiOptionDialog extension to wrap them in a player voting logic.  

    //     Requires:  
    //         MultiOptionDialog - [INSERT LINK HERE]  
    //         SetUtils - https://www.hiveworkshop.com/threads/set-group-datastructure.331886/  

    //     Installation:  
    //         Just Plug & Play, nothing specific to be done.  

    //     MultiOptionDialog API:  
    //         VotingDialog.create(data?)      -> creates a new VotingDialog.  
    //                                         -> data can be an existing VotingDialog object to make another copy of.  
    //         VotingDialog.votingDoneCallback - callback function for when all players have comitted their votes.  
    //         VotingDialog.title              - Title text for dialog. (nillable)  
    //         VotingDialog.buttons            - array of MultiOptionDialogButton objects (not nillable, must be at least empty table.)  
    //         VotingDialog.commitButton       - DialogButtonWrapper for commit.  
    //                                         - commit button's callback is not to be used, as it is used by VotingDiaog to count votes!  
    //         VotingDialog:Enqueue(playerSet) -> enqueues VotingDialog for Set of players.  
    //         VotingDialog:Dequeue(playerSet) -> dequeues VotingDialog for Set of players.  
    //         MultiOptionDialog.callback is not to be used by end-user, it is used by VotingDialog to count votes!  

    function interface VotingDoneCallback takes Table selectedOptions returns nothing //table<MultiOptionDialogButtonOption[]> 

    globals 
        private Table playersVotes //table<VotingDialog, VotingResult> 
    endglobals 

    struct VotingResult 
        public force players 
        public Table buttonOptionCounts // table<MultiOptionDialogButton, table<MultiOptionDialogButtonOption, integer>> 
    endstruct 

    private function functionVotingFinish takes VotingDialog thisDialog returns nothing 
        local Table selectedOptions = Table.create() 
        local VotingResult votes = playersVotes[thisDialog] 
        local Table buttonOptionCountKeys = votes.buttonOptionCounts 
        local integer i = buttonOptionCountKeys[0] 
        local integer j 
        local MultiOptionDialogButtonOption votingOption 
        local Table optionCountPairs 
        local Table optionCountPairsKeys 
        local MultiOptionDialogButtonOption votedOption 
        local integer votedOptionCount 
        local MultiOptionDialogButtonOption maxVotedOption 
        local integer maxVotedOptionVoteCount 

        loop 
            exitwhen i == 0 
            set votingOption = buttonOptionCountKeys[i] 
            set optionCountPairs = votes.buttonOptionCounts[votingOption] 
            set optionCountPairsKeys = optionCountPairs.getKeys() 

            set maxVotedOption = 0 
            set maxVotedOptionVoteCount = 0 

            set j = optionCountPairsKeys[0] 
            loop 
                exitwhen j == 0 

                set votedOption = optionCountPairsKeys[j] 
                set votedOptionCount = optionCountPairs[votedOption] 

                if maxVotedOptionVoteCount == 0 or maxVotedOptionVoteCount < votedOptionCount then 
                    set maxVotedOption = votedOption 
                    set maxVotedOptionVoteCount = votedOptionCount 
                endif 

                set j = j - 1 
            endloop 

            call selectedOptions.save(selectedOptions.measureFork(), maxVotedOption) 

            set i = i - 1 
        endloop 

        call playersVotes.remove(thisDialog) 
        call thisDialog.votingDoneCallback.evaluate(selectedOptions) 
    endfunction 

    //table<MultiOptionDialogButton, MultiOptionDialogButtonOption>  
    private function processPlayerCommit takes VotingDialog thisDialog, player thisPlayer, Table buttonChosenOptionPairs returns nothing 
        local VotingResult dataStruct = playersVotes[thisDialog] 
        local Table buttonChosenOptionPairKeys = buttonChosenOptionPairs.getKeys() 
        local integer i = buttonChosenOptionPairKeys[0] 
        local MultiOptionDialogButton thisButton 
        local MultiOptionDialogButtonOption thisOption 
        local Table optionCounts 

        call ForceRemovePlayer(dataStruct.players, thisPlayer) 

        loop 
            exitwhen i == 0 

            set thisButton = buttonChosenOptionPairKeys[i] 
            set thisOption = buttonChosenOptionPairs[thisButton] 


            if dataStruct.buttonOptionCounts[thisButton] == 0 then 
                set optionCounts = Table.create() 
                call optionCounts.save(thisOption, 1) 
                call dataStruct.buttonOptionCounts.save(thisButton, optionCounts) 
            else 
                call dataStruct.buttonOptionCounts[thisButton].save(thisOption, dataStruct.buttonOptionCounts[thisButton] [thisOption] + 1) 
            endif 

            set i = i - 1 
        endloop 

        if CountPlayersInForceBJ(dataStruct.players) == 0 then 
            call functionVotingFinish(thisDialog) 
        endif 
    endfunction 

    struct VotingDialog extends MultiOptionDialog 
        public VotingDoneCallback votingDoneCallback 

        static method create takes nothing returns thistype 
            return thistype.allocate() 
        endmethod 
    endstruct 

    public function Enqueue takes VotingDialog thisDialog, force players returns boolean 
        local VotingResult dataStruct 
        if playersVotes.has(thisDialog) then 
            // Already queued up! 
            return false 
        endif 

        set dataStruct = VotingResult.create() 
        set dataStruct.players = players 
        set dataStruct.buttonOptionCounts = Table.create() 

        call playersVotes.save(thisDialog, dataStruct) 
        set thisDialog.callback = processPlayerCommit 
        call MultiOptionDialog_Enqueue(thisDialog, players) 
        return true 
    endfunction
    
    public function Dequeue takes VotingDialog thisDialog, force players returns boolean 
        local VotingResult dataStruct 
        local integer pid 
        if not playersVotes.has(thisDialog) then 
            // Not queued up!  
            return false 
        endif 

        set dataStruct = playersVotes[thisDialog] 
        set pid = 0 
        loop 
            exitwhen pid >= GetBJMaxPlayers() 
            if IsPlayerInForce(Player(pid), dataStruct.players) and IsPlayerInForce(Player(pid), players) then 
                call ForceRemovePlayer(dataStruct.players, Player(pid)) 
            endif 
            set pid = pid + 1 
        endloop 
            
        if CountPlayersInForceBJ(dataStruct.players) == 0 then 
            call functionVotingFinish(thisDialog) 
        endif 

        call MultiOptionDialog_Dequeue(thisDialog, players) 
        return true 
    endfunction

endlibrary