library PlayerColor initializer init 
    globals 
        private string array textColors 
    endglobals 

    public function GetPlayerColorTextColor takes playercolor p returns string 
        local integer index = 0 
        local integer endindex = GetBJMaxPlayers() + 4 //neutrals 

        loop 
            exitwhen index >= endindex 
            exitwhen ConvertPlayerColor(index) == p 
            set index = index + 1 
        endloop 

        return textColors[index] 
    endfunction 

    public function GetPlayerTextColor takes player p returns string 
        return GetPlayerColorTextColor(GetPlayerColor(p)) 
    endfunction 

    private function init takes nothing returns nothing 
        set textColors[0] = "|cffff0303" 
        set textColors[1] = "|cff0042ff" 
        set textColors[2] = "|cff1ce6b9" 
        set textColors[3] = "|cff540081" 
        set textColors[4] = "|cfffffc00" 
        set textColors[5] = "|cfffe8a0e" 
        set textColors[6] = "|cff20c000" 
        set textColors[7] = "|cffe55bb0" 
        set textColors[8] = "|cff959697" 
        set textColors[9] = "|cff7ebff1" 
        set textColors[10] = "|cff106246" 
        set textColors[11] = "|cff4e2a04" 
        set textColors[12] = "|cff9b0000" 
        set textColors[13] = "|cff0000c3" 
        set textColors[14] = "|cff00eaff" 
        set textColors[15] = "|cffbe00fe" 
        set textColors[16] = "|cffebcd87" 
        set textColors[17] = "|cfff8a48b" 
        set textColors[18] = "|cffbfff80" 
        set textColors[19] = "|cffdcb9eb" 
        set textColors[20] = "|cff4f5055" 
        set textColors[21] = "|cffebf0ff" 
        set textColors[22] = "|cff00781e" 
        set textColors[23] = "|cffa46f33" 
        set textColors[24] = "|cff2e2d2e" 
        set textColors[25] = "|cff2e2d2e" 
        set textColors[26] = "|cff2e2d2e" 
        set textColors[27] = "|cff2e2d2e" 
    endfunction 
endlibrary