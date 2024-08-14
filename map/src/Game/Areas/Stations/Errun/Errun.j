library Errun requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create() 
        call gameSpace.addRect(gg_rct_MoonRect) 
        call station.addGameSpace(gameSpace)

        call station.addDock(gg_dest_DTrx_3136) 
        call station.addDock(gg_dest_DTrx_3141) 
        call station.addDock(gg_dest_DTrx_3126) 
        call station.addDock(gg_dest_DTrx_3131) 

        call station.initialize() 
        return station 
    endfunction 
endlibrary 
