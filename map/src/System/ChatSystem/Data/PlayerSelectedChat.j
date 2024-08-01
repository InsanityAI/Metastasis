library PlayerSelectedChat initializer init requires ChatProfiles, ChatGroups, Table
    globals
        private Table playerSelectedGroups //table<player, ChatGroup>
        private Table playerSelectedRecepient //table<player, ChatProfile>
    endglobals

    public function SetPlayerChatGroup takes player thisPlayer, ChatGroup thisGroup returns nothing
        if thisPlayer == null or thisGroup == 0 then
            return
        endif

        call playerSelectedGroups.store(thisPlayer, thisGroup) 
        call playerSelectedRecepient.store(thisPlayer, 0)
    endfunction

    public function SetPlayerRecepient takes player thisPlayer, ChatProfile thisProfile returns nothing
        if thisPlayer == null or thisProfile == 0 then
            return
        endif

        call playerSelectedGroups.store(thisPlayer, 0) 
        call playerSelectedRecepient.store(thisPlayer, thisProfile)
    endfunction

    public function GetSelectedGroupForPlayer takes player thisPlayer returns ChatGroup
        if thisPlayer == null then
            return 0
        endif
        return playerSelectedGroups.get(thisPlayer)
    endfunction

    public function GetSelectedRecepientForPlayer takes player thisPlayer returns ChatProfile
        if thisPlayer == null then
            return 0
        endif
        return playerSelectedRecepient.get(thisPlayer)
    endfunction

    private function init takes nothing returns nothing
        set playerSelectedGroups = Table.create()
        set playerSelectedRecepient = Table.create()
    endfunction
endlibrary