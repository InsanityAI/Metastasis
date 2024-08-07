//TESH.scrollpos=44
//TESH.alwaysfold=0
///////////////////////////////////////////
/// HostBot Command Library
/// Last Modified: September 14, 2009
/// Authors: Strilanc, 
/// v1.01
///////////////////////////////////////////
/// Reads a command string transparently encoded into player handicaps by hostbots.
/// Allows at most one character from "abcdefghijklmnopqrstuvwxyz0123456789 -=,." per player.
/// Empty slots don't count towards the player count, but computers do.
///////////////////////////////////////////
library HCL initializer init
    globals
        private string command = ""
    endglobals
    
    public function GetCommandString takes nothing returns string
        return command
    endfunction
    
    private function init takes nothing returns nothing
        local integer i
        local integer j
        local integer h
        local integer v
        local string chars = "abcdefghijklmnopqrstuvwxyz0123456789 -=,."
        local integer array map
        local boolean array blocked

        //precompute mapping [have to avoid invalid and normal handicaps]
        set blocked[0] = true
        set blocked[50] = true
        set blocked[60] = true
        set blocked[70] = true
        set blocked[80] = true
        set blocked[90] = true
        set blocked[100] = true
        set i = 0
        set j = 0
        loop
            if blocked[j] then
                set j = j + 1
            endif
            exitwhen j >= 256
            set map[j] = i
            set i = i + 1
            set j = j + 1
        endloop
        
        //Extract command string from player handicaps
        set i = 0
        loop
            exitwhen i >= 12
            set h = R2I(100*GetPlayerHandicap(Player(i)) + 0.5)
            if not blocked[h] then
                set h = map[h]
                set v = h/6
                set h = h-v*6
                call SetPlayerHandicap(Player(i), 0.5 + h/10.0)
                set command = command + SubString(chars, v, v+1)
            endif
            set i = i + 1
        endloop
        if SubStringBJ(command,1,6) == "Sirbot" then
            set udg_SirBot=true
            endif
    endfunction
endlibrary
