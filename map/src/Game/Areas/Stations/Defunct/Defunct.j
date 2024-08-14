library Defunct requires Station, SimpleGameSpace
    globals
        public Station station
    endglobals

    public function Initialize takes nothing returns Station
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create()
        call gameSpace.addRect(gg_rct_ST2V1) 
        call gameSpace.addRect(gg_rct_ST2V2) 
        call station.addGameSpace(gameSpace)

        call station.addDock(gg_dest_DTrx_0450)
        call station.addDock(gg_dest_DTrx_0461)
        call station.initialize()
        return station
    endfunction
endlibrary