library Anonymity initializer init
    globals
        public force ShuffledPlayers
        public player array ShuffledPlayersArray

        private playercolor array colors
        private string array colorNames
    endglobals

    private function populateForce takes nothing returns nothing
        call ForceAddPlayer(ShuffledPlayers, GetEnumPlayer())
    endfunction

    private function init takes nothing returns nothing
        local integer index = 0
        local integer arrayIndex = 0
        local integer colorIndexMax = GetBJMaxPlayers() - 1
        local player randomPlayer
        local force tempForce

        loop
            exitwhen index > colorIndexMax
            set colors[index] = ConvertPlayerColor(index)
            set index = index + 1
        endloop

        set colorNames[0] = "Red"
        set colorNames[1] = "Blue"
        set colorNames[2] = "Teal"
        set colorNames[3] = "Purple"
        set colorNames[4] = "Yellow"
        set colorNames[5] = "Orange"
        set colorNames[6] = "Green"
        set colorNames[7] = "Pink"
        set colorNames[8] = "Gray"
        set colorNames[9] = "Light blue"
        set colorNames[10] = "Dark green"
        set colorNames[11] = "Brown"
        set colorNames[12] = "Maroon"
        set colorNames[13] = "Navy"
        set colorNames[14] = "Turquoise"
        set colorNames[15] = "Violet"
        set colorNames[16] = "Wheat"
        set colorNames[17] = "Peach"
        set colorNames[18] = "Mint"
        set colorNames[19] = "Lavander"
        set colorNames[20] = "Coal"
        set colorNames[21] = "Snow"
        set colorNames[22] = "Emerald"
        set colorNames[23] = "Peanut"

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
        
    endfunction
endlibrary