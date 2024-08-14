library DialogQueue initializer init requires Table, LinkedList 
    // DialogQueue v1.1 by Insanity_AI   
    // ------------------------------------------------------------------------------   
    // A system that fixes WC3's default dialog behavior by hijacking Dialog natives:   
    // - Calling DialogDisplay on a new dialog when another dialog is currently being displayed   
    // will no longer hide the currently displayed dialog to show the new dialog, but will wait   
    // for the old dialog to be clicked (or hidden) before showing the new dialog.   
    
    // Calling DialogClear on dialogs being currently shown will not just wipe all its content   
    // and keep displaying a blank dialog to player, but will hide the dialog as well.   

    // Additionally:   
    // - Calling DialogDisplay or DialogDestroy on a dialog that is queued up will remove it from the queue, as it is blank.   
    // - Will always execute dialog events first, and then dialog button events.   
    // - Can be used without native override, and with callback functions instead of triggers.   

    // DialogWrapper API:   
    // DialogWrapper.create(data?) -> creates a new dialog object to be used for this system.   
    // -> data can be an existing DialogWrapper object to make another copy of.   
    // DialogWrapper.triggers      - array of triggers to be executed when dialog is clicked. (not nillable, must be at least empty table.)   
    // DialogWrapper.callback      - callback function for when dialog has been clicked.   
    // DialogWrapper.messageText   - Title text for dialog. (nillable)   
    // DialogWrapper.buttons       - array of DialogButtonWrapper objects (not nillable, must be at least empty table.)   
    // DialogWrapper.quitButton    - single DialogQuitButtonWrapper object (nillable)   

    // DialogButtonWrapper API:   
    // DialogButtonWrapper.create(data)    -> creates a new DialogButtonWrapper   
    // -> data is an existing DialogButtonWrapper object to make another copy of.   
    // DialogButtonWrapper.text        - button's text (nillable)   
    // DialogButtonWrapper.hotkey      - button's hotkey (must be either integer or nillable)   
    // DialogButtonWrapper.triggers    - array of triggers to be executed when the button is clicked. (not nillable, must be at least empty table)   
    // DialogButtonWrapper.callback    - callback function for when dialog button has been clicked.   

    // DialogQuitButtonWrapper API: (extension of DialogButtonWrapper)   
    // DialogQuitButtonWrapper.create(data)    -> creates a new DialogQuitButtonWrapper   
    // -> data is an existing DialogQuitButtonWrapper object to make another copy of.   
    // DialogQuitButtonWrapper.doScoreScreen - must be true or false (not nillable)   

    // DialogQueue API:   
    // DialogQueue.Enqueue(dialogWrapper, player) -> queues up a dialog for the player   
    // DialogQueue.EnqueueAfterCurrentDialog(dialogWrapper, player) -> queues up a dialog right after the current dialog that is being displayed right now.   
    // DialogQueue.Dequeue(dialogWrapper, player) -> dequeues a dialog for the player   
    // DialogQueue.SkipCurrentDialog -> skips currently displayed dialog.   

    // Functionality:   
    // - Creates a single dialog for each player in the game, all registered to the same trigger that processes dialog clicks   
    // and passes them to respective triggers/callback functions. These WC3 dialogs are never removed but rather cleared and   
    // set with different buttons and messages.   
    // - Creates a single queue for each player designated to store DialogWrappers and show them sequentially in the queue order.   
    // - When a player presses a dialog button, the currently displayed dialog is removed from that player's queue and the system   
    // will show the next queued dialog, if there is any.   
    // - Queueing up a dialog when there are no dialogs in the queue will immediately display it to the player.   
    // - If the dialog has no buttons defined, the dialog will be skipped just before being displayed.   

    function interface DialogCallback takes Dialog thisDialog, player thisPlayer returns nothing 
    function interface DialogButtonCallback takes DialogButton dialogButton, Dialog thisDialog, player thisPlayer returns nothing 

    public function interface skipDialog takes player thisPlayer returns nothing
    globals 
        private Table playerQueueActive //table<player, boolean>                 
        private Table dialogQueues //table<player, DialogQueueLL<Dialog>>                 
        private Table playerDialog //table<player, dialog>                 
        private Table currentDialogButtons //table<player, table<button, DialogButton>>                 
    endglobals 

    private struct DialogQueueLL 
        public Dialog value 
        implement InstantiatedListEx 
    endstruct 

    function displayNextDialog takes player thisPlayer returns nothing 
        local DialogQueueLL playerQueue 
        local dialog thisDialog 
        local Dialog dialogDefinition 
        local Table dialogButtons 
        local Table iterationKeys 
        local integer i 
        local DialogButton buttonDefinition 
        local button thisButton 
        local skipDialog skipCurrentDialog = skipDialog.DialogQueue_SkipCurrentDialog
        if playerQueueActive.stores(thisPlayer) then 
            return //is active                 
        endif 

        set playerQueue = dialogQueues.get(thisPlayer) 
        if playerQueue.getSize() <= 0 then 
            return // empty, nothing to show                 
        endif 

        call playerQueueActive.boolean.store(thisPlayer, true) 

        set thisDialog = playerDialog.dialog.get(thisPlayer) 
        set dialogDefinition = playerQueue.popFront() 

        call DialogDisplay(thisPlayer, thisDialog, false) 
        call DialogClear(thisDialog) 
        if dialogDefinition.messageText != null then 
            call DialogSetMessage(thisDialog, dialogDefinition.messageText) 
        endif 

        if currentDialogButtons.stores(thisPlayer) then 
            set dialogButtons = currentDialogButtons.get(thisPlayer) 
            call dialogButtons.destroy() 
        endif 
        set dialogButtons = Table.create() 
        call currentDialogButtons.store(thisPlayer, dialogButtons) 
        if dialogDefinition.getButtons() [0] == 0 and dialogDefinition.quitButton == 0 then 
            // dialog has no buttons, skip and show next dialog                 
            call skipCurrentDialog.evaluate(thisPlayer) 
            call playerQueueActive.boolean.store(thisPlayer, false) 
            call displayNextDialog(thisPlayer) 

            set thisDialog = null 
            return 
        endif 

        set iterationKeys = dialogDefinition.getButtons() 
        set i = iterationKeys[0] 
        loop 
            exitwhen i == 0 
            set buttonDefinition = iterationKeys[i] 
            set thisButton = DialogAddButton(thisDialog, buttonDefinition.text, buttonDefinition.hotkey) 
            call dialogButtons.store(thisButton, buttonDefinition) 
            set i = i - 1 
        endloop 

        if dialogDefinition.quitButton != 0 then 
            set thisButton = DialogAddQuitButton(thisDialog, dialogDefinition.quitButton.doScoreScreen, dialogDefinition.quitButton.text, dialogDefinition.quitButton.hotkey) 
            call dialogButtons.store(thisButton, dialogDefinition.quitButton) 
        endif 

        call DialogDisplay(thisPlayer, thisDialog, true) 

        set thisDialog = null 
        set thisButton = null 
    endfunction 

    public function SkipCurrentDialog takes player thisPlayer returns nothing 
        local DialogQueueLL playerQueue = dialogQueues.get(thisPlayer) 
        call playerQueueActive.forget(thisPlayer) 
        call playerQueue.popFront() 
        call displayNextDialog(thisPlayer) 
    endfunction 

    struct DialogButton 
        public string text 
        public integer hotkey 
        private Table triggers //table<trigger, true>                 
        public DialogButtonCallback callback 

        static method create takes nothing returns thistype 
            local thistype this = thistype.allocate() 
            set this.triggers = Table.create() 
            return this 
        endmethod 

        public method addTrigger takes trigger t returns nothing 
            call this.triggers.boolean.store(t, true) 
        endmethod 

        public method removeTrigger takes trigger t returns nothing 
            call this.triggers.forget(t) 
        endmethod 

        public method getTriggers takes nothing returns Table 
            return this.triggers.getKeys() 
        endmethod 
    endstruct 

    struct DialogQuitButton extends DialogButton 
        public boolean doScoreScreen 

        static method create takes nothing returns thistype 
            return thistype.allocate() 
        endmethod 
    endstruct 

    struct Dialog 
        private Table triggers //table<trigger, true>                 
        public DialogCallback callback 
        public string messageText 
        public Table buttons //table<DialogButton, true>                 
        public DialogQuitButton quitButton 

        static method create takes nothing returns thistype 
            local thistype this = thistype.allocate() 
            set this.triggers = Table.create() 
            set this.buttons = Table.create() 
            return this 
        endmethod 

        public method addTrigger takes trigger t returns nothing 
            call this.triggers.boolean.store(t, true) 
        endmethod 

        public method removeTrigger takes trigger t returns nothing 
            call this.triggers.forget(t) 
        endmethod 

        public method getTriggers takes nothing returns Table 
            return this.triggers.getKeys() 
        endmethod 

        public method addButton takes DialogButton db returns nothing 
            call this.buttons.boolean.save(db, true) 
        endmethod 

        public method removeButton takes DialogButton db returns nothing 
            call this.buttons.remove(db) 
        endmethod 

        public method getButtons takes nothing returns Table 
            return this.buttons.getKeys() 
        endmethod 
    endstruct 

    public function Enqueue takes Dialog thisDialog, player thisPlayer returns nothing 
        local DialogQueueLL playerQueue = dialogQueues.get(thisPlayer) 
        call playerQueue.pushBack(thisDialog) 
    endfunction 

    public function EnqueueAfterCurrentDialog takes Dialog thisDialog, player thisPlayer returns nothing 
        local DialogQueueLL playerQueue = dialogQueues.get(thisPlayer) 
        local Dialog currentDialog = playerQueue.popFront() 
        call playerQueue.pushFront(thisDialog) 
        call playerQueue.pushFront(currentDialog) 
    endfunction 

    public function Dequeue takes Dialog thisDialog, player thisPlayer returns nothing 
        local DialogQueueLL playerQueue = dialogQueues.get(thisPlayer) 
        local Dialog currentDialog 
        local DialogQueueLL node 
        if playerQueue.getSize() <= 0 then 
            return 
        endif 

        // is currently displayed dialog being dequeued? 
        set currentDialog = playerQueue.popFront() 
        call playerQueue.pushFront(currentDialog) 
        if currentDialog == thisDialog then 
            call SkipCurrentDialog(thisPlayer) 
            return 
        endif 

        set node = playerQueue.next 
        loop 
            exitwhen node == 0 
            if node.value == thisDialog then 
                call DialogQueueLL.remove(node) 
                exitwhen true 
            endif 
            set node = node.next 
        endloop 
    endfunction 

    globals 
        public Dialog ClickedDialog 
        public DialogButton ClickedButton 
        public player ClickingPlayer 
    endglobals 

    private function callTriggers takes Table triggers returns nothing 
        local integer i = triggers[0] 
        local trigger thisTrigger 

        loop 
            exitwhen i == 0 
            set thisTrigger = triggers.trigger[i] 
            if TriggerEvaluate(thisTrigger) then 
                call TriggerExecute(thisTrigger) 
            endif 
            set i = i - 1 
        endloop 

        set thisTrigger = null 
    endfunction 

    private function callTriggersWithResponses takes player triggerPlayer, Dialog thisDialog, DialogButton thisButton returns nothing 
        set ClickedDialog = thisDialog 
        set ClickedButton = thisButton 
        set ClickingPlayer = triggerPlayer 

        call callTriggers(thisDialog.getTriggers()) 
        call callTriggers(thisButton.getTriggers()) 
    endfunction 

    globals 
        private trigger dialogTrigger 
    endglobals 

    private function dialogClicked takes nothing returns nothing 
        local player thisPlayer = GetTriggerPlayer() 
        local DialogQueueLL playerQueue = dialogQueues.get(thisPlayer) 
        local Dialog dialogDefinition = playerQueue.popFront() 
        local button thisButton = GetClickedButton() 
        local Table playerDialogButtons = currentDialogButtons.get(thisPlayer) 
        local DialogButton buttonDefinition = playerDialogButtons.get(thisButton) 
        local DialogCallback dialogCallback
        local DialogButtonCallback buttonCallback

        call callTriggersWithResponses(thisPlayer, dialogDefinition, buttonDefinition) 
        
        if dialogDefinition.callback != null then
            set dialogCallback = dialogDefinition.callback 
            call dialogCallback.evaluate(dialogDefinition, thisPlayer) 
        endif 
        if buttonDefinition.callback != null then 
            set buttonCallback = buttonDefinition.callback
            call buttonCallback.evaluate(buttonDefinition, dialogDefinition, thisPlayer) 
        endif 

        call playerQueueActive.forget(thisPlayer) 
        call displayNextDialog(thisPlayer) 

        set thisPlayer = null 
        set thisButton = null 
    endfunction 

    private function initForPlayer takes nothing returns nothing 
        local player thisPlayer = GetEnumPlayer() 
        local dialog thisDialog = DialogCreate() 
        call playerDialog.dialog.store(thisPlayer, thisDialog) 
        call dialogQueues.store(thisPlayer, DialogQueueLL.create()) 
        call TriggerRegisterDialogEvent(dialogTrigger, thisDialog) 
        set thisPlayer = null 
    endfunction 

    private function init takes nothing returns nothing 
        set dialogTrigger = CreateTrigger() 
        call ForForce(GetPlayersAll(), function initForPlayer) 
        call TriggerAddCondition(dialogTrigger, Condition(function dialogClicked)) 
    endfunction 
endlibrary