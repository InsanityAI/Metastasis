library ChatLogUI initializer init requires Timeout, Table
    globals 
        //Frame position(scales with resolution)                                                 
        private string CHAT_FONT = "Fonts\\FRIZQT__.TTF" //font used by messages(default wc3 chat font is "Fonts\\BLQ55Web.ttf")                           
        private real FONT_SIZE = 0.012 //font size of messages            
        private real MESSAGE_MARGIN = 0.005 
        private integer MAX_MESSAGES = 1000 

        private constant string privateMessageFromPrefix = "From " 
        private constant string privateMessageToPrefix = "To " 
        private constant string allMessagesTypePrefix = "[" 
        private constant string allMessagesTypeSuffix = "]" 

        private Table framesUsed //table<MessageFrame, 1>  
        private Table framesUnused //table<MessageFrame, 1>  
        private framehandle logMessagesFrame
    endglobals 

    private struct MessageFrame 
        readonly framehandle frameMessage 
        readonly framehandle frameMessageTimeStampContainer 
        readonly framehandle frameMessageTimeStamp 
        readonly framehandle frameMessageTypeContainer 
        readonly framehandle frameMessageType 
        readonly framehandle frameMessageIconContainer 
        readonly framehandle frameMessageIcon 
        readonly framehandle frameMessageTextContainer 
        readonly framehandle frameMessageText 

        readonly MessageFrame relativeFrame 

        static method create takes integer createContext returns thistype 
            local thistype this = thistype.allocate() 
            set this.frameMessage = BlzCreateSimpleFrame("Message", logMessagesFrame, createContext) 
            set this.frameMessageTimeStampContainer = BlzGetFrameByName("Message Timestamp Container", createContext) 
            set this.frameMessageTimeStamp = BlzGetFrameByName("Message Timestamp", createContext) 
            set this.frameMessageTypeContainer = BlzGetFrameByName("Message Type Container", createContext) 
            set this.frameMessageType = BlzGetFrameByName("Message Type", createContext) 
            set this.frameMessageIconContainer = BlzGetFrameByName("Message Icon Container", createContext) 
            set this.frameMessageIcon = BlzGetFrameByName("Message Icon", createContext) 
            set this.frameMessageTextContainer = BlzGetFrameByName("Message Text Container", createContext) 
            set this.frameMessageText = BlzGetFrameByName("Message Text", createContext) 

            call BlzFrameSetAlpha(this.frameMessage, 0) 
            call BlzFrameSetSize(this.frameMessage, 0.8, FONT_SIZE + MESSAGE_MARGIN) 

            call BlzFrameSetSize(this.frameMessageTimeStampContainer, 0.045, FONT_SIZE + MESSAGE_MARGIN) 
            call BlzFrameSetSize(this.frameMessageTimeStamp, 0.045, FONT_SIZE + MESSAGE_MARGIN) 
            call BlzFrameSetFont(this.frameMessageTimeStamp, CHAT_FONT, FONT_SIZE, 0) 
            
            call BlzFrameSetSize(this.frameMessageTypeContainer, 0.045, FONT_SIZE + MESSAGE_MARGIN) 
            call BlzFrameSetSize(this.frameMessageType, 0.045, FONT_SIZE + MESSAGE_MARGIN) 
            call BlzFrameSetFont(this.frameMessageType, CHAT_FONT, FONT_SIZE, 0) 
            call BlzFrameSetPoint(this.frameMessageType, FRAMEPOINT_LEFT, this.frameMessageTypeContainer, FRAMEPOINT_LEFT, 0, 0) 

            call BlzFrameSetSize(this.frameMessageIconContainer, FONT_SIZE + MESSAGE_MARGIN, FONT_SIZE + MESSAGE_MARGIN) 

            call BlzFrameSetSize(this.frameMessageTextContainer, 0.675, FONT_SIZE + MESSAGE_MARGIN) 
            call BlzFrameSetSize(this.frameMessageText, 0.675, FONT_SIZE + MESSAGE_MARGIN) 
            call BlzFrameSetFont(this.frameMessageText, CHAT_FONT, FONT_SIZE, 0) 

            return this 
        endmethod 

        public method setContent takes string timestamp, string msgType, string text, string icon, string privatePrefix returns nothing 
            local real msgTypeWidth 
            if SubString(msgType, 0, 2) == "|c" then 
                set msgTypeWidth = StringWidth_getTextMultiboardWidth(SubString(msgType, 10, StringLength(msgType) -2), 0) 
            else 
                set msgTypeWidth = StringWidth_getTextMultiboardWidth(msgType, 0) 
            endif 

            if privatePrefix != null then 
                set msgTypeWidth = msgTypeWidth + StringWidth_getTextMultiboardWidth(privatePrefix, 0) 
                set msgType = privatePrefix + msgType 
            endif 

            call BlzFrameSetText(this.frameMessageTimeStamp, timestamp) 
            //Not a perfect solution but it will do for now!
            call BlzFrameSetSize(this.frameMessageTypeContainer, msgTypeWidth * 1.05 + 0.007, BlzFrameGetHeight(this.frameMessageType)) 
            call BlzFrameSetText(this.frameMessageType, allMessagesTypePrefix + msgType + allMessagesTypeSuffix) 
            call BlzFrameSetText(this.frameMessageText, text) 

            if icon != null and icon != "" then 
                call BlzFrameSetTexture(this.frameMessageIcon, icon, 0, true) 
                call BlzFrameSetVisible(this.frameMessageIconContainer, true) 
                call BlzFrameSetPoint(this.frameMessageTextContainer, FRAMEPOINT_LEFT, this.frameMessageIconContainer, FRAMEPOINT_RIGHT, 0.003, 0.) 
            else 
                call BlzFrameSetVisible(this.frameMessageIconContainer, false) 
                call BlzFrameSetPoint(this.frameMessageTextContainer, FRAMEPOINT_LEFT, this.frameMessageTimeStampContainer, FRAMEPOINT_RIGHT, 0.003, 0.) 
            endif 
        endmethod 

        public method setVisibility takes boolean show returns nothing 
            call BlzFrameSetVisible(this.frameMessage, show) 
        endmethod 

        public method moveUpFor takes MessageFrame frame returns nothing 
            set this.relativeFrame = frame 
            if frame != 0 then 
                call BlzFrameClearAllPoints(this.frameMessage) 
                call BlzFrameSetPoint(this.frameMessage, FRAMEPOINT_BOTTOMLEFT, frame.frameMessage, FRAMEPOINT_TOPLEFT, 0, 0) 
            else 
                call BlzFrameSetPoint(this.frameMessage, FRAMEPOINT_BOTTOMLEFT, logMessagesFrame, FRAMEPOINT_BOTTOMLEFT, 0, 0) 
            endif 
        endmethod 
    endstruct 

    globals 
        private MessageFrame newestFrame = 0 
        private MessageFrame oldestFrame = 0 
    endglobals 

    private function deallocateMessageFrame takes MessageFrame frame returns nothing 
        call frame.setVisibility(false) 
        call framesUsed.remove(frame) 
        call framesUnused.save(frame, 1) 
        if newestFrame == frame then 
            set newestFrame = 0 
        endif 
        if oldestFrame == frame then 
            set oldestFrame = oldestFrame.relativeFrame 
        endif 
    endfunction 

    private function allocateNewMessageFrame takes nothing returns MessageFrame 
        local Table availableFrameKeys = framesUnused.getKeys() 
        local integer frameCount = availableFrameKeys[0] 
        local MessageFrame frame 
        if frameCount > 0 then 
            set frame = availableFrameKeys[frameCount] 
        else 
            set frame = oldestFrame 
            call deallocateMessageFrame(oldestFrame) 
        endif 
        call framesUnused.remove(frame) 
        call framesUsed.save(frame, 1) 
        call frame.setVisibility(true) 
        set newestFrame = frame 
        if oldestFrame == 0 then 
            set oldestFrame = frame 
        endif 
        return frame 
    endfunction 

    private function showNewMessage takes string timestamp, ChatProfile from, string message, string messageType returns nothing 
        local MessageFrame previousFrame = newestFrame 
        local MessageFrame newMessageFrame = allocateNewMessageFrame() 

        if from.name != null then 
            set message = from.name + "|r:" + message 
        endif 
    
        call newMessageFrame.setContent(timestamp, messageType, message, from.icon, null) 
        if previousFrame != 0 then 
            call previousFrame.moveUpFor(newMessageFrame) 
        endif 
    endfunction 

    private function showNewPrivateMessage takes string timestamp, ChatProfile contact, string message, boolean isFrom returns nothing 
        local MessageFrame previousFrame = newestFrame 
        local MessageFrame newMessageFrame = allocateNewMessageFrame() 
        local string pmPrefix 

        if isFrom then 
            set pmPrefix = privateMessageFromPrefix 
        else 
            set pmPrefix = privateMessageToPrefix 
        endif 

        call newMessageFrame.setContent(timestamp, contact.name, message, contact.icon, pmPrefix) 
        if previousFrame != 0 then 
            call previousFrame.moveUpFor(newMessageFrame) 
        endif 
    endfunction 

    //Libraries cannot extend interfaces.... 
    public struct ChatLogUIProxy extends ChatServiceUIListener //Singleton 
        private static ChatLogUIProxy instance = 0 

        public static method get takes nothing returns thistype 
            if thistype.instance == 0 then 
                set thistype.instance = thistype.allocate() 
            endif 
            return thistype.instance 
        endmethod 

        public method newMessage takes string timestamp, ChatProfile from, string message, string messageType returns nothing 
            call showNewMessage(timestamp, from, message, messageType) 
        endmethod 

        public method newPrivateMessage takes string timestamp, ChatProfile contact, string message, boolean isFrom returns nothing 
            call showNewPrivateMessage(timestamp, contact, message, isFrom) 
        endmethod 
    endstruct 

    private function HideFrame takes framehandle frame returns nothing 
        call BlzFrameSetVisible(frame, false) 
    endfunction 

    private function safe_get_frame takes string name, integer pos returns framehandle 
        local framehandle frame = BlzGetFrameByName(name, pos) 
        if frame == null then 
            call Location(0, 0) //Intentionally leak a handle because someone does not have this frame         
            //This should help prevent desyncs and replay errors         
        endif 
        return frame 
    endfunction 

    private function initStart2 takes nothing returns nothing
        local integer i = MAX_MESSAGES/2
        loop 
            exitwhen i >= MAX_MESSAGES
            call deallocateMessageFrame(MessageFrame.create(i)) 
            set i = i + 1 
        endloop
    endfunction

    private function initStart takes nothing returns nothing
        local framehandle chatTitleFrame = safe_get_frame("ChatTitle", 0)
        local framehandle chatFrame = safe_get_frame("ChatDialog", 0)
        local framehandle frame
        local integer i = 0 
        call Timeout.complete()

        call HideFrame(safe_get_frame("ChatPlayerMenu", 0)) 
        call HideFrame(safe_get_frame("ChatPlayerLabel", 0)) 
        call HideFrame(safe_get_frame("ChatPlayerRadioButton", 0)) 
        call HideFrame(safe_get_frame("ChatAlliesLabel", 0)) 
        call HideFrame(safe_get_frame("ChatAlliesRadioButton", 0)) 
        call HideFrame(safe_get_frame("ChatObserversLabel", 0)) 
        call HideFrame(safe_get_frame("ChatObserversRadioButton", 0)) 
        call HideFrame(safe_get_frame("ChatEveryoneLabel", 0)) 
        call HideFrame(safe_get_frame("ChatEveryoneRadioButton", 0)) 

        call HideFrame(safe_get_frame("ChatHistoryLabel", 0))
        call HideFrame(safe_get_frame("ChatHistoryDisplay", 0))
        call HideFrame(safe_get_frame("ChatHistoryScrollBar", 0))
        call HideFrame(safe_get_frame("ChatInfoText", 0))

        call HideFrame(safe_get_frame("LogAreaBackdrop", 0))
        call HideFrame(safe_get_frame("LogArea", 0))
        call HideFrame(safe_get_frame("LogAreaScrollBar", 0))

        call BlzLoadTOCFile("UI\\ChatSystem.toc")      
        
        loop 
            exitwhen i >= MAX_MESSAGES/2
            call deallocateMessageFrame(MessageFrame.create(i)) 
            set i = i + 1 
        endloop 

        set logMessagesFrame = safe_get_frame("ChatHistoryDisplayBackdrop", 0)
        call BlzFrameClearAllPoints(logMessagesFrame)
        call BlzFrameSetPoint(logMessagesFrame, FRAMEPOINT_LEFT, chatFrame, FRAMEPOINT_LEFT, 0.03, 0)
        call BlzFrameSetPoint(logMessagesFrame, FRAMEPOINT_RIGHT, chatFrame, FRAMEPOINT_RIGHT, -0.03, 0)
        call BlzFrameSetPoint(logMessagesFrame, FRAMEPOINT_TOP, chatFrame, FRAMEPOINT_TOP, 0, -0.05)
        call BlzFrameSetPoint(logMessagesFrame, FRAMEPOINT_BOTTOM, chatFrame, FRAMEPOINT_BOTTOM, 0, 0.07)
        call Timeout.start(0.01, false, function initStart2)

        set frame = BlzCreateFrameByType("TEXT", "", chatFrame, "", 0) 
        call BlzFrameSetPoint(frame, FRAMEPOINT_CENTER, chatFrame, FRAMEPOINT_CENTER, 0.00, 0.00) 
        call BlzFrameSetText(frame, "You tried") 
        call BlzFrameSetTextAlignment(frame, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetSize(frame, 0.10, 0.05) 
        call BlzFrameSetScale(frame, 4) 
    endfunction

    private function init takes nothing returns nothing
        set framesUsed = Table.create() 
        set framesUnused = Table.create() 
        call Timeout.start(0.00, false, function initStart)
    endfunction

endlibrary