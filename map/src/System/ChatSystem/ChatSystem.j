library ChatSystem initializer init requires ChatService, ChatGroups, ChatProfiles, ChatUI, Commands, Timeout, PlayerColor 
    globals
        private ChatProfile profileSystem
        private ChatGroup groupSystem
        public ChatGroup groupAll
        public ChatGroup groupDead

        private trigger chatTrigger
        public boolean enabled = false
        private boolean array muted
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

    public function silencePlayer takes player thisPlayer, boolean silence returns nothing
        set muted[GetPlayerId(thisPlayer)] = silence
    endfunction

    public function isPlayerSilenced takes player thisPlayer returns boolean
        return muted[GetPlayerId(thisPlayer)]
    endfunction

    private function chatTriggerAction takes nothing returns boolean
        local player chatPlayer = GetTriggerPlayer()
        local string message = GetEventPlayerChatString()

        call Commands_processInput(chatPlayer, message)
        if enabled and not Commands_isCommand then
            //check if group or private? need to translate that first.
            call ChatService_sendMessageToGroup(ChatProfiles_getReal(chatPlayer), message, groupAll)
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
        set groupSystem.name = "[|cff00e6e2SYS|r]"

        set groupAll = ChatGroups_get("All")
        set groupAll.owner = profileSystem
        set groupAll.name = "[Global]"

        set groupDead = ChatGroups_get("Dead")
        set groupDead.owner = profileSystem
        set groupDead.name = "[Dead]"
    endfunction
endlibrary