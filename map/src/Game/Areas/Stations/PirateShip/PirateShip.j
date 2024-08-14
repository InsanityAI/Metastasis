library PirateShip requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create() 
        call gameSpace.addRect(gg_rct_PirateShip) 
        call station.addGameSpace(gameSpace)

        call station.addDock(gg_dest_DTrx_9311) 
        call station.addDock(gg_dest_DTrx_9316) 
        call station.addDock(gg_dest_DTrx_2150) 
        call station.addDock(gg_dest_DTrx_2156) 

        call station.initialize() 
        return station 
    endfunction 
endlibrary

