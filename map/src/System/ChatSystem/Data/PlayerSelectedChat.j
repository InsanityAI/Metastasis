library PlayerSelectedChat initializer init requires ChatProfiles, ChatGroups, Table
    globals
        private Table playerSelectedGroups //table<player, ChatGroup>
        private Table playerSelectedRecepient //table<player, ChatProfile>
    endglobals

    public function SetPlayerChatGroup takes player thisPlayer, ChatGroup thisGroup returns nothing
        if thisPlayer == null or thisGroup == 0 then
            return
        endif

        playerSelectedGroup.store(player, thisGroup) 
        playerSelectedRecepient.store(player, 0)
    endfunction

    public function SetPlayerRecepient takes player thisPlayer, ChatProfile thisProfile returns nothing
        if thisPlayer == null or thisProfile == 0 then
            return
        endif

        playerSelectedGroup.store(player, 0) 
        playerSelectedRecepient.store(player, thisProfile)
    endfunction

    public function GetSelectedGroupForPlayer takes player thisPlayer return ChatGroup
        if thisPlayer == null then
            return 0
        endif
        return playerSelectedGroup.get(thisPlayer)
    endfunction

    public function GetSelectedRecepientForPlayer takes player thisPlayer return ChatProfile
        if thisPlayer == null then
            return 0
        endif
        return playerSelectedRecepient.get(thisPlayer)
    endfunction

    private function init takes nothing returns nothing
        set playerSelectedGroups = Table.create()
        set playerSelectedRecepients = Table.create()
    endfunction
endlibrary