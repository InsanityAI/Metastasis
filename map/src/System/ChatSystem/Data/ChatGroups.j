library ChatGroups initializer init requires Table
    globals
        private Table groups //table<string, ChatGroup>
    endglobals

    struct ChatGroup
        public ChatProfile owner
        public string name
        readonly Table members //table<ChatProfile, 1>

        static method create takes string name returns thistype
            local thistype chatGroup = ChatGroup.allocate()
            set chatGroup.name = name
            set chatGroup.members = Table.create()
            call groups.write(name, chatGroup)
            return chatGroup
        endmethod

        public method add takes ChatProfile profile returns nothing
            call this.members.save(profile, 1)
        endmethod

        public method remove takes ChatProfile profile returns nothing
            call this.members.remove(profile)
        endmethod

        public method contains takes ChatProfile profile returns boolean
            return this.members.has(profile)
        endmethod
    endstruct

    public function get takes string name returns ChatGroup
        local ChatGroup chatGroup
        if groups.written(name) then
            set chatGroup = groups.read(name)
        else
            set chatGroup = ChatGroup.create(name)
        endif
        return chatGroup
    endfunction

    private function init takes nothing returns nothing
        set groups = Table.create() 
    endfunction
endlibrary