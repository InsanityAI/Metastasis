library MultiOptionDialog requires DialogQueue, Table 
    // MultiOptionDialog v1.0 by Insanity_AI         
    // ------------------------------------------------------------------------------         
    // DialogQueue extension to handle dialogs with buttons which cycle options and commit button at the end.         
    // Each option has a previewFunc which can be called when that option is currently selected.         
    // dialog's callback function is called when the player has commited their options.         

    // Requires:         
    //     DialogQueue - [INSERT LINK HERE]         
    //     SetUtils - https://www.hiveworkshop.com/threads/set-group-datastructure.331886/         

    // Installation:         
    //     Just Plug & Play, nothing specific to be done.         
        
    // MultiOptionDialog API:         
    //     MultiOptionDialog.create(data?) -> creates a new MultiOptionDialog.         
    //                                     -> data can be an existing MultiOptionDialog object to make another copy of.         
    //     MultiOptionDialog.callback      - callback function for when MultiOptionDialog has been commited.         
    //     MultiOptionDialog.title         - Title text for dialog. (nillable)         
    //     MultiOptionDialog.buttons       - array of MultiOptionDialogButton objects (not nillable, must be at least empty table.)         
    //     MultiOptionDialog.commitButton  - DialogButtonWrapper for commit.         
    //     MultiOptionDialog:Enqueue(playerSet) -> enqueues MultiOptionDialog for Set of players.         
    //     MultiOptionDialog:Dequeue(playerSet) -> dequeues MultiOptionDialog for Set of players.         
    
    // MultiOptionDialogButton API:          
    //     MultiOptionDialogButton.create(data?)   -> data is an existing MultiOptionDialogButton object to make another copy of.         
    //     MultiOptionDialogButton.messageFormat   - format string to merge button prefix and option name.         
    //     MultiOptionDialogButton.hotkey          - button's hotkey (must be single char or nil)         
    //     MultiOptionDialogButton.options         - array of MultiOptionDialogButtonOption to cycle through on button click. (not nillable, must be at least empty table)         
    //     MultiOptionDialogButton.prefix          - button's prefix text (nillable)         
    
    // MultiOptionDialogButtonOption API:         
    //     MultiOptionDialogButtonOption.create(data?)     -> data is an existing MultiOptionDialogButtonOption object to make another copy of.         
    //     MultiOptionDialogButtonOption.previewCallback   - callback function called upon the option being cycled to by a button click.         
    //     MultiOptionDialogButtonOption.name              - option name to be displayed on button.         

    function interface MultiOptionDialogCallback takes MultiOptionDialog thisDialog, player thisPlayer, Table buttonChosenOptionPairs returns nothing //table<MultiOptionDialogButton, MultiOptionDialogButtonOption>         

    globals 
        private Table queuedDialogsForPlayers //table<MultiOptionDialog, DialogPlayerData>         
    endglobals 
    
    struct MultiOptionDialogButtonOption 
        public MultiOptionDialogButtonOptionPreviewCallback previewCallback 
        public string name 

        static method create takes nothing returns thistype 
            return thistype.allocate() 
        endmethod 
    endstruct 

    struct MultiOptionDialogButton extends DialogButton
        public Table options //MultiOptionDialogButtonOption[]         
        public string prefix 

        static method create takes nothing returns thistype 
            local thistype this = thistype.allocate() 
            set this.options = Table.create() 
            return this 
        endmethod 
    endstruct 

    function interface MultiOptionDialogButtonOptionPreviewCallback takes player thisPlayer returns nothing 


    private struct MultiDialogWrapper extends Dialog 
        //public Table buttons //table<MultiDialogButton, boolean> - preset in parent
        public MultiOptionDialog definition 
    endstruct 

    private struct MultiDialogButtonWrapper extends DialogButton 
        public MultiOptionDialogButton buttonDef
        public integer option 
    endstruct 

    private struct DialogPlayerData 
        public force players //used to be Set         
        public Table playerDialogWrappers //table<player, MultiDialogWrapper>         
    endstruct 

    private function dequeuePlayer takes MultiOptionDialog thisDialog, player thisPlayer returns nothing 
        local DialogPlayerData playerDialogData = queuedDialogsForPlayers[thisDialog] 
        call ForceRemovePlayer(playerDialogData.players, thisPlayer) 
        if CountPlayersInForceBJ(playerDialogData.players) == 0 then 
            call queuedDialogsForPlayers.remove(thisDialog) 
        endif 
    endfunction 

    private function toDialogWrapper takes MultiOptionDialog dialogDef returns Dialog 
        local Dialog dialogWrapper = Dialog.create() 
        local Table dialogDefButtonKeys = dialogDef.buttons.getKeys() 
        local integer i = dialogDefButtonKeys[0] 
        local MultiOptionDialogButton buttonDef 
        local MultiDialogButtonWrapper newButton 
        local MultiOptionDialogButtonOption optionDef 
        local Table triggers
        set dialogWrapper.messageText = dialogDef.title 

        loop 
            exitwhen i == 0 
            set buttonDef = dialogDefButtonKeys[i] 
            set newButton = DialogButton.create() 
            set optionDef = buttonDef.options[0] 

            set newButton.text = buttonDef.prefix + " " + optionDef.name 
            set newButton.hotkey = buttonDef.hotkey 
            set newButton.callback = DialogButtonCallback.cycleOption 
            set newButton.buttonDef = buttonDef 

            set i = i - 1 
        endloop 

        if dialogDef.commitButton != 0 then 
            set buttonDef = MultiOptionDialogButton.create() 
            set buttonDef.text = dialogDef.commitButton.text 
            set buttonDef.hotkey = dialogDef.commitButton.hotkey 
            set triggers = dialogDef.commitButton.getTriggers() 
            set i = triggers[0] 
            loop 
                exitwhen i == 0 
                call buttonDef.addTrigger(triggers.trigger[i]) 
                set i = i - 1 
            endloop 
            set buttonDef.callback = DialogButtonCallback.commitOptions 
            call dialogWrapper.buttons.boolean.save(buttonDef, true) 
        else 
            set buttonDef = MultiOptionDialogButton.create() 
            set buttonDef.text = "Done" 
            set buttonDef.hotkey = 0 
            set buttonDef.callback = DialogButtonCallback.commitOptions 
            call dialogWrapper.buttons.boolean.save(buttonDef, true) 
        endif 

        return dialogWrapper 
    endfunction 

    function cycleOption takes MultiDialogButtonWrapper thisButton, MultiDialogWrapper thisDialog, player thisPlayer returns nothing 
        local MultiOptionDialogButton buttonDef = thisButton.buttonDef
        local MultiOptionDialogButtonOption option 
        set thisButton.option = thisButton.option + 1 
        if thisButton.option > buttonDef.options.measureFork() then 
            set thisButton.option = 0 
        endif 
        set option = buttonDef.options[thisButton.option] 
        set thisButton.text = buttonDef.prefix + " " + option.name 
        call DialogQueue_EnqueueAfterCurrentDialog(thisDialog, thisPlayer) 
    endfunction 

    // type DialogButtonCallback         
    function commitOptions takes DialogButton dialogButton, MultiDialogWrapper thisDialog, player thisPlayer returns nothing 
        local Table selectedButtonOptions = Table.create() 
        local Table buttonEntries = thisDialog.buttons.getKeys() 
        local integer i = buttonEntries[0] 
        local MultiDialogButtonWrapper thisButton

        loop 
            exitwhen i == 0 
            set thisButton = buttonEntries[i] 
            if thisButton.buttonDef != 0 then // last button is not MultiOptionDialogButton, just a normal DialogButtonWrapper         
                call selectedButtonOptions.save(thisButton.buttonDef, thisButton.buttonDef.options[thisButton.option]) 
            endif 
            set i = i - 1 
        endloop 
        
        call thisDialog.definition.callback.evaluate(thisDialog.definition, thisPlayer, selectedButtonOptions) 
        call dequeuePlayer(thisDialog.definition, thisPlayer) 
    endfunction 

    struct MultiOptionDialog
        public MultiOptionDialogCallback callback 
        public Table buttons //table<MultiOptionDialogButton, boolean>         
        public DialogButton commitButton 
        public string title 

        static method create takes nothing returns thistype 
            local thistype this = thistype.allocate() 
            set this.buttons = Table.create() 
            return this 
        endmethod 
    endstruct 

    public function Enqueue takes MultiOptionDialog thisDialog, force players returns boolean 
        local Dialog dialogWrapper 
        local MultiDialogWrapper playerDialog 
        local DialogPlayerData playerDialogData 
        local integer pid 
        local integer i 
        local player thisPlayer 
        local Table triggers 
        local Table buttons 
        local MultiDialogButtonWrapper thisButton 
        local MultiDialogButtonWrapper newButton 
        if queuedDialogsForPlayers.has(thisDialog) then 
            return false 
        endif 

        set dialogWrapper = toDialogWrapper(thisDialog) 
        set playerDialogData = DialogPlayerData.create() 
        set playerDialogData.players = players 
        set playerDialogData.playerDialogWrappers = Table.create() 
        call queuedDialogsForPlayers.save(thisDialog, playerDialogData) 

        set pid = 0 
        loop 
            exitwhen pid >= GetBJMaxPlayers() 
            set thisPlayer = Player(pid)
            if IsPlayerInForce(thisPlayer, players) then 
                set playerDialog = MultiDialogWrapper.create() 
                set playerDialog.callback = dialogWrapper.callback 
                set playerDialog.messageText = dialogWrapper.messageText 
                set playerDialog.quitButton = dialogWrapper.quitButton 
                set playerDialog.definition = thisDialog 

                set triggers = dialogWrapper.getTriggers() 
                set i = triggers[0] 
                loop 
                    exitwhen i == 0 
                    call playerDialog.addTrigger(triggers.trigger[i]) 
                    set i = i - 1 
                endloop 
            
                set buttons = dialogWrapper.getButtons() 
                set i = buttons[0] 
                loop 
                    exitwhen i == 0 
                    set thisButton = buttons[i] 
                    set newButton = MultiDialogButtonWrapper.create() 
                    set newButton.option = 0 
                    set newButton.callback = thisButton.callback
                    set newButton.text = thisButton.text 
                    set newButton.hotkey = thisButton.hotkey 
                    set newButton.callback = thisButton.callback 
                    set newButton.buttonDef = thisButton.buttonDef 
                    set i = i - 1 
                endloop 

                call playerDialogData.playerDialogWrappers.store(thisPlayer, playerDialog) 
                call DialogQueue_Enqueue(playerDialog, thisPlayer) 
            endif 
            set pid = pid + 1 
        endloop 

        return true 
    endfunction

    public function Dequeue takes MultiOptionDialog thisDialog,  force players returns boolean 
        local DialogPlayerData dialogPlayerData 
        local integer pid
        if queuedDialogsForPlayers.has(thisDialog) then 
            return false 
        endif 
        
        set pid = 0 
        set dialogPlayerData = queuedDialogsForPlayers[thisDialog] 
        loop 
            exitwhen pid >= GetBJMaxPlayers() 
            if IsPlayerInForce(Player(pid), dialogPlayerData.players) and IsPlayerInForce(Player(pid), players) then 
                call ForceRemovePlayer(dialogPlayerData.players, Player(pid)) 
                call dequeuePlayer(thisDialog, Player(pid)) 
                call DialogQueue_Dequeue(dialogPlayerData.playerDialogWrappers.get(Player(pid)), Player(pid)) 
            endif 
        endloop 
        return true 
    endfunction

endlibrary