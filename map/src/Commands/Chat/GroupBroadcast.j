library GroupBroadcast initializer init requires StringUtil, ChatSystem, ChatGroups, ChatProfiles, ChatService
    globals
        private boolean isBroadcast = false
        private constant EVIL_BROADCAST_PREFIX = "["
        private constant REGULAR_BROADCAST_PREFIX = "."
    endglobals

    private function processEvilBroadcast takes player initiator, string message returns nothing
        local ChatGroup chatGroup
        if IsPlayerInForce(initiator, udg_DeadGroup) then
            call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You cannot speak to your fellow kin beyond the grave!")
            return
        endif

        if not(udg_Player_IsParasiteSpawn[GetConvertedPlayerId(initiator)] or initiator == udg_Parasite) then 
            set chatGroup = ChatSystem_groupAliens
        elseif not(udg_Player_IsMutantSpawn[GetConvertedPlayerId(initiator)] or initiator == udg_Mutant) then
            set chatGroup = ChatSystem_groupMutants
        else
            call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Access denied!")
            return
        endif
        
        call ChatService_sendMessageToGroup(ChatProfiles_getReal(initiator), SubString(message, 1, StringLength(message)), chatGroup)
    endfunction

    private function processNormalBroadcast takes player initiator, string message returns nothing
        local string groupName
        local ChatGroup chatGroup
        local player targettedPlayer

        if IsPlayerInForce(initiator, udg_DeadGroup) then
            call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You cannot use other chat groups!")
            return
        endif

        call StringUtil_ParseStringWithArgc(message, 2)
        set groupName = SubString(StringUtil_argv[0], 1, StringLength(StringUtil_argv[0])) //remove the broadcast prefix

        if ChatGroups_exists(groupName) then
            set chatGroup = ChatGroups_get(groupName)
            if chatGroup.owner != initiatorProfile and not chatGroup.contains(initiatorProfile) then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You do not belong in this chat group!")
                return
            endif
            ChatService_sendMessageToGroup(ChatProfiles_getReal(initiator), StringUtil_argv[1], chatGroup)
        else
            set targettedPlayer = Anonymity_GetPlayerFromStringIndex(groupName)
            if targettedPlayer == null then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Chat group or player not found!")
                return
            endif
            set chatProfile = ChatProfiles_getReal(targettedPlayer)
            ChatService_sendMessageToPlayer(ChatProfiles_getReal(initiator), StringUtil_argv[1], ChatProfiles_getReal(targettedPlayer))
        endif

    endfunction

    public function processChat takes player thisPlayer, string message returns nothing
        local string prefix = SubString(message, 0, 1)
        if prefix == EVIL_BROADCAST_PREFIX then
            set isBroadcast = true
            call processEvilBroadcast(thisPlayer, message)
        elseif prefix == REGULAR_BROADCAST_PREFIX then
            set isBroadcast = true
            call processNormalBroadcast(thisPlayer, message)
        else
            set isBroadcast = false
        endif
    endfunction

    private function init takes nothing returns nothing
    endfunction
endlibrary
