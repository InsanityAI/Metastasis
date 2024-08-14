library MetaPlayer initializer init requires Table, PlayerColor, StateGrid
    globals
        private Table data
        private trigger deathTrigger
    endglobals

    struct MetaPlayer
        readonly player actualPlayer
        readonly PlayerColor color
        readonly string originalName
        readonly string name
        readonly string displayName
        readonly MainRole mainRole
        readonly SubRole subRole
        readonly unit hero
        readonly boolean isAI

        static method create takes player p returns thistype
            local thistype this = thistype.allocate()
            set this.actualPlayer = p
            set this.color = PlayerColor_GetByPlayer(p)
            set this.originalName = GetPlayerName(p)
            set this.name = this.originalName
            call this.setName(this.originalName)
            set this.mainRole = 0
            set this.subRole = 0
            set this.hero = null
            set this.isAI = GetPlayerController(p) == MAP_CONTROL_COMPUTER
            return this
        endmethod

        public method setHero takes unit hero returns nothing
            if hero == null then
                if this.hero != null then
                    call data.forget(this.hero)
                    set this.hero = null
                endif
                return
            endif
            call data.store(this.hero, this)
            set this.hero = hero
            if this.mainRole != 0 then
                call this.mainRole.applyRoleProperties(this)
            endif
            if this.subRole != 0 then
                call this.subRole.applyRoleProperties(this)
            endif
        endmethod

        public method setMainRole takes MainRole mainRole returns nothing
            if this.hero != null and this.mainRole != 0 then
                call this.mainRole.removeRoleProperties(this)
            endif

            set this.mainRole = mainRole
            call StateGrid_SetPlayerRole(this.actualPlayer, mainRole.getRoleId())
            call this.setHero(this.hero)
        endmethod

        public method setSubRole takes SubRole subRole returns nothing
            if this.hero != null and this.subRole != 0 then
                call this.subRole.removeRoleProperties(this)
            endif

            set this.subRole = subRole
            call this.setName(this.name) //add name prepension
            call this.setHero(this.hero)
        endmethod

        public method setName takes string name returns nothing
            local string gameName
            set this.name = name

            if subRole != 0 then
                set gameName = this.subRole.getNamePrepension() + " " + name
            else
                set gameName = name
            endif

            set this.displayName = this.color.color + gameName + "|r"

            call SetPlayerName(this.actualPlayer, gameName)
            call StateGrid_SetPlayerName(this.actualPlayer, this.displayName)
            set gameName = null
        endmethod

        public method setColor takes PlayerColor color returns nothing
            set this.color = color
        endmethod

        //Used for start of the classic game!
        public method initializePlayer takes unit hero returns nothing
            call DisplayTimedTextToPlayer(this.actualPlayer, 0, 0, 30, subRole.getInitialText(mainRole))
            call DisplayTimedTextToPlayer(this.actualPlayer, 0, 0, 30, "|cff800080YOUR OBJECTIVES: |r") 
            call DisplayTimedTextToPlayer(this.actualPlayer, 0, 0, 30, mainRole.getInitialText())
            call this.setMainRole(this.mainRole)
            call this.setSubRole(this.subRole)

            if this.subRole.hasPredefinedSpawn() then //Override randomly picked spawn spot in favor of predefined ones for that role.
                call this.subRole.pickPredefinedSpawn()
                call SetUnitX(this.hero, this.subRole.getPredefinedSpawnX())
                call SetUnitY(this.hero, this.subRole.getPredefinedSpawnY())
            endif
            call this.setHero(hero)
        endmethod
    endstruct

    //=============================================
    // Player proxying - if a player can control multiple players, route back to actual player
    //=============================================
    public function SetProxy takes player proxyPlayer, MetaPlayer proxyFor returns nothing
        call data.store(proxyPlayer, proxyFor)
    endfunction

    public function RemoveProxy takes player proxyPlayer returns nothing
        call data.forget(proxyPlayer)
    endfunction

    public function SetProxyUnit takes unit proxyUnit, MetaPlayer proxyFor returns nothing
        call data.store(proxyUnit, proxyFor)
    endfunction

    public function RemoveProxyUnit takes unit proxyUnit returns nothing
        call data.forget(proxyUnit)
    endfunction
    //=============================================
    // End Player proxying
    //=============================================

    public function Get takes player p returns MetaPlayer
        if data.stores(p) then
            return data.get(p)
        else
            return 0
        endif
    endfunction

    public function GetFromHero takes unit hero returns MetaPlayer
        if data.stores(hero) then
            return data.get(hero)
        else
            return 0
        endif
    endfunction

    public function GetFromOwner takes unit u returns MetaPlayer
        return Get(GetOwningPlayer(u))
    endfunction

    private function processDeath takes MetaPlayer metaPlayer returns nothing
        
        //TODO!
    endfunction

    private function playerDeath takes nothing returns boolean
        local unit dyingUnit = GetTriggerUnit()
        if data.stores(dyingUnit) then
            call processDeath(data.get(dyingUnit))
        endif

        set dyingUnit = null
        return false
    endfunction

    private function initPlayer takes nothing returns nothing
        local player thisPlayer = GetEnumPlayer()
        local MetaPlayer metaPlayer = MetaPlayer.create(thisPlayer)
        call data.store(thisPlayer, metaPlayer)

        call TriggerRegisterPlayerUnitEvent(deathTrigger, thisPlayer, EVENT_PLAYER_UNIT_DEATH, null)
        set thisPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set data = Table.create()
        set deathTrigger = CreateTrigger()
        call TriggerAddCondition(deathTrigger, Condition(function playerDeath))
        call ForForce(GetPlayersAll(), function initPlayer)
    endfunction
endlibrary