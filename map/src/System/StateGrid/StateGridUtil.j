library StateGridUtil initializer init requires StateGrid 
    globals 
        private force tempForce 
        private filterfunc findHumansFilter 
        private player thisPlayer 
        private force newForce
    endglobals 

    private function FindAliveHumans takes nothing returns boolean 
        set thisPlayer = GetFilterPlayer() 
        return StateGrid_IsPlayerAlive(thisPlayer) and StateGrid_IsPlayerHuman(thisPlayer) and not StateGrid_IsPlayerAndroid(thisPlayer) //android might have human sub-role     
    endfunction 

    public function PickRandomLivingHuman takes nothing returns player 
        call ForceClear(tempForce) 
        call ForceEnumPlayers(tempForce, findHumansFilter) 
        return ForcePickRandomPlayer(tempForce) 
    endfunction 

    public function GetHumans takes nothing returns force
        set newForce = CreateForce()
        call ForceEnumPlayers(newForce, findHumansFilter)
        return newForce
    endfunction

    private function init takes nothing returns nothing 
        set tempForce = CreateForce() 
        set findHumansFilter = Filter(function FindAliveHumans) 
    endfunction 
endlibrary