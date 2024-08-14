library Arbitress requires Station, SimpleGameSpace
    globals
        public Station station
    endglobals

    public function Initialize takes nothing returns Station
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create()
        call gameSpace.addRect(gg_rct_STV1) 
        call gameSpace.addRect(gg_rct_STV2) 
        call gameSpace.addRect(gg_rct_STV3) 
        call gameSpace.addRect(gg_rct_STV4) 
        call gameSpace.addRect(gg_rct_STV5) 
        call gameSpace.addRect(gg_rct_STV6) 
        call gameSpace.addRect(gg_rct_STV7) 
        call gameSpace.addRect(gg_rct_ST1V8) 
        call gameSpace.addRect(gg_rct_ST1V9) 
        call station.addGameSpace(gameSpace)

        call station.addDock(gg_dest_DTrx_0232)
        call station.addDock(gg_dest_DTrx_0243)
        call station.addDock(gg_dest_DTrx_0235)
        call station.addDock(gg_dest_DTrx_0257)

        //Android pad
        call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642) 
        call station.initialize()
        return station
    endfunction
endlibrary