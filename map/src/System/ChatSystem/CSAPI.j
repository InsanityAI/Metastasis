library CSAPI requires ChatService, ChatProfiles
    public function systemMessage takes string message returns nothing
        call ChatService_sendMessageToGroup(ChatSystem_profileSystem, message, ChatSystem_groupSystem)
    endfunction

    public function sendSystemMessageToProfile takes ChatProfile thisPlayer, string message returns nothing
        call ChatService_sendMessageToPlayer(ChatSystem_profileSystem, message, thisPlayer)        
    endfunction

    public function sendSystemMessageToPlayer takes player thisPlayer, string message returns nothing
        call ChatService_sendMessageToPlayer(ChatSystem_profileSystem, message, ChatProfiles_getReal(thisPlayer))
    endfunction

    public function sendSystemMessageToGroup takes ChatGroup thisGroup, string message returns nothing
        call ChatService_sendMessageToGroup(ChatSystem_profileSystem, message, thisGroup)
    endfunction
endlibrary