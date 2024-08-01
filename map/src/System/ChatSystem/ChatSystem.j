library ChatSystem initializer init requires ChatService, ChatGroups, ChatProfiles, PlayerSelectedChat, ChatUI, Commands, Timeout, PlayerColor 
    globals
        private ChatProfile profileSystem
        private ChatGroup groupSystem
        public ChatGroup groupAll
        public ChatGroup groupDead
        public ChatGroup groupAliens
        public ChatGroup groupMutants

        private trigger chatTrigger
        public boolean enabled = false
        private integer array muted
    endglobals

    public function systemMessage takes string message returns nothing
        call ChatService_sendMessageToGroup(profileSystem, message, groupSystem)
    endfunction

    public function sendSystemMessageToProfile takes ChatProfile thisPlayer, string message returns nothing
        call ChatService_sendMessageToPlayer(profileSystem, message, thisPlayer)        
    endfunction

    public function sendSystemMessageToPlayer takes player thisPlayer, string message returns nothing
        call ChatService_sendMessageToPlayer(profileSystem, message, ChatProfiles_getReal(thisPlayer))
    endfunction

    public function sendSystemMessageToGroup takes ChatGroup thisGroup, string message returns nothing
        call ChatService_sendMessageToGroup(profileSystem, message, thisGroup)
    endfunction

    public function silencePlayer takes player thisPlayer, boolean silence returns nothing
        local integer pid = GetPlayerId(thisPlayer)
        if silence then
            set muted[pid] = muted[pid] + 1
        else
            set muted[pid] = muted[pid] - 1
            if muted[pid] < 0 then
                set muted[pid] = 0
            endif
        endif
    endfunction

    public function isPlayerSilenced takes player thisPlayer returns boolean
        return muted[GetPlayerId(thisPlayer)] > 0
    endfunction

    private function chatTriggerAction takes nothing returns boolean
        local ChatGroup thisGroup
        local ChatProfile thisProfile
        local player chatPlayer = GetTriggerPlayer()
        local string message = GetEventPlayerChatString()

        call Commands_processInput(chatPlayer, message)
        if Commands_isCommand then
            return
        endif

        call GroupBroadcast_processChat(chatPlayer, message)
        if GroupBroadcast_isBroadcast then
            return
        endif

        call BHD_CheckAndSpawn(chatPlayer, message)
        if BHD_isCommand then
            return
        endif

        if isPlayerSilenced(chatPlayer) then
            return
        endif

        call AndroidChat_CheckChat(chatPlayer, message)
        if AndroidChat_isAndroidChat then
            return
        endif
        
        if not enabled then
            return
        endif

        set thisGroup = PlayerSelectedChat_GetSelectedGroupForPlayer(chatPlayer)
        if thisGroup != 0 then
            call ChatService_sendMessageToGroup(ChatProfiles_getReal(chatPlayer), message, thisGroup)
        else
            set thisProfile = PlayerSelectedChat_GetSelectedRecepientForPlayer(chatPlayer)
            if thisProfile != 0 then
                call ChatService_sendMessageToPlayer(ChatProfiles_getReal(chatPlayer), message, thisProfile)
            else
                call sendSystemMessageToPlayer(chatPlayer, "|cFFFF0000Error: No chat recepient/group has been selected! Use -default command to select a group or a player!")
            endif
        endif
        return enabled
    endfunction

    //To prevent from GHost starting messages from doxxing people and ruining "immersion"
    private function enableChat takes nothing returns nothing
        call Timeout.complete()
        set enabled = true
        call systemMessage("U.S.I. Comms online!")
    endfunction

    private function initPlayer takes nothing returns nothing
        local player thisPlayer = GetEnumPlayer()
        local ChatProfile playerProfile = ChatProfiles_getReal(thisPlayer)
        set playerProfile.name = PlayerColor_GetPlayerTextColor(thisPlayer) + GetPlayerName(thisPlayer)

        call groupSystem.add(playerProfile)
        call groupAll.add(playerProfile)

        call PlayerSelectedChat_SetPlayerChatGroup(thisPlayer, groupAll)
        call TriggerRegisterPlayerChatEvent(chatTrigger, thisPlayer, "", false)
    endfunction

    private function initFinal takes nothing returns nothing
        call Timeout.complete()
        call ChatService_registerUIListener(ChatUI_ChatUIProxy.get())
        //ChatLogUI
        call ForForce(GetPlayersAll(), function initPlayer)
    endfunction

    private function init takes nothing returns nothing
        set chatTrigger = CreateTrigger()
        call TriggerAddCondition(chatTrigger, Condition(function chatTriggerAction))
        call Timeout.start(0.0, false, function initFinal)
        call Timeout.start(0.1, false, function enableChat)

        set profileSystem = ChatProfiles_getVirtual("System")
        set profileSystem.icon = "ReplaceableTextures\\CommandButtons\\BTNSentinel.blp"

        set groupSystem = ChatGroups_get("System")
        set groupSystem.owner = profileSystem
        set groupSystem.name = "[|cffffba5bSYS|r]"

        set groupAll = ChatGroups_get("All")
        set groupAll.owner = profileSystem
        set groupAll.name = "[|cff6aebffGlobal|r]"

        set groupDead = ChatGroups_get("Dead")
        set groupDead.owner = profileSystem
        set groupDead.name = "[|cff808080Dead|r]"

        set groupAliens = ChatGroups_get("Aliens")
        set groupAliens.owner = profileSystem
        set groupAliens.name = "[|cff800080Alien|r]"
        
        set groupMutants = ChatGroups_get("Mutants")
        set groupMutants.owner = profileSystem
        set groupMutants.name = "[|cff117326Mutant|r]"
    endfunction
endlibrary