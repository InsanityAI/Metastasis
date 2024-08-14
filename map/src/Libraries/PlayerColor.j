library PlayerColor initializer init requires Table 
    globals 
        private Table PlayerColors // table<playercolor, PlayerColor>  
    endglobals 

    struct PlayerColor 
        readonly string color 
        readonly string name 
        readonly integer red 
        readonly integer green 
        readonly integer blue 

        static method create takes string color, string name, integer red, integer green, integer blue returns thistype 
            local thistype this = thistype.allocate() 
            set this.color = color 
            set this.name = name 
            set this.red = red 
            set this.green = green 
            set this.blue = blue 
            return this 
        endmethod 
    endstruct 

    public function Get takes playercolor p returns PlayerColor 
        if PlayerColors.stores(p) then 
            return PlayerColors.get(p) 
        endif 
        return 0 
    endfunction 

    public function GetByPlayer takes player thisPlayer returns PlayerColor 
        return Get(GetPlayerColor(thisPlayer)) 
    endfunction 

    public function GetByPlayerId takes integer playerId returns PlayerColor 
        return GetByPlayer(Player(playerId)) 
    endfunction 

    private function init takes nothing returns nothing 
        local PlayerColor black = PlayerColor.create("ff2e2d2e", "Black", 46, 45, 46) 
        set PlayerColors = Table.create()
        call PlayerColors.store(PLAYER_COLOR_RED, PlayerColor.create("ffff0303", "Red", 255, 3, 3)) 
        call PlayerColors.store(PLAYER_COLOR_BLUE, PlayerColor.create("ff0042ff", "Blue", 0, 66, 255)) 
        call PlayerColors.store(PLAYER_COLOR_TURQUOISE, PlayerColor.create("ff1ce6b9", "Teal", 28, 230, 185)) 
        call PlayerColors.store(PLAYER_COLOR_PURPLE, PlayerColor.create("ff540081", "Purple", 84, 0, 129)) 
        call PlayerColors.store(PLAYER_COLOR_YELLOW, PlayerColor.create("fffffc00", "Yellow", 255, 254, 0)) 
        call PlayerColors.store(PLAYER_COLOR_ORANGE, PlayerColor.create("fffe8a0e", "Orange", 254, 138, 14)) 
        call PlayerColors.store(PLAYER_COLOR_GREEN, PlayerColor.create("ff20c000", "Green", 32, 192, 0)) 
        call PlayerColors.store(PLAYER_COLOR_PINK, PlayerColor.create("ffe55bb0", "Pink", 229, 91, 176)) 
        call PlayerColors.store(PLAYER_COLOR_LIGHT_GRAY, PlayerColor.create("ff959697", "Gray", 149, 150, 151)) 
        call PlayerColors.store(PLAYER_COLOR_LIGHT_BLUE, PlayerColor.create("ff7ebff1", "Light Blue", 126, 191, 241)) 
        call PlayerColors.store(PLAYER_COLOR_AQUA, PlayerColor.create("ff106246", "Dark Green", 16, 98, 70)) 
        call PlayerColors.store(PLAYER_COLOR_BROWN, PlayerColor.create("ff4e2a04", "Brown", 78, 42, 4)) 
        call PlayerColors.store(PLAYER_COLOR_MAROON, PlayerColor.create("ff9b0000", "Maroon", 155, 0, 0)) 
        call PlayerColors.store(PLAYER_COLOR_NAVY, PlayerColor.create("ff0000c3", "Navy", 0, 0, 195)) 
        call PlayerColors.store(PLAYER_COLOR_TURQUOISE, PlayerColor.create("ff00eaff", "Turquoise", 155, 234, 255)) 
        call PlayerColors.store(PLAYER_COLOR_VIOLET, PlayerColor.create("ffbe00fe", "Violet", 190, 0, 254)) 
        call PlayerColors.store(PLAYER_COLOR_WHEAT, PlayerColor.create("ffebcd87", "Wheat", 235, 205, 135)) 
        call PlayerColors.store(PLAYER_COLOR_PEACH, PlayerColor.create("fff8a48b", "Peach", 248, 164, 139)) 
        call PlayerColors.store(PLAYER_COLOR_MINT, PlayerColor.create("ffbfff80", "Mint", 191, 255, 128)) 
        call PlayerColors.store(PLAYER_COLOR_LAVENDER, PlayerColor.create("ffdcb9eb", "Lavender", 220, 185, 235)) 
        call PlayerColors.store(PLAYER_COLOR_COAL, PlayerColor.create("ff282828", "Coal", 40, 40, 40)) 
        call PlayerColors.store(PLAYER_COLOR_SNOW, PlayerColor.create("ffebf0ff", "Snow", 235, 240, 255)) 
        call PlayerColors.store(PLAYER_COLOR_EMERALD, PlayerColor.create("ff00781e", "Emerald", 0, 120, 30)) 
        call PlayerColors.store(PLAYER_COLOR_PEANUT, PlayerColor.create("ffa46f33", "Peanut", 164, 111, 51)) 
        call PlayerColors.store(ConvertPlayerColor(24), black) 
        call PlayerColors.store(ConvertPlayerColor(25), black) 
        call PlayerColors.store(ConvertPlayerColor(26), black) 
        call PlayerColors.store(ConvertPlayerColor(27), black) 
    endfunction 
endlibrary