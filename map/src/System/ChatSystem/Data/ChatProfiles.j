library ChatProfiles initializer init requires Table
    globals
        private Table profiles //table<string|player, ChatProfile>
    endglobals

    struct ChatProfile
        public player chatPlayer
        public string name
        public string icon

        static method create takes player chatPlayer, string name returns thistype
            local thistype this = ChatProfile.allocate()
            set this.chatPlayer = chatPlayer
            set this.name = name
            return this
        endmethod
    endstruct

    //Used to make virtual profiles
    public function getVirtual takes string name returns ChatProfile
        local ChatProfile chatProfile
        if profiles.written(name) then
            set chatProfile = profiles.read(name)
        else
            set chatProfile = ChatProfile.create(null, name)
            call profiles.write(name, chatProfile)
        endif
        return chatProfile
    endfunction

    //Used to make real profiles
    public function getReal takes player chatPlayer returns ChatProfile
        local ChatProfile chatProfile
        if profiles.stores(chatPlayer) then
            set chatProfile = profiles.get(chatPlayer)
        else
            set chatProfile = ChatProfile.create(chatPlayer, GetPlayerName(chatPlayer))
            call profiles.store(chatPlayer, chatProfile)
        endif
        return chatProfile
    endfunction

    private function init takes nothing returns nothing
        set profiles = Table.create() 
    endfunction
endlibrary