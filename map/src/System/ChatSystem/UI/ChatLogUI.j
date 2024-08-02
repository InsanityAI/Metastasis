library ChatLogUI initializer init requires Timeout, Table
    globals
        private trigger openLog
        private trigger openChat
    endglobals

    private function HideFrame takes framehandle frame returns nothing 
        call BlzFrameSetVisible(frame, false) 
    endfunction 

    private function initStart takes nothing returns nothing
        local framehandle upperButtonBarFrame = BlzGetFrameByName("UpperButtonBarFrame", 0)
        local framehandle chatTitleFrame = BlzGetFrameByName("ChatTitle", 0)
        call Timeout.complete()

        call HideFrame(BlzGetFrameByName("UpperButtonBarChatButton", 0))

        call HideFrame(BlzGetFrameByName("ChatPlayerMenu", 0)) 
        call HideFrame(BlzGetFrameByName("ChatPlayerLabel", 0)) 
        call HideFrame(BlzGetFrameByName("ChatPlayerRadioButton", 0)) 
        call HideFrame(BlzGetFrameByName("ChatAlliesLabel", 0)) 
        call HideFrame(BlzGetFrameByName("ChatAlliesRadioButton", 0)) 
        call HideFrame(BlzGetFrameByName("ChatObserversLabel", 0)) 
        call HideFrame(BlzGetFrameByName("ChatObserversRadioButton", 0)) 
        call HideFrame(BlzGetFrameByName("ChatEveryoneLabel", 0)) 
        call HideFrame(BlzGetFrameByName("ChatEveryoneRadioButton", 0)) 

        call HideFrame(BlzGetFrameByName("ChatHistoryLabel", 0))
        call HideFrame(BlzGetFrameByName("ChatHistoryDisplay", 0))
        call HideFrame(BlzGetFrameByName("ChatHistoryDisplayBackdrop", 0))
        call HideFrame(BlzGetFrameByName("ChatHistoryScrollBar", 0))
        call HideFrame(BlzGetFrameByName("ChatHistoryLabel", 0))
        call HideFrame(BlzGetFrameByName("ChatInfoText", 0))

        //Create 2 button frames in place of one, 1 for opening logs, other one for opening chat history
        //attach them to upperButtonBarFrame
    endfunction

    private function init takes nothing returns nothing
        // Log frame
        //LogDialog, 0
        //LogTitle, 0
        //LogAreaBackdrop, 0
        //LogArea, 0
        //LogAreaScrollBar, 0
        //LogOkButton, 0

        // Chat Log frame
        //ChatDialog, 0

        //ChatAcceptButton, 0
        set openLog = CreateTrigger()
        call BlzTriggerRegisterFrameEvent(openLog, null, FRAMEEVENT_CONTROL_CLICK)

        set openChat = CreateTrigger()
        call Timeout.start(0.00, false, function initStart)
    endfunction

endlibrary