library Anonymity initializer init 
    globals 
        public player array ShuffledPlayersArray 

        private playercolor array colors 
        private string array colorNames 
        private force ShuffledPlayers 
    endglobals 

    private function populateForce takes nothing returns nothing 
        call ForceAddPlayer(ShuffledPlayers, GetEnumPlayer()) 
    endfunction 

    private function init takes nothing returns nothing 
        local integer index = 0 
        local integer arrayIndex = 0 
        local integer colorIndexMax = 20 
        local player randomPlayer 
        local force tempForce 

        //Gray, Snow and Coal player colors were removed from consideration - they're practically invisible on the minimap   

        set colors[0] = ConvertPlayerColor(0) 
        set colorNames[0] = "Red" 
        set colors[1] = ConvertPlayerColor(1) 
        set colorNames[1] = "Blue" 
        set colors[2] = ConvertPlayerColor(2) 
        set colorNames[2] = "Teal" 
        set colors[3] = ConvertPlayerColor(3) 
        set colorNames[3] = "Purple" 
        set colors[4] = ConvertPlayerColor(4) 
        set colorNames[4] = "Yellow" 
        set colors[5] = ConvertPlayerColor(5) 
        set colorNames[5] = "Orange" 
        set colors[6] = ConvertPlayerColor(6) 
        set colorNames[6] = "Green" 
        set colors[7] = ConvertPlayerColor(7) 
        set colorNames[7] = "Pink" 
        set colors[8] = ConvertPlayerColor(9) 
        set colorNames[8] = "Light blue" 
        set colors[9] = ConvertPlayerColor(10) 
        set colorNames[9] = "Dark green" 
        set colors[10] = ConvertPlayerColor(11) 
        set colorNames[10] = "Brown" 
        set colors[11] = ConvertPlayerColor(12) 
        set colorNames[11] = "Maroon" 
        set colors[12] = ConvertPlayerColor(13) 
        set colorNames[12] = "Navy" 
        set colors[13] = ConvertPlayerColor(14) 
        set colorNames[13] = "Turquoise" 
        set colors[14] = ConvertPlayerColor(15) 
        set colorNames[14] = "Violet" 
        set colors[15] = ConvertPlayerColor(16) 
        set colorNames[15] = "Wheat" 
        set colors[16] = ConvertPlayerColor(17) 
        set colorNames[16] = "Peach" 
        set colors[17] = ConvertPlayerColor(18) 
        set colorNames[17] = "Mint" 
        set colors[18] = ConvertPlayerColor(19) 
        set colorNames[18] = "Lavander" 
        set colors[19] = ConvertPlayerColor(22) 
        set colorNames[19] = "Emerald" 
        set colors[20] = ConvertPlayerColor(23) 
        set colorNames[20] = "Peanut" 

        set ShuffledPlayers = CreateForce() 
        call ForForce(GetPlayersAll(), function populateForce) 
        set tempForce = ShuffledPlayers 
        set ShuffledPlayers = CreateForce() 
        loop 
            set randomPlayer = ForcePickRandomPlayer(tempForce) 
            exitwhen randomPlayer == null 
            call ForceRemovePlayer(tempForce, randomPlayer) 
            call ForceAddPlayer(ShuffledPlayers, randomPlayer) 
            set ShuffledPlayersArray[arrayIndex] = randomPlayer 
            set arrayIndex = arrayIndex + 1 

            set index = GetRandomInt(0, colorIndexMax) 
            call SetPlayerColor(randomPlayer, colors[index]) 
            call SetPlayerName(randomPlayer, colorNames[index]) 
            set colors[index] = colors[colorIndexMax] 
            set colorNames[index] = colorNames[colorIndexMax] 
            set colorIndexMax = colorIndexMax - 1 
        endloop 

        //Fix 1.29's wrong color shade for neutrals   
        call SetPlayerColor(Player(PLAYER_NEUTRAL_PASSIVE), ConvertPlayerColor(8)) 
        call SetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE), ConvertPlayerColor(8)) 
        call SetPlayerColor(Player(bj_PLAYER_NEUTRAL_EXTRA), ConvertPlayerColor(8)) 
        call SetPlayerColor(Player(bj_PLAYER_NEUTRAL_VICTIM), ConvertPlayerColor(8)) 
    endfunction 

    //1-indexed function, used for chat commands    
    public function GetPlayerFromIndex takes integer index returns player 
        if index > 0 then 
            return Anonymity_ShuffledPlayersArray[index - 1] 
        else 
            return null 
        endif 
    endfunction 

    //1-indexed function, used for chat commands    
    public function GetPlayerFromStringIndex takes string index returns player 
        if index == null or index == "" then 
            return null 
        endif 
        return GetPlayerFromIndex(S2I(index)) 
    endfunction 

    //1-indexed function, used for chat commands 
    public function GetPlayerFromIndex takes integer index returns player 
        if index > 0 then 
            return Anonymity_ShuffledPlayersArray[index - 1] 
        else 
            return null 
        endif 
    endfunction 

    //1-indexed function, used for chat commands 
    public function GetPlayerFromStringIndex takes string index returns player 
        if index == null or index == "" then 
            return null 
        endif 
        return GetPlayerFromIndex(S2I(index)) 
    endfunction 
endlibrary