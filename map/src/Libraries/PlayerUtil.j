library PlayerUtil initializer init requires Table 
    globals 
        private Table proxies 
    endglobals 
    
    public function setPlayerProxy takes player thisPlayer, player actualPlayer returns nothing 
        call proxies.player.store(thisPlayer, actualPlayer) 
    endfunction 

    public function getActualPlayer takes player proxyPlayer returns player 
        if proxies.stores(proxyPlayer) then 
            return proxies.player.get(proxyPlayer) 
        else 
            return proxyPlayer 
        endif 
    endfunction 

    public function findOwningPlayer takes unit u returns player 
        return getActualPlayer(GetOwningPlayer(u)) 
    endfunction 

    private function init takes nothing returns nothing 
        set proxies = Table.create() 
    endfunction 
endlibrary 
