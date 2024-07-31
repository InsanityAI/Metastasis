library ChatService initializer init requires Clock, ChatGroups, ChatProfiles 
    globals 
        private constant string privateMessageFromPrefix = "[From " 
        private constant string privateMessageToPrefix = "[To " 
        private constant string privateMessageSuffix = "]:" 

        private Table chatListeners //table<ChatServiceListener, 1>
        private Table chatUIListeners //table<ChatServiceUIListener, 1>
    endglobals 
    
    interface ChatServiceUIListener
        method newMessage takes string timestamp, ChatProfile from, string message, string messageType returns nothing
    endinterface

    interface ChatServiceListener
        method newMessageForProfile takes string timestamp, ChatProfile from, ChatProfile to, string message returns nothing
        method newMessageForGroup takes string timestamp, ChatProfile from, ChatGroup to, string message returns nothing
    endinterface

    private function showMessageForLocalPlayer takes string timestamp, ChatProfile from, string messageType, string message returns nothing
        local Table listeners = chatUIListeners.getKeys() 
        local ChatServiceUIListener listener
        local integer i = listeners[0] 
        loop 
            exitwhen i == 0 
            set listener = listeners[i]
            call listener.newMessage(timestamp, from, message, messageType) 
            set i = i - 1 
        endloop 
    endfunction

    private function notifyListenersPrivate takes string timestamp, ChatProfile from, ChatProfile receiver, string message returns nothing 
        local Table listeners = chatListeners.getKeys() 
        local ChatServiceListener listener
        local integer i = listeners[0] 
        loop 
            exitwhen i == 0 
            set listener = listeners[i]
            call listener.newMessageForProfile(timestamp, from, receiver, message) 
            set i = i - 1 
        endloop 
    endfunction 

    private function notifyListenersGroup takes string timestamp, ChatProfile from, ChatGroup receiver, string message returns nothing 
        local Table listeners = chatListeners.getKeys() 
        local ChatServiceListener listener
        local integer i = listeners[0] 
        loop 
            exitwhen i == 0 
            set listener = listeners[i]
            call listener.newMessageForGroup(timestamp, from, receiver, message) 
            set i = i - 1 
        endloop 
    endfunction 

    private function constructPrivateMessageType takes string name, boolean from returns string 
        if from then 
            return privateMessageFromPrefix + name + privateMessageSuffix 
        else 
            return privateMessageToPrefix + name + privateMessageSuffix 
        endif 
    endfunction 

    public function sendMessageToPlayer takes ChatProfile from, string message, ChatProfile recepient returns nothing 
        local player localPlayer = GetLocalPlayer()

        call notifyListenersPrivate(Clock_formattedTime, from, recepient, message) 
        if localPlayer == recepient.chatPlayer then
            call showMessageForLocalPlayer(Clock_formattedTime, from, constructPrivateMessageType(from.name, true), message) 
        endif
        if localPlayer == from.chatPlayer then 
            call showMessageForLocalPlayer(Clock_formattedTime, from, constructPrivateMessageType(recepient.name, false), message) 
        endif 

        set localPlayer = null
    endfunction

    public function sendMessageToGroup takes ChatProfile from, string message, ChatGroup recepientGroup returns nothing 
        local Table members = recepientGroup.members.getKeys() 
        local player localPlayer = GetLocalPlayer()
        local ChatProfile profile
        local integer i = members[0] 
        local boolean showToLocal = recepientGroup.contains(from) and from.chatPlayer == localPlayer
        call notifyListenersGroup(Clock_formattedTime, from, recepientGroup, message) 
        loop 
            exitwhen i == 0 
            exitwhen showToLocal
            set profile = members[i]
            set showToLocal = showToLocal or localPlayer == profile.chatPlayer
            set i = i - 1 
        endloop 
        
        if showToLocal then
            call showMessageForLocalPlayer(Clock_formattedTime, from, recepientGroup.name, message)
        endif

        set localPlayer = null
    endfunction 

    public function registerUIListener takes ChatServiceUIListener listener returns nothing 
        call chatUIListeners.save(listener, 1)
    endfunction 

    public function unregisterUIListener takes ChatServiceUIListener listener returns nothing 
        call chatUIListeners.remove(listener)
    endfunction 

    public function registerListener takes ChatServiceListener listener returns nothing 
        call chatListeners.save(listener, 1)
    endfunction 

    public function unregisterListener takes ChatServiceListener listener returns nothing 
        call chatListeners.remove(listener)
    endfunction 

    private function init takes nothing returns nothing
        set chatListeners = Table.create()
        set chatUIListeners = Table.create()
    endfunction

endlibrary