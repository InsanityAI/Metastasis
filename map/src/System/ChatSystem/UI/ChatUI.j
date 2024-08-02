library ChatUI initializer init requires Table, Timeout, StringWidth 
    globals 
        //Frame position(scales with resolution)                           
        private framepointtype CHAT_REFPOINT = FRAMEPOINT_BOTTOMLEFT //from which point of screen the X and Y calculate                           
        private real CHAT_X = 0.0222 
        private real CHAT_Y = 0.2200 //0.2106  
        private string CHAT_FONT = "Fonts\\FRIZQT__.TTF" //font used by messages(default wc3 chat font is "Fonts\\BLQ55Web.ttf")                           
        private real FONT_SIZE = 0.012 //font size of messages            
        private real MESSAGE_MARGIN = 0.005 
        private integer MAX_MESSAGES = 50 

        private constant string privateMessageFromPrefix = "From " 
        private constant string privateMessageToPrefix = "To " 
        private constant string allMessagesTypePrefix = "[" 
        private constant string allMessagesTypeSuffix = "]" 

        private integer MESSAGE_DURATION = 500 //Message disappears after X ms                           
        private integer MESSAGE_ANIMATE_UP = 20 //Message appears over X ms  

        //Cannot use Timeout because of handlecount manipulation     
        private timer renderingTimer 
        private boolean timerPaused = true 
        private Table framesUsed //table<MessageFrame, 1>  
        private Table framesUnused //table<MessageFrame, 1>  
        private framehandle frameMain 
        private framehandle frameMessagePanel 
    endglobals 

    private function easeInOutSine takes real t returns real 
        return - (Cos(bj_PI * t) -1.) / 2. 
    endfunction 

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
        public integer alpha 
        public integer duration 
        public integer moveUpDuration 

        static method create takes integer createContext returns thistype 
            local thistype this = thistype.allocate() 
            set this.frameMessage = BlzCreateSimpleFrame("Message", frameMessagePanel, createContext) 
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
            if not show then 
                call BlzFrameSetAlpha(this.frameMessage, 0) 
                set this.alpha = 0 
            endif 
        endmethod 

        public method changeAlpha takes integer alpha returns nothing 
            set this.alpha = this.alpha + alpha 
            call BlzFrameSetAlpha(this.frameMessage, this.alpha) 
        endmethod 

        public method startMovingUpFor takes MessageFrame frame returns nothing 
            set this.relativeFrame = frame 
            if frame != 0 then 
                call BlzFrameClearAllPoints(this.frameMessage) 
                call BlzFrameSetPoint(this.frameMessage, FRAMEPOINT_BOTTOMLEFT, frame.frameMessage, FRAMEPOINT_TOPLEFT, 0, -FONT_SIZE) 
                set this.moveUpDuration = 0 
            else 
                set this.moveUpDuration = -1 
                call BlzFrameSetPoint(this.frameMessage, FRAMEPOINT_BOTTOMLEFT, frameMessagePanel, FRAMEPOINT_BOTTOMLEFT, 0, 0) 
            endif 
        endmethod 

        public method processMovement takes nothing returns nothing 
            if this.moveUpDuration == -1 then 
                return 
            endif 
            
            if this.moveUpDuration < 20 then 
                set this.moveUpDuration = this.moveUpDuration + 1 
                call BlzFrameSetPoint(this.frameMessage, FRAMEPOINT_BOTTOMLEFT, this.relativeFrame.frameMessage, FRAMEPOINT_TOPLEFT, 0, FONT_SIZE * (-1 + easeInOutSine(this.moveUpDuration / 20.0))) 
            else 
                call BlzFrameSetPoint(this.frameMessage, FRAMEPOINT_BOTTOMLEFT, this.relativeFrame.frameMessage, FRAMEPOINT_TOPLEFT, 0, 0) 
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
        set frame.alpha = 0 
        set frame.duration = 0 
        if newestFrame == frame then 
            set newestFrame = 0 
        endif 
        if oldestFrame == frame then 
            set oldestFrame = oldestFrame.relativeFrame 
        endif 
        call frame.startMovingUpFor(0) 
    endfunction 
    
    private function renderMessages takes nothing returns nothing 
        local Table usedFrameKeys = framesUsed.getKeys() 
        local integer i = usedFrameKeys[0] 
        local MessageFrame frame 

        if i == 0 then 
            call PauseTimer(GetExpiredTimer()) 
            set timerPaused = true 
            return 
        endif 

        loop 
            exitwhen i == 0 
            set frame = usedFrameKeys[i] 

            if frame.duration > MESSAGE_DURATION + 100 then 
                call deallocateMessageFrame(frame) 
            else 
                set frame.duration = frame.duration + 1 
                if frame.alpha >= 0 and frame.alpha < 255 and frame.duration < MESSAGE_DURATION then 
                    call frame.changeAlpha(3) 
                elseif frame.duration > MESSAGE_DURATION and frame.alpha > 0 then 
                    call frame.changeAlpha(-3) 
                endif 
                call frame.processMovement() 
            endif 

            set i = i - 1 
        endloop 
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
            call previousFrame.startMovingUpFor(newMessageFrame) 
        endif 
        

        if timerPaused then 
            call TimerStart(renderingTimer, 0.01, true, function renderMessages) 
            set timerPaused = false 
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
            call previousFrame.startMovingUpFor(newMessageFrame) 
        endif 

        if timerPaused then 
            call TimerStart(renderingTimer, 0.01, true, function renderMessages) 
            set timerPaused = false 
        endif 
    endfunction 

    private function safe_get_frame takes string name, integer pos returns framehandle 
        local framehandle frame = BlzGetFrameByName(name, pos) 
        if frame == null then 
            call Location(0, 0) //Intentionally leak a handle because someone does not have this frame         
            //This should help prevent desyncs and replay errors         
        endif 
        return frame 
    endfunction 

    private function initFinal takes nothing returns nothing 
        local integer i = 0 
        call Timeout.complete() 
        call BlzLoadTOCFile("UI\\ChatSystem.toc") 
        call BlzFrameSetVisible(BlzGetOriginFrame(ORIGIN_FRAME_CHAT_MSG, 0), false) //hides default chat         
        
        set frameMain = BlzCreateSimpleFrame("Main", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0) 
        set frameMessagePanel = safe_get_frame("Message Panel", 0) 
        
        loop 
            exitwhen i >= MAX_MESSAGES 
            call deallocateMessageFrame(MessageFrame.create(i)) 
            set i = i + 1 
        endloop 

        call BlzFrameSetAbsPoint(frameMain, FRAMEPOINT_BOTTOM, 0.4, 0.) 
        call BlzFrameSetPoint(frameMessagePanel, CHAT_REFPOINT, frameMain, CHAT_REFPOINT, CHAT_X, CHAT_Y) 
        call BlzFrameSetSize(frameMain, 0.6 * BlzGetLocalClientWidth() / BlzGetLocalClientHeight(), 0.6) 
    endfunction 

    private function init takes nothing returns nothing 
        call Timeout.start(0, false, function initFinal) 
        set renderingTimer = CreateTimer() 
        set framesUsed = Table.create() 
        set framesUnused = Table.create() 
    endfunction 

    //Libraries cannot extend interfaces.... 
    public struct ChatUIProxy extends ChatServiceUIListener //Singleton 
        private static ChatUIProxy instance = 0 

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
endlibrary