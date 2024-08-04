library StateGrid initializer Init requires StringWidth, PlayerColor, Timeout, Table, PlayerUtil
    globals 
        private multiboard stateGrid 
        private PlayerData array playerDatas 

        public integer STATE_DEAD = 0 
        public integer STATE_ALIVE = 1 
        public integer STATE_LEFT = 2 
        public integer SUB_ROLE_NONE = -1
        public integer ROLE_HUMAN = 0 
        public integer ROLE_ALIEN = 1 
        public integer ROLE_ALIEN_SPAWN = 2 
        public integer ROLE_MUTANT = 3 
        public integer ROLE_MUTANT_SPAWN = 4 
        public integer ROLE_ANDROID = 5 

        //TODO: use .wts to provide these strings   
        private string GRID_TITLE = "State table        " 
        private string TITLE_NAME = "Name:" 
        private string TITLE_STATUS = "Status:" 
        private string TITLE_ROLE = "Role:" 
        private string STATE_DEAD_TEXT = "|cFFFF3333Dead|r" 
        private string STATE_ALIVE_TEXT = "|cFF33FF33Alive|r" 
        private string STATE_LEFT_TEXT = "|cFF999999Left|r" 
        private string ROLE_HUMAN_TEXT = "|cff2289ffHuman|r" 
        private string ROLE_ALIEN_TEXT = "|cff7a1bffAlien|r" 
        private string ROLE_ALIEN_SPAWN_TEXT = "|cffae4affAlien Spawn|r" 
        private string ROLE_MUTANT_TEXT = "|cff016712Mutant|r" 
        private string ROLE_MUTANT_SPAWN_TEXT = "|cff6e820eMutant Spawn|r" 
        private string ROLE_ANDROID_TEXT = "|cff34eeffAndroid|r" 
        private string ROLE_UNKNOWN_TEXT = "|cFFFFFFFFUnknown|r" 

        //config    
        private real nameWidth = 0.13 
        private real statusWidth = 0.07 
        private real roleWidth = 0.08 
        private real width = nameWidth + statusWidth + roleWidth 

        //internal    
        private integer gridRowCount = 0 
        private multiboarditem array items 
        private integer currentIndex 
    endglobals 

    struct PlayerData 
        integer rowIndex 
        integer state 
        integer role 
        integer subRole

        static method create takes integer rowIndex returns thistype 
            local thistype this = thistype.allocate() 
            set this.rowIndex = rowIndex 
            set this.state = STATE_ALIVE 
            set this.role = ROLE_HUMAN 
            set this.subRole = SUB_ROLE_NONE
            return this 
        endmethod 
    endstruct 

    private function getPlayerData takes player thisPlayer returns PlayerData
        return playerDatas[GetPlayerId(thisPlayer)]
    endfunction

    //should convert these into arrays, but this will suffice    
    private function getRoleText takes integer roleId returns string 
        if roleId == ROLE_HUMAN then 
            return ROLE_HUMAN_TEXT 
        elseif roleId == ROLE_ALIEN then 
            return ROLE_ALIEN_TEXT 
        elseif roleId == ROLE_ALIEN_SPAWN then 
            return ROLE_ALIEN_SPAWN_TEXT 
        elseif roleId == ROLE_MUTANT then 
            return ROLE_MUTANT_TEXT 
        elseif roleId == ROLE_MUTANT_SPAWN then 
            return ROLE_MUTANT_SPAWN_TEXT 
        elseif roleId == ROLE_ANDROID then 
            return ROLE_ANDROID_TEXT 
        else 
            return ROLE_UNKNOWN_TEXT 
        endif 
    endfunction 

    private function getStateText takes integer stateId returns string
        if stateId == STATE_DEAD then
            return STATE_DEAD_TEXT
        elseif stateId == STATE_ALIVE then
            return STATE_ALIVE_TEXT
        elseif stateId == STATE_LEFT then
            return STATE_LEFT_TEXT
        else
            return ""
        endif
    endfunction

    private function setOldRole takes player thisPlayer, integer role returns nothing
        if role == ROLE_ALIEN then
            set udg_Parasite = thisPlayer
            call PlayerUtil_setPlayerProxy(Player(bj_PLAYER_NEUTRAL_EXTRA), thisPlayer)
        elseif role == ROLE_MUTANT then
            set udg_Mutant = thisPlayer
        elseif role == ROLE_ANDROID then
            set udg_HiddenAndroid = thisPlayer
        endif
    endfunction

    public function SetPlayerRole takes player thisPlayer, integer role returns nothing
        local PlayerData data = getPlayerData(thisPlayer)
        set data.role = role
        if thisPlayer == GetLocalPlayer() then
            call MultiboardSetItemValue(items[data.rowIndex * 3 + 2], getRoleText(role))
        endif
        call setOldRole(thisPlayer, role)
    endfunction

    public function SetPlayerSubRole takes player thisPlayer, integer subRole returns nothing
        set getPlayerData(thisPlayer).subRole = subRole
    endfunction

    public function SetPlayerState takes player thisPlayer, integer state returns nothing 
        local PlayerData data = getPlayerData(thisPlayer) 
        set data.state = state 
        call MultiboardSetItemValue(items[data.rowIndex * 3 + 1], getStateText(state)) 
    endfunction 

    public function SetPlayerName takes player thisPlayer, string name returns nothing
        local PlayerData data = getPlayerData(thisPlayer)
        call MultiboardSetItemValue(items[data.rowIndex * 3 + 0], PlayerColor_GetPlayerTextColor(thisPlayer) + StringWidth_substringTextToMultiboardWidth(name, 0, nameWidth))
    endfunction

    public function UpdateTime takes string formattedTime returns nothing
        call MultiboardSetTitleText(stateGrid, GRID_TITLE + formattedTime)
    endfunction

    public function RevealPlayerRole takes player thisPlayer, player toPlayer returns nothing 
        local PlayerData data = getPlayerData(thisPlayer) 
        if toPlayer == null or toPlayer == GetLocalPlayer() then // if null - reveal to all    
            call MultiboardSetItemValue(items[data.rowIndex * 3 + 2], getRoleText(data.role)) 
        endif 
    endfunction 

    public function IsPlayerOfRole takes player p, integer role returns boolean
        local PlayerData playerData = getPlayerData(p)
        return playerData.role == role or playerData.subRole == role
    endfunction

    public function IsPlayerHuman takes player p returns boolean 
        return IsPlayerOfRole(p, ROLE_HUMAN)
    endfunction 

    public function IsPlayerAndroid takes player p returns boolean 
        return IsPlayerOfRole(p, ROLE_ANDROID)
    endfunction 

    public function IsPlayerAlien takes player p returns boolean 
        return IsPlayerOfRole(PlayerUtil_getActualPlayer(p), ROLE_ALIEN)
    endfunction 

    public function IsPlayerAlienSpawn takes player p returns boolean 
        return IsPlayerOfRole(p, ROLE_ALIEN_SPAWN)
    endfunction 

    public function IsPlayerAnAlien takes player p returns boolean
        return IsPlayerAlien(p) or IsPlayerAlienSpawn(p)
    endfunction

    public function IsPlayerMutant takes player p returns boolean 
        return IsPlayerOfRole(p, ROLE_MUTANT)
    endfunction 

    public function IsPlayerMutantSpawn takes player p returns boolean 
        return IsPlayerOfRole(p, ROLE_MUTANT_SPAWN)
    endfunction 

    public function IsPlayerAMutant takes player p returns boolean
        return IsPlayerMutant(p) or IsPlayerMutantSpawn(p)
    endfunction

    public function IsPlayerHostEvil takes player p returns boolean 
        return IsPlayerOfRole(p, ROLE_MUTANT) or IsPlayerOfRole(p, ROLE_ALIEN)
    endfunction 

    public function IsPlayerSpawnEvil takes player p returns boolean 
        return IsPlayerOfRole(p, ROLE_MUTANT_SPAWN) or IsPlayerOfRole(p, ROLE_ALIEN_SPAWN)
    endfunction 

    public function IsPlayerEvil takes player p returns boolean 
        return IsPlayerHostEvil(p) or IsPlayerSpawnEvil(p)
    endfunction 
    
    private function IsPlayerState takes player p, integer state returns boolean
        return getPlayerData(p).state == state
    endfunction

    public function IsPlayerAlive takes player p returns boolean
        return IsPlayerState(p, STATE_ALIVE)
    endfunction

    public function IsPlayerDead takes player p returns boolean
        return IsPlayerState(p, STATE_DEAD)
    endfunction

    public function IsPlayerGone takes player p returns boolean
        return IsPlayerState(p, STATE_LEFT)
    endfunction 

    public function GetAndroid takes nothing returns player
        return udg_HiddenAndroid
    endfunction

    public function GetMutant takes nothing returns player
        return udg_Mutant
    endfunction

    public function GetAlien takes nothing returns player
        return udg_Parasite
    endfunction

    private function initForPlayer takes player enumPlayer returns nothing 
        set playerDatas[GetPlayerId(enumPlayer)] = PlayerData.create(currentIndex) 
        call MultiboardSetItemValue(items[3 * currentIndex + 0], PlayerColor_GetPlayerTextColor(enumPlayer) + StringWidth_substringTextToMultiboardWidth(GetPlayerName(enumPlayer), 0, nameWidth)) 
        call MultiboardSetItemWidth(items[3 * currentIndex + 0], nameWidth) 
        call MultiboardSetItemValue(items[3 * currentIndex + 1], STATE_ALIVE_TEXT) 
        call MultiboardSetItemWidth(items[3 * currentIndex + 1], statusWidth) 
        call MultiboardSetItemValue(items[3 * currentIndex + 2], ROLE_UNKNOWN_TEXT) 
        call MultiboardSetItemWidth(items[3 * currentIndex + 2], roleWidth) 
        call RevealPlayerRole(enumPlayer, enumPlayer) 
    endfunction 

    private function ClearGrid takes nothing returns nothing
        local integer index = 0
        local integer itemCount = 3 * gridRowCount
        call MultiboardDisplay(stateGrid, false)
        call MultiboardClear(stateGrid)
        loop
            exitwhen index >= itemCount
            call MultiboardReleaseItem(items[index])
            set index = index + 1
        endloop
    endfunction

    public function Initialize takes integer playerSize returns nothing 
        local integer index = 0 
        local integer maxIndex 
        local integer column = 0 
        local integer row = 0 
        local multiboarditem mbItem 
        call ClearGrid() 
        set gridRowCount = playerSize + 2 // title and space    
        call MultiboardSetRowCount(stateGrid, gridRowCount) 
        call MultiboardSetColumnCount(stateGrid, 3) 
        call MultiboardSetItemsStyle(stateGrid, true, false) //no icons    
        
        set maxIndex = gridRowCount * 3
        loop
            exitwhen index >= maxIndex 
            set mbItem = MultiboardGetItem(stateGrid, row, column)
            set items[index] = mbItem

            if row == 0 then
                if column == 0 then
                    call MultiboardSetItemWidth(mbItem, nameWidth)
                    call MultiboardSetItemValue(mbItem, TITLE_NAME)
                elseif column == 1 then
                    call MultiboardSetItemWidth(mbItem, statusWidth)
                    call MultiboardSetItemValue(mbItem, TITLE_STATUS)
                else
                    call MultiboardSetItemWidth(mbItem, roleWidth)
                    call MultiboardSetItemValue(mbItem, TITLE_ROLE)
                endif
            endif

            set index = index + 1
            set column = column + 1
            if column >= 3 then
                set row = row + 1
                set column = 0
            endif
        endloop

        set currentIndex = 2
        
        loop
            exitwhen currentIndex >= playerSize + 2
            call initForPlayer(Anonymity_ShuffledPlayersArray[currentIndex - 2])
            set currentIndex = currentIndex + 1
        endloop

        call MultiboardSetTitleText(stateGrid, GRID_TITLE)
        call MultiboardDisplay(stateGrid, true)
        call MultiboardMinimize(stateGrid, true)
    endfunction

    private function Init takes nothing returns nothing
        set stateGrid = CreateMultiboard()
    endfunction

endlibrary