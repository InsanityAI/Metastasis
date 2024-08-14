library KYO requires Station, SimpleGameSpace
    globals
        public Station station
    endglobals

    public function Initialize takes nothing returns Station
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create()
        call gameSpace.addRect(gg_rct_ST3V1) 
        call gameSpace.addRect(gg_rct_ST3V2) 
        call gameSpace.addRect(gg_rct_ST3V3) 
        call gameSpace.addRect(gg_rct_ST3V4) 
        call gameSpace.addRect(gg_rct_ST3V5) 
        call gameSpace.addRect(gg_rct_ST3V6) 
        call station.addGameSpace(gameSpace)

        call station.addDock(gg_dest_DTrx_0657)
        call station.addDock(gg_dest_DTrx_0668)
        call station.addDock(gg_dest_DTrx_0230) //used to be dock[34]
        call station.initialize()
        return station
    endfunction
endlibrary